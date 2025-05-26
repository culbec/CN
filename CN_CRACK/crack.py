import os
import zipfile
import argparse
import threading
from tqdm import tqdm
from concurrent.futures import ThreadPoolExecutor, as_completed

RESULT_PATH = os.path.realpath(os.path.join(os.getcwd(), "results"))


def prepare_parser():
    parser = argparse.ArgumentParser(
        description="Crack a password-protected zip file using a wordlist."
    )
    parser.add_argument(
        "-k", "--keylist", type=str, required=True, help="Path to the wordlist file."
    )
    parser.add_argument(
        "-a", "--archive", type=str, required=True, help="Path to the zip file."
    )
    parser.add_argument(
        "-t", "--threads", type=int, default=4, help="Number of threads to use."
    )
    return parser


def try_passwords(archive_path, words, found_event, result_holder, progress, lock):
    for word in words:
        if found_event.is_set():
            break
        try:
            with zipfile.ZipFile(archive_path) as archive:
                archive.extractall(
                    path=os.path.join(
                        RESULT_PATH, os.path.splitext(os.path.basename(archive_path))[0]
                    ),
                    pwd=word.encode("utf-8"),
                )
            # Success!
            result_holder["password"] = word
            found_event.set()
            break
        except RuntimeError as e:
            if "Bad password" in str(e) or "encrypted" in str(e):
                pass
        except Exception:
            pass
        finally:
            # Update the shared progress bar safely
            with lock:
                progress.update(1)


def crack_password_multithreaded(keylist, archive_path, num_threads):
    found_event = threading.Event()
    result_holder = {}

    with open(keylist, "r", encoding="utf-8", errors="ignore") as f:
        words = [line.strip() for line in f if line.strip()]

    chunk_size = (len(words) + num_threads - 1) // num_threads
    chunks = [words[i : i + chunk_size] for i in range(0, len(words), chunk_size)]

    os.makedirs(RESULT_PATH, exist_ok=True)

    progress = tqdm(
        total=len(words), desc="Trying passwords", unit="pwd", dynamic_ncols=True
    )
    progress_lock = threading.Lock()

    with ThreadPoolExecutor(max_workers=num_threads) as executor:
        futures = [
            executor.submit(
                try_passwords,
                archive_path,
                chunk,
                found_event,
                result_holder,
                progress,
                progress_lock,
            )
            for chunk in chunks
        ]
        for _ in as_completed(futures):
            if found_event.is_set():
                for fut in futures:
                    if not fut.done():
                        fut.cancel()
                break

    progress.close()

    if "password" in result_holder:
        return True, result_holder["password"]
    return False, None


if __name__ == "__main__":
    parser = prepare_parser()
    args = parser.parse_args()

    if not os.path.isfile(args.keylist):
        print(f"Error: keylist '{args.keylist}' not found.")
        exit(1)
    if not os.path.isfile(args.archive):
        print(f"Error: archive '{args.archive}' not found.")
        exit(1)

    with open(args.keylist, "r", encoding="utf-8", errors="ignore") as f:
        total = sum(1 for _ in f)
    print("PASSWORDS IN FILE |", total)
    print("             FILE |", args.archive)

    ok, res = crack_password_multithreaded(args.keylist, args.archive, args.threads)
    if ok:
        print("\033[96m          SUCCESS\033[0m |", res)
    else:
        print("\033[91m[!] PASSWORD NOT FOUND or ERROR:", res or "None\033[0m")
