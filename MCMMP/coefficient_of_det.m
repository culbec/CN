function r_squared = coefficient_of_det(predicted, target)
    mean_target = mean(target);
    tss = sum((target - mean_target).^2);

    rss = residual_sum_squares(predicted, target);
    r_squared = 1 - rss / tss;
end
