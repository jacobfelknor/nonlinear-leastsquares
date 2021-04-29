function ret = dfdmu(t, q, sigma, mu)
   eterm = exp(-((t-mu)/2*(sigma^2))); % I stored this value for readability
   ret = (q * eterm * (t - mu)) / (sqrt(2*pi) * sigma^3);
end

