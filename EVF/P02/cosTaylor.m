function [cos_normal, base_cosTaylor, better_cosTaylor] = cosTaylor(x)
    format long;

    fprintf("x = %.16e\n", vpa(x, 16));

    base_cosTaylor = baseCosTaylor(x);
    better_cosTaylor = betterCosTaylor(x);
    cos_normal = cos(x);

    fprintf("Normal cos(x)                            = %.16e\n", cos_normal);
    fprintf("Base cos(x) using Taylor                 = %.16e\n", base_cosTaylor);
    fprintf("Better cos(x) using Taylor (with reduce) = %.16e\n\n", better_cosTaylor);

    fprintf("========= ERRORS =========\n");
    fprintf("Normal vs. Base    = %.16e\n", abs(cos_normal - base_cosTaylor));
    fprintf("Normal vs. Better  = %.16e\n", abs(cos_normal - better_cosTaylor));
    fprintf("Base   vs. Better  = %.16e\n\n", abs(base_cosTaylor - better_cosTaylor));
end