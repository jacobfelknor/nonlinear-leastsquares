function ret = q(t, q,sigma, mu)
    coeff = q/(sigma*sqrt(2*pi));
    ret = coeff * exp( -1/2 * ((t - mu)/sigma).^2 ); 
end

