function ret = dfdsigma(t, q, sigma, mu)
   eterm = exp(-((t-mu)/2*(sigma^2))); % I stored this value since it was repeated
   ret = q / sqrt(2*pi) * (-eterm / sigma^2 + (eterm * (t - mu)^2) / sigma^4);
end

