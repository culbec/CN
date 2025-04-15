function rss = residual_sum_squares(predicted, target)
    % norma euclidiana la patrat, mai usor
    rss = norm(predicted - target)^2;
end