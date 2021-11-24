clear all; close all; clc;

%% Initial Conditions & Problem Specific variables

% latitude (90N to 90S -> +90 to -90 degrees)
lat = 90;

% Initial Thrust vector (N)
Tc0 = [0; 0; 0];

% Time step (sec)
dt = 0.01;
% Time span to iterate over (sec)
tspan = [0:dt:100];
% initial position/velocity 
x0 = [100000; 0; 0; 0; 0; 0];
% initial mass (kg)
m0 = 1000;
% constant of fuel consumption
alpha = 0.001;

x1 = propagate_trajectory(x0, m0, Tc0, alpha, lat, tspan, dt);
x0(5) = 10;
x2 = propagate_trajectory(x0, m0, Tc0, alpha, lat, tspan, dt);
x0(5) = 0;
x0(6) = 20;
x3 = propagate_trajectory(x0, m0, Tc0, alpha, lat, tspan, dt);
x0(5) = 10;
Tc0 = [1000; -200; -400];
x4 = propagate_trajectory(x0, m0, Tc0, alpha, lat, tspan, dt);

figure();
plot3(x1(2,:),x1(3,:),x1(1,:));
hold on;
plot3(x2(2,:),x2(3,:),x2(1,:));
plot3(x3(2,:),x3(3,:),x3(1,:));
plot3(x4(2,:),x4(3,:),x4(1,:));
grid on;
title('Rocket Trajectory');
xlabel('Y-Pos (m)');
ylabel('Z-Pos (m)');
zlabel('X-Pos (m)');
legend('Thrust=0 | V_i=0');
hold on
legend({'$Thrust=0 (N)| V_i=0 (m/s)$', '$Thrust=0 (N) | V_i=10\hat{y} (m/s)$','$Thrust=0 (N) | V_i=20\hat{z} (m/s)$', '$Thrust=1000\hat{x}-200\hat{y}-400\hat{z} (N) | V_i=10\hat{y}+20\hat{z} (m/s)$'},'Interpreter','latex');


%% Propagate trajectory
function x = propagate_trajectory(x0, m0, Tc0, alpha, lat, tspan, dt)
    % Angular velocity of the earth (rad/s)
    omega_Earth = 7.292124 * 10^-5;
    % Angular velocity vector in ECI frame (rad/s)
    w_I = [omega_Earth; 0; 0];

    % Update angle of rotation (theta) given latitude
    if lat >= 90
        theta = 90 - lat;
    elseif lat < 90 
        theta = 90 + abs(lat);
    end
    theta = deg2rad(theta);

    % Rotation matrix for rotation of theta about e3 unit vector
    A = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];
    % Rotated angular velocity vector in target reference frame(rad/s)
    w_T = A * w_I;

    Sw = [0 -w_T(3) w_T(2); w_T(3) 0 -w_T(1); -w_T(2) w_T(1) 0]; 
    M0 = zeros(3);
    I = [1 0 0; 0 1 0; 0 0 1];
    A = [M0 I; -Sw^2 -2*Sw];
    B = [M0; I];

    % gravitational constant (m/s^2)
    g = [-9.81; 0; 0];

    for i = 1:length(tspan)
        if tspan(i) == 0
            x(:,i) = x0;
            m(i) = m0;
            Tc(:,i) = Tc0;
            dx(:,i) = A*x(:,i) + B*(g + Tc(:,i)./m(i));
            dm(i) = -alpha*norm(Tc(:,i));
        else
            x(:,i) = x(:,i-1) + dx(:,i-1)*dt;
            m(i) = m(i-1) + dm(i-1)*dt;
            Tc(:,i) = Tc0; % Placeholder for thrust vector
            dx(:,i) = A*x(:,i) + B*(g + Tc(:,i)./m(i));
            dm(i) = -alpha*norm(Tc(:,i));
        end
    end
end



