close all; clear; clc

% Test problem
g = [-1.62,0,0]';
w = [2.7 * 10^-6,0,0]';
alpha = 1 / (311 * 9.81);
Tmax = 27024;
theta = pi/2; % Max gimbal angle
m0 = 10334; % Mass with propelant [kg]
mf = 10334 - 8200; % Empty mass [kg]
x0 = [20000,400,500,0,0,0]'; % Initial Position
dt = 1e-1;

% Dynamics
S = [0,-w(3),w(2); w(3),0,-w(1);-w(2),w(1),0];
A = [zeros(3,3),eye(3);-S^2,-2*S];
B = [zeros(3,3);eye(3)];

% Genetic params
pop_size = 100;
population = init_lqr_population(A,B,pop_size);
%load('../data/best_population.mat')
max_iter = 35;
mutation_prob = 0.1;
cost_weights = [1,10,200/m0];

%%
L = zeros(pop_size,max_iter);
tic;
min_loss = [];
for k=1:max_iter
    fprintf("Iter %d\n",k);
    losses = zeros(pop_size,1);
    for i=1:pop_size
        K = population(:,:,i);
        [x,u,m,t] = simulate_feedback(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt);
        losses(i) = evaluate_trajectory(x(:,end),m(end),m0,cost_weights);
    end
    L(:,k) = losses;
    min_loss = [min_loss, min(losses)];
    weights = sum(losses) ./ losses;
    weights = weights ./ sum(weights);
    population = resample_population(population,weights,mutation_prob);
end
toc

%%
best_loss = inf;
for i=1:pop_size
    K = population(:,:,i);
    [x,u,m,t] = simulate_feedback(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt);
    loss = evaluate_trajectory(x(:,end),m(end),m0,cost_weights);
    if loss < best_loss
        best_loss = loss;
        bestK = K;
        bestX = x;
        bestU = u;
        bestM = m;
        bestT = t;
    end
end

figure
plot(1:length(min_loss),min_loss,'linewidth',1.5)
xlabel('Generation','fontsize',14)
ylabel('Loss','fontsize',14)
%xlim([1,100])

[x,u,m,t] = simulate_noise(w,g,x0,m0,mf,alpha,theta,Tmax,bestK,dt,10000);
plot_trajectory(x,u,m,t,g,false,'../figures/genetic/ff_');
