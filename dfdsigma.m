function ret = dfdsigma(t, q, sigma, mu)
   eterm = exp(-((t - mu)^2/(2*sigma^2))); % I stored this value since it was repeated
   ret = q / (sqrt(2*pi) * sigma^4) * (t - mu)^2 * eterm - q * eterm / (sqrt(2*pi) * sigma^2);
end
