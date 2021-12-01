
% CHANGES WITH ROTATION
% When adding in rotational speed, follow the same steps as in run_mpc.m.
% Also, make sure to MEX this using the MATLAB coder app after you make any
% changes or they won't be included!

% Runs the simulation to the ground and calculates the reward for a given K

function reward = sim_rocket(K_vec, x0, m_rocket, m_fuel, g, Isp, T_max)

    m_empty = m_rocket - m_fuel; % kg
    g_earth = 9.81; % m/s^2
    
    K = reshape(K_vec, [3 6]);
    
    dt = 0.01; % Simulation step size
    x = x0; % State vector (contains x, y, z, vx, vy, vz) - m or m/s
    m = m_rocket; % Starting mass (kg)
    
    while x(3) > 0
        
        % See run_mpc.m for documentation of simulation documentation. This
        % block is identical to the one in run_mpc.m
        
        if m > m_empty
            T = m*(-K*x + [0; 0; g]);
            T(3) = max([0 T(3)]);
            T_mag = sqrt(T(1)^2 + T(2)^2 + T(3)^2);
            T = T * min([T_max/T_mag 1]);
            T_mag = sqrt(T(1)^2 + T(2)^2 + T(3)^2);
        else
            T = zeros(3,1);
            T_mag = 0;
        end
        
        a = T/m - [0; 0; g];
        x(1:3) = x(1:3) + x(4:6)*dt;
        x(4:6) = x(4:6) + a*dt;
        m = m - T_mag/(Isp*g_earth)*dt;
        
    end
    
    % Quadratic cost function that weighs high velocity of impact higher
    % than high distance from the goal position.
    % 68.5/m_rocket is a normalization factor to weight the used fuel by
    % the proper amount to get a good optimization
    reward = -(dot(x(1:3),x(1:3)) + 10*dot(x(4:6),x(4:6)) + 68.5/m_rocket*(m_rocket - m)^2);

end