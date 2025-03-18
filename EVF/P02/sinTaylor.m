function [sin_normal, base_sinTaylor, better_sinTaylor] = sinTaylor(x)
    format long;
    
    fprintf("x = %.16e\n", vpa(x, 16));

    base_sinTaylor = baseSinTaylor(x);
    better_sinTaylor = betterSinTaylor(x);
    sin_normal = sin(x);

    fprintf("Normal sin(x)                            = %.16e\n", sin_normal);
    fprintf("Base sin(x) using Taylor                 = %.16e\n", base_sinTaylor);
    fprintf("Better sin(x) using Taylor (with reduce) = %.16e\n\n", better_sinTaylor);

    fprintf("========= ERRORS =========\n");
    fprintf("Normal vs. Base    = %.16e\n", abs(sin_normal - base_sinTaylor));
    fprintf("Normal vs. Better  = %.16e\n", abs(sin_normal - better_sinTaylor));
    fprintf("Base   vs. Better  = %.16e\n\n", abs(base_sinTaylor - better_sinTaylor));

end