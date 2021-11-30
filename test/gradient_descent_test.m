close all; clear; clc

% Test problem
g = [-10,0,0]';
w = [0,1e-3,0]';
alpha = 5e-4;
Tmax = 24000; % Max thrust [N]
theta = pi/2; % Max gimbal angle
m0 = 2000; % Mass with propelant [kg]
mf = 300; % Empty mass [kg]
x0 = [10000,0,0,0,0,0]'; % Initial Position
dt = 1e-1;
cost_weights = [0.5,1,0.1];

% LQR
Q = [eye(3),zeros(3,3);zeros(3,3),990*eye(3)];
R = eye(3);
S = [0,-w(3),w(2); w(3),0,-w(1);-w(2),w(1),0];
A = [zeros(3,3),eye(3);-S^2,-2*S];
B = [zeros(3,3);eye(3)];
C = eye(6);
P = icare(A,B,Q,R);
K = inv(R) * B' * P;
%K = zeros(3,6);

% Gradient descent params
delta = 1e-3;
step_size = 2*delta;
max_iter = 50;

losses = [];

%K = -1 + 2*rand(3,6);
for i=1:max_iter
    [gradK,curr_loss] = get_gradient(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt,cost_weights,delta);
    gradK = gradK / norm(gradK);
    K = K - step_size * gradK;
    losses = [losses,curr_loss];
end

[x,u,m,t] = simulate_feedback(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt);

figure
plot(losses)

figure
plot(t,x(1:3,:))
legend('x','y','z')

figure
plot(t,x(4:6,:))
legend('v_x','v_y','v_z')

figure
plot(t,u)
legend('u_x','u_y','u_z')
