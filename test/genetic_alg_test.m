close all; clear; clc

% Test problem
g = [-10,0,0]';
w = [0,1e-3,0]';
alpha = 5e-4;
Tmax = 24000;
theta = pi/2; % Max gimbal angle
m0 = 2000; % Mass with propelant [kg]
mf = 300; % Empty mass [kg]
x0 = [10000,0,0,0,0,0]'; % Initial Position
dt = 1e-1;

% Genetic params
pop_size = 10;
cost_weights = [1,2,0.5];
max_iter = 100;
pop = -1 + 2*rand(pop_size,3,6);

min_loss = [];
for k=1:max_iter
    losses = zeros(pop_size,1);
    for i=1:pop_size
        K = reshape(pop(i,:,:),[3,6]);
        [x,u,m,t] = simulate_feedback(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt);
        losses(i) = evaluate_trajectory(x(:,end),m(end),m0,cost_weights);
    end
    min_loss = [min_loss, min(losses)];
    weights = 1 - losses/sum(losses);
    pop = resample_population(pop,weights);
end

plot(1:length(min_loss),min_loss)