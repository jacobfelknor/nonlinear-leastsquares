clear;
clc;
format long;
data = xlsread("OilProductionData.xls");
us_oil = data(:, 1:2);      % first two columns of data
world_oil = data(:, [1 3]); % first and third columns of data
N = size(data, 1);          % number of samples
A = zeros(N, 3);            % preallocate some matricies
R = zeros(N, 1);            % "  "
YEAR_MIN = data(1:1);
% initial guesses
q_prime = 270000000; % times 10^3 for final ans
sigma_prime = 3.0; % times 10 for final ans
mu_prime = 1.970; % times 10^3 for final ans

% single iteration for now, but will iterate until convergence eventually
for t = data(:,1)'
   % populate A
   ii = t - YEAR_MIN + 1; % derive index from year
   t_prime = t/1e3;       % scale t for usablilty
   A(ii, 1) = dfdq(t, q_prime, sigma_prime, mu_prime);
   A(ii, 2) = dfdsigma(t, q_prime, sigma_prime, mu_prime);
   A(ii, 3) = dfdmu(t, q_prime, sigma_prime, mu_prime);
   % populate R
   R(ii) = us_oil(ii, 2) - q(t, q_prime, sigma_prime, mu_prime);
end
% find the least squares sol. the system for our deltas A*delta = R
delta = (A'*A)^-1*A'*R;
% update our parameters
q_prime = q_prime + delta(1);
sigma_prime = sigma_prime + delta(2);
mu_prime = mu_prime + delta(3);