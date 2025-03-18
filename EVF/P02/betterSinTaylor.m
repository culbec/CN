function bbsT = betterSinTaylor(x)
    % Computes sin(x) in a better way, taking in account that the Taylor
    % functions works better when the input is closer to 0
    [reduced, quadrant] = reduceToFirstQuadrant(x);
    
    % sin and cos are mirrored around pi/4, so for an accurate computation
    % we can use that to either compute sin(x) or cos(pi/2 - x), so that we
    % always use the smallest value between the two
    if reduced > pi / 4
        % Use cos(pi / 2 - x), which is smaller
        bbsT = baseCosTaylor(pi / 2 - reduced);
    else
        % Use sin(x)
        bbsT = baseSinTaylor(reduced);
    end

     % Check the quadrant of the reduced and multiply by -1 if sin is
     % negative in there
     if quadrant == 3 || quadrant == 4
         bbsT = -1 * bbsT;
     end
end