function [eps_, realmax_, realmin_normalized, realmin_denormalized] = computeVFConstants()
    format long;

    eps_ = vf_eps();
    realmax_ = vf_realmax();
    realmin_normalized = vf_realmin_normalized();
    realmin_denormalized = vf_realmin_denormalized();

    m_eps = eps;
    m_realmax = realmax;
    m_realmin_normalized = realmin;
    m_realmin_denormalized = realmin * eps; % [0, beta^eps]

    fprintf('My eps: %.16e\n', eps_);
    fprintf("Machine's eps: %.16e\n", m_eps);
    fprintf("Error: %.16e\n\n", abs(m_eps - eps_));

    fprintf('My realmax: %.16e\n', realmax_);
    fprintf("Machine's realmax: %.16e\n", m_realmax);
    fprintf("Error: %.16e\n\n", abs(m_realmax - realmax_));

    fprintf('My normalized realmin: %.16e\n', realmin_normalized);
    fprintf("Machine's normalized realmin: %.16e\n", m_realmin_normalized);
    fprintf('Error: %.16e\n\n', abs(m_realmin_normalized - realmin_normalized));

    fprintf('My denormalized realmin: %.16e\n', realmin_denormalized);
    fprintf("Machine's denormalized realmin: %.16e\n", m_realmin_denormalized);
    fprintf('Error: %.16e\n\n', abs(m_realmin_denormalized - realmin_denormalized));
end

function eps_ = vf_eps()
    % Computes the system's epsilon
    m = 1.0;
    
    while 1.0 + (m / 2) > 1.0
        m = m / 2;
    end

    eps_ = m;
end

function realmax_ = vf_realmax()
    % Computes the biggest number in VF that the system can represent

    % Starting with 1 and doubling the value until we reach infinity
    val = 1.0;
    
    while isfinite(val * 2)
        val = val * 2;
    end

    % Now the double of the number overflows, so its time to increment
    % the number with smaller values
    inc_val = val;

    % Bit arithmetic might result in a number that overflows,
    % so for a safe computation we will keep the previous value
    % before the increment
    prev_val = val;

    % Incrementing the value until the incrementation value becomes
    % too small: until the distance between val and the next floating point
    % greater value is greater than the incrementation value
    while inc_val > eps(val)
        inc_val = inc_val / 2;
        if isfinite(val + inc_val)
            val = val + inc_val;
        else
            val = prev_val;
        end
    end

    realmax_ = val;
end

function realmin_normalized = vf_realmin_normalized()
    % Computes the smallest normalized VF number that the system can
    % represent

    % Starting with 1.0 and halving the number until there is no
    % representation error
    val = 1.0;

    while val * (1.0 + eps) > val
        val = val / 2;
    end

    % Multiplying by two because we reached a number which satisfies x = y,
    % although x != y, that means there is an error in computation
    realmin_normalized = val * 2;
end

function realmin_denormalized = vf_realmin_denormalized()
    % Computes the smallest denormalized VF number that the system can
    % represent

    % Starting with the smallest normalized VF number and halving until we
    % fine approach 0
    val = vf_realmin_normalized();

    while val / 2 > 0
        val = val / 2;
    end
    
    realmin_denormalized = val;
end