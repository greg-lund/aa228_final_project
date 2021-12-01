
% CHANGES WITH ROTATION
% THIS IS THE FILE TO RUN

clear
clc
close all

addpath(genpath("codegen"))

%% Initialize the rocket

% These are the specs for the Apollo 11 lunar lander!

m_rocket = 10334; % kg
m_fuel = 8200; % kg
g_earth = 9.81; % m/s^2
g_moon = 1.62; % m/s^2
Isp = 311; % s
T_max = 27024; % N
m_empty = m_rocket - m_fuel; % kg

% My x, y and z coordinates follow a regular coordinate grid right now (z
% points up). To include rotation, change these to the right coordinate
% system and apply the x_dot = Ax + B(T + g_vec) thing that's in the paper.

x_start = -400; % m
y_start = 500; % m
z_start = 20000; % m

% For the lunar lander, adding initial velocity greatly pushes up the
% computational time; I have another example (2020-2021 UCLA Rocket Project
% rocket that's dropped from 10,000 ft) that's a lot cleaner and faster
% than this.

vx_start = 0/sqrt(2); % m/s
vy_start = 0/sqrt(2); % m/s
vz_start = 0; % m/s

dyn_start = [x_start; y_start; z_start; vx_start; vy_start; vz_start]; % state vector

%% Initialize the Simulation

K = compute_lqr(); % Get the first K value from LQR

dt = 0.01; % Simulation time step (s)
dt_MPC = 5; % How often the MPC updates (s)

t = 0:dt:500; % time (s) - longer than needed to preallocate memory
m = zeros(size(t)); % current mass (kg)

m(1) = m_rocket; % Initialize current mass

% Initialize state vectors

x = zeros(size(t));
y = zeros(size(t));
z = zeros(size(t));

x(1) = x_start;
y(1) = y_start;
z(1) = z_start;

vx = zeros(size(t));
vy = zeros(size(t));
vz = zeros(size(t));

vx(1) = vx_start;
vy(1) = vy_start;
vz(1) = vz_start;

thrust = zeros(3, length(t)); % Thrust vector (N)

%% Run MPC

i = 1;
while z(i) > 0 % Stop when the rocket hits the ground
    
    str = num2str(t(i));
    fprintf("Time: " + str + "\n"); % Print the current time
    
    dyn = [x(i); y(i); z(i); vx(i); vy(i); vz(i)]; % Current state vector
    
    % Seed the last K value into Hooke-Jeeves and modify it to get the
    % optimal linear feedback policy given the current state (if the
    % current time is an MPC updating time step). u = -Kx, where x consists
    % of x, y, z, vx, vy, vz and u is the acceleration vector [ax, ay, az].
    
    if mod(t(i), dt_MPC) == 0
        [K, rewards] = hooke_jeeves(K, m(i), m_fuel-(m_rocket-m(i)), g_moon, Isp, T_max, dyn);
    end
    
    % Integrate to next time step
    
    if m(i) > m_empty
        T = m(i)*(-K{1}*dyn + [0; 0; g_moon]); % Calculate thrust from K
        T(3) = max([T(3) 0]); % Don't thrust into the body
        T_mag = sqrt(T(1)^2 + T(2)^2 + T(3)^2); % Find the current thrust magnitude
        T = T * min([T_max/T_mag 1]); % Clamp the thrust to the maximum value
        T_mag = sqrt(T(1)^2 + T(2)^2 + T(3)^2); % Recalculate the updated thrust magnitude
    else
        T = zeros(3,1); % There is no fuel left, so no thrust
        T_mag = 0;
    end

    a = T/m(i) - [0; 0; g_moon]; % Acceleration (m/s^2)
    thrust(:,i) = T; % Record the current thrust
    
    % Euler integration to calculate the next state vector
    
    x(i+1) = x(i) + vx(i)*dt;
    y(i+1) = y(i) + vy(i)*dt;
    z(i+1) = z(i) + vz(i)*dt;
    
    vx(i+1) = vx(i) + a(1)*dt;
    vy(i+1) = vy(i) + a(2)*dt;
    vz(i+1) = vz(i) + a(3)*dt;
    
    m(i+1) = m(i) - T_mag/(Isp*g_earth)*dt; % Update the mass (alpha = 1/(Isp*g_earth) by definition)
    
    i = i + 1;
    
end

%% Plots

figure
plot(t(1:i), x(1:i))
grid on
xlabel("Time (s)")
ylabel("x (m)")

figure
plot(t(1:i), y(1:i))
grid on
xlabel("Time (s)")
ylabel("y (m)")

figure
plot(t(1:i), z(1:i))
grid on
xlabel("Time (s)")
ylabel("z (m)")



