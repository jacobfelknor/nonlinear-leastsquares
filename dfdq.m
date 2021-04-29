function ret = dfdq(t, q, sigma, mu)
    % q is actually independent
    ret = exp(-((t-mu) / 2*sigma)^2) / (sqrt(2*pi)*sigma);
end

