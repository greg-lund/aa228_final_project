close all; clear; clc

% Test problem
g = [-10,0,0]';
w = [0,1e-3,0]';
alpha = 5e-4;
Tmax = 24000;
rho1 = 0.2 * Tmax; % Min thrust [N]
rho2 = 0.8 * Tmax; % Max thrust [N]
theta = pi/2; % Max gimbal angle
m0 = 2000; % Mass with propelant [kg]
mf = 300; % Empty mass [kg]
vmax = 1e4; % Maximum velocity allowed [m/s]
glide_slope = pi/4; % Bound allowable positions via cone [rad]

%x0 = [2400,450,-330,-10,-40,10]';
x0 = [10000,0,0,0,0,0]';
goal = [0,0,0]';

%[Tc,x] = optimize_thrust(w,g,x0,goal,m0,mf,alpha,rho1,rho2,theta,vmax,glide_slope);

Q = 2*eye(6);
R = eye(3);

%% Plot
dt = 1e-2;
tmax = 100;
t = 0:dt:tmax;

Tc = @(t) zeros(3,1);

[xs,ms] = simulate_thrust(w,g,x0,m0,alpha,t,Tc);

S = [0,-w(3),w(2); w(3),0,-w(1);-w(2),w(1),0];
A = [zeros(3,3),eye(3);-S^2,-2*S];
B = [zeros(3,3);eye(3)];
C = eye(6);

P = icare(A,B,Q,R);
K = inv(R) * B' * P;
Acl = A - B*K;

sys = ss(Acl,B,C,0);
u = zeros(length(t),3);
%xl = lsim(sys,u,t,x0);
[xc,uc] = sim_lqr(A,B,K,0,24000,t,x0);


end_idx = find(xs(1,:) < 0, 1);
end_idx_c = find(xc(1,:) < 0, 1);
if length(end_idx_c) == 0
    end_idx_c = length(t);
end
%%
figure
subplot(1,2,1)
plot(t(1:end_idx),xs(1:3,1:end_idx)./1000,'linewidth',1.5)
legend('X','Y','Z','location','best')
xlabel('Time [s]')
ylabel('Position [km]')

subplot(1,2,2)
plot(t(1:end_idx),xs(4:6,1:end_idx)./1000,'linewidth',1.5)
legend('$\dot{X}$','$\dot{Y}$','$\dot{Z}$','location','best','interpreter','latex')
xlabel('Time [s]')
ylabel('Velocity [km/s]')

% Feedback

figure
subplot(1,2,1)
plot(t(1:end_idx_c),xc(1:3,1:end_idx_c)./1000,'linewidth',1.5)
legend('X','Y','Z','location','best')
xlabel('Time [s]')
ylabel('Position [km]')

subplot(1,2,2)
plot(t(1:end_idx_c),xc(4:6,1:end_idx_c)./1000,'linewidth',1.5)
legend('$\dot{X}$','$\dot{Y}$','$\dot{Z}$','location','best','interpreter','latex')
xlabel('Time [s]')
ylabel('Velocity [km/s]')

figure
plot(t(1:end_idx_c),uc(:,1:end_idx_c) * m0 ./ 1000,'linewidth',1.5)
legend('T_x','T_y','T_z','location','best')
xlabel('Time [s]')
ylabel('Thrust [kN]')