% Desired Gain Margin and Phase Margin
GM_desired = 2; % Desired Gain Margin in 1/|gc(jw)|
PM_desired = 45; % Desired Phase Margin in degrees

% Optimization bounds
lb = [0.001, 0.001, 0.001]; % Lower bounds for Kp, Ti, Td
ub = [10, 10, 10]; % Upper bounds for Kp, Ti, Td
% Optimization options using Particle Swarm Optimization (PSO)
options = optimoptions('particleswarm', 'SwarmSize', 50, 'MaxIter', 100, 'UseParallel', true);

% Optimization function
opt_func = @(x) cost_function(x(1), x(2), x(3), GM_desired, PM_desired);

% PSO optimization
[x_opt, fval_opt] = particleswarm(opt_func, 3, lb, ub, options);

% Display optimized parameters and results
disp(['Optimized Kp: ', num2str(x_opt(1))]);
disp(['Optimized Ti: ', num2str(x_opt(2))]);
disp(['Optimized Td: ', num2str(x_opt(3))]);

% Compute Gain Margin and Phase Margin with optimized parameters
[GM_opt, PM_opt] = compute_margins(x_opt(1), x_opt(2), x_opt(3));

disp(['Optimized Gain Margin (1/|gc(jw)|): ', num2str(GM_opt)]);
disp(['Optimized Phase Margin (degrees): ', num2str(PM_opt)]);
disp(['GM Error: ', num2str(abs(GM_opt - GM_desired))]);
disp(['PM Error: ', num2str(abs(PM_opt - PM_desired))]);

% Define the optimized PID controller
s = tf('s');
PID_opt = x_opt(1) + (x_opt(1) / (x_opt(2) * s)) + ((x_opt(1) * x_opt(3) * s) / (((x_opt(3) / 10) * s) + 1));

% Closed-loop transfer function
G = 63 / ((s + 0.5) * (s + 2) * (s + 4)); % Example plant
L_opt = PID_opt * G;

%  Local Functions
function cost = cost_function(Kp,Ti,Td, GM_desired, PM_desired)
    % Compute Gain Margin and Phase Margin
    [GM, PM] = compute_margins(Kp,Ti,Td);
    
    % Compute normalized errors
    GM_error = abs((GM - GM_desired) / GM_desired);
    PM_error = abs((PM - PM_desired) / PM_desired);

    % Total cost
    cost = GM_error^2 + PM_error^2;
end

function [GM, PM] = compute_margins(Kp,Ti,Td)
    % Define the plant (example system)
    s = tf('s');
    G = 63 / ((s + 0.5) * (s + 2) * (s + 4)); % Example plant

    % Define PID controller
    PID = Kp + (Kp / (Ti * s)) + ((Kp * Td * s) / (((Td / 10) * s) + 1));

    % Open-loop transfer function
    L = PID * G;

    % Compute Gain Margin and Phase Margin
    [GM, PM,~,~] = margin(L);
end


% Optimized Kp: 0.1551
% Optimized Ti: 0.12238
% Optimized Td: 2.6331
