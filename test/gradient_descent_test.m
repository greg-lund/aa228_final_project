close all; clear; clc

% Test problem
g = [-10,0,0]';
w = [0,1e-3,0]';
alpha = 5e-4;
Tmax = 24000; % Max thrust [N]
theta = pi/2; % Max gimbal angle
m0 = 2000; % Mass with propelant [kg]
mf = 300; % Empty mass [kg]
x0 = [10000,1000,1000,0,10,-10]'; % Initial Position
dt = 1e-1;
cost_weights = [0.5,10,0.1];

% LQR
Q = diag([1,1,1,1000,1000,1000]);
R = eye(3);
S = [0,-w(3),w(2); w(3),0,-w(1);-w(2),w(1),0];
A = [zeros(3,3),eye(3);-S^2,-2*S];
B = [zeros(3,3);eye(3)];
C = eye(6);
P = icare(A,B,Q,R);
K = inv(R) * B' * P;

% Gradient descent params
delta = 1e-3;
step_size = 2*delta;
max_iter = 50;

% Model uncertainty params
mu = [0,0,0,0,0,0];
sigma = 5*diag([10*dt,10*dt,10*dt,dt,dt,dt]);

%[K,loss] = run_gradient_descent(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt,cost_weights,delta,step_size,max_iter);

%[x,u,m,t] = simulate_feedback(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt);
[x,u,m,t] = simulate_noise(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt,mu,sigma,10000);

figure
plot(t,x(1:3,:) ./ 1000)
legend('x','y','z')
xlabel('Time [s]')
ylabel('Position [km]')

figure
plot(t,x(4:6,:))
legend('v_x','v_y','v_z')
xlabel('Time [s]')
ylabel('Velocity [m/s]')

figure
plot(t,(u-g).*m ./ 1000)
legend('T_x','T_y','T_z')
xlabel('Time [s]')
ylabel('Thrust input [kN]')
