% CHANGES WITH ROTATION
% THIS IS THE FILE TO RUN

clear
clc
close all

addpath(genpath("codegen"))
tic;

%% Initialize the rocket parameters

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

% Updated to x,y,z coordinate system of paper (x points up).

x_start = 20000; % m
y_start = -400; % m
z_start = 500; % m

% For the lunar lander, adding initial velocity greatly pushes up the
% computational time; I have another example (2020-2021 UCLA Rocket Project
% rocket that's dropped from 10,000 ft) that's a lot cleaner and faster
% than this.

vx_start = 0/sqrt(2); % m/s
vy_start = 0/sqrt(2); % m/s
vz_start = 0; % m/s

dyn_start = [x_start; y_start; z_start; vx_start; vy_start; vz_start]; % state vector

% latitude (90N to 90S -> +90 to -90 degrees)
lat = 0;

%% Initialize dynamics matrices

% Angular velocity of the moon (rad/s) 
omega_moon = 2.7 * 10^-6;
% Angular velocity vector in ECI fram (rad/s);
w_I = [omega_moon; 0; 0];

% Update angle of rotation (theta) given latitude
if lat >= 0
    theta = 90 - lat;
elseif lat < 0 
    theta = 90 + abs(lat);
end
theta = deg2rad(theta);

% Rotation matrix for rotation of theta about e3 unit vector
A = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];
% Rotated angular velocity vector in target reference frame(rad/s)
w_T = A * w_I;

Sw = [0 -w_T(3) w_T(2); w_T(3) 0 -w_T(1); -w_T(2) w_T(1) 0]; 
M0 = zeros(3);
I = eye(3);
A = [M0 I; -Sw^2 -2*Sw];
B = [M0; I];

% gravitational acceleration vector (m/s^2)
g = [-g_moon; 0; 0];

%% Initialize the Simulation

K = compute_lqr(lat, omega_moon); % Get the first K value from LQR

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
while x(i) > 0 % Stop when the rocket hits the ground
    
    str = num2str(t(i));
    fprintf("Time: " + str + "\n"); % Print the current time
    
    state = [x(i); y(i); z(i); vx(i); vy(i); vz(i)]; % Current state vector
    
    % Seed the last K value into Hooke-Jeeves and modify it to get the
    % optimal linear feedback policy given the current state (if the
    % current time is an MPC updating time step). u = -Kx, where x consists
    % of x, y, z, vx, vy, vz and u is the acceleration vector [ax, ay, az].
    
    if mod(t(i), dt_MPC) == 0
        [K, rewards] = hooke_jeeves(K, m(i), m_fuel-(m_rocket-m(i)), g_moon, Isp, T_max, state, omega_moon, lat);
    end
    
    % Integrate to next time step
    
    if m(i) > m_empty
        T = m(i)*(-K{1}*state + [g_moon; 0; 0]); % Calculate thrust from K
        T(1) = max([T(1) 0]); % Don't thrust into the body
        T_mag = sqrt(T(1)^2 + T(2)^2 + T(3)^2); % Find the current thrust magnitude
        T = T * min([T_max/T_mag 1]); % Clamp the thrust to the maximum value
        T_mag = sqrt(T(1)^2 + T(2)^2 + T(3)^2); % Recalculate the updated thrust magnitude
    else
        T = zeros(3,1); % There is no fuel left, so no thrust
        T_mag = 0;
    end

%     T = [0; 0; 0];
    thrust(:,i) = T; % Record the current thrust

    % Dynamics model
    
    % [vx; vy; vz; ax; ay; az]
    dstate = A*state + B*(g + T/m(i));
    
    vx(i) = dstate(1); % Velocity (m/s)
    vy(i) = dstate(2); 
    vz(i) = dstate(3);
    a = dstate(4:6); % Acceleration (m/s^2)
    
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

%% Plots & relevant reward metrics

% Print the compute time
time2compute = toc;
str_compute = num2str(time2compute);
fprintf("Time to compute: " + str_compute + " seconds\n"); 

% Print the fuel consumed
fuel_consumed = m(1)-m(i);
str_fuel = num2str(fuel_consumed);
fprintf("Fuel consumed: " + str_fuel + " kg\n");

% Print Final position error
final_pos = [x(i); y(i); z(i)];
pos_error = norm(final_pos);
str_pos_error = num2str(pos_error);
fprintf("Final position error: " + str_pos_error + " m\n");

% Print final velocity
final_vel = [vx(i); vy(i); vz(i)];
vel_mag = norm(final_vel);
str_vel = num2str(vel_mag);
fprintf("Final velocity: " + str_vel + " \n");

figure
plot(t(1:i), x(1:i))
grid on
xlabel("Time (s)")
ylabel("x (m)")
title('Altitude vs. Time')

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

figure();
plot3(y(1:i),z(1:i),x(1:i));
hold on;
grid on;
title('Rocket Trajectory | LQR + Hooke Jeeves | $$0^{\circ}$$ latitude','interpreter','latex');
xlabel('Y-Pos (m)');
ylabel('Z-Pos (m)');
zlabel('X-Pos (m)');
plot3(y(1),z(1),x(1),'g*');
plot3(y(i),z(i),x(i),'r*');
plot3(0, 0, 0, 'm*');
legend('Trajectory','Start pt','Stop pt','Target');
zlim([0 20000]);