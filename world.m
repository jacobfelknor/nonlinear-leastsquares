close all;
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
YEAR_MAX = 2100;
% initial guesses
q_prime = 1500000; % times 10^3 for final ans
sigma_prime = 40;
mu_prime = 2000;
na = 0;

% single iteration for now, but will iterate until convergence eventually
iterations = 1000;
for dummy = 1:iterations
    for t = data(:,1)'
       
       ii = t - YEAR_MIN + 1; % derive index from year
       % check to make sure it is not NaN 
       na = isnan(world_oil(ii, 2));
       if na == 0
           % populate A
           A(ii, 1) = dfdq(t, q_prime, sigma_prime, mu_prime);
           A(ii, 2) = dfdsigma(t, q_prime, sigma_prime, mu_prime);
           A(ii, 3) = dfdmu(t, q_prime, sigma_prime, mu_prime);
           % populate R
           R(ii) = world_oil(ii, 2) - q(t, q_prime, sigma_prime, mu_prime);
       end
       
       
    end
    % find the least squares sol. the system for our deltas A*delta = R
    delta = (A'*A)^-1*A'*R;
    % update our parameters
    q_prime = q_prime + delta(1);
    sigma_prime = sigma_prime + delta(2);
    mu_prime = mu_prime + delta(3);
end

% check when production falls beneath 5%
production_curve = q(YEAR_MIN:YEAR_MAX, q_prime, sigma_prime, mu_prime);
max_production = max(production_curve);
five_percent = max_production * 0.05;
run_out_index = find(flip(production_curve) > five_percent, 1);
actual_year = YEAR_MAX - run_out_index;
x = YEAR_MIN:YEAR_MAX;
figure
plot(x, production_curve);
xlabel('Year')
ylabel('Oil production (millons of barrels)')
hold on
q(mu_prime, q_prime, sigma_prime, mu_prime)
plot(mu_prime, q(mu_prime, q_prime, sigma_prime, mu_prime), 'r*');
str = sprintf(' Max Production: mu=%f', mu_prime);
text(mu_prime, q(mu_prime, q_prime, sigma_prime, mu_prime), str);
plot(actual_year, q(actual_year, q_prime, sigma_prime, mu_prime), 'r*');
str = sprintf(' "Ran out" at year %d', actual_year);
text(2020, 0.5e6, str);