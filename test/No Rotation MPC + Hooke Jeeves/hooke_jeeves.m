
% DOES NOT CHANGE WITH ROTATION

% Computes an optimized K given an initial K by performing Hooke-Jeeves
% local search optimization

function [K_final, rewards] = hooke_jeeves(K, m_rocket, m_fuel, g, Isp, T_max, x_start)
    
    % Hooke-Jeeves hyperparameters

    c = 0.9; % discount factor
    eps = 5*10^-5; % Minimum step size
    
    K_final = {};
    rewards = zeros(1,length(K));

    for i = 1:length(K)

        alpha = 0.01; % Start alpha (step size) at 0.01
        K_curr = reshape(K{i}, [18 1]); % Initialize current best K
        reward_curr = sim_rocket_mex(K_curr, x_start, m_rocket, m_fuel, g, Isp, T_max); % Initialize current best reward
        
        diff = 9999; % Initialize difference between current best reward and previous best reward
        
        % Run Hooke-Jeeves until we've discounted the step size to less
        % than eps.
        
        while alpha > eps && diff > 0.5*10^-3 % diff added in to reduce computational time (results in a less optimal solution)

            reward_best = -Inf; % Best reward for this iteration (not necessarily the best stored reward)
            K_best = K_curr; % Initialize best K for this iteration as the overall best stored
            
            % Take the current K, and step each element +/- alpha. Run the
            % new K through the simulation to see how much reward it 
            % provides. Choose the best K as K_best for this iteration.

            for j = 1:36

                step = (-1)^mod(j,2)*alpha;
                el = ceil(j/2);

                K_temp = K_curr;
                K_temp(el) = K_temp(el) + step;
                
                % Run the simulation until the rocket hits the ground, and
                % figure out how much reward we get. This simulation script
                % is MEX-ed to cut down on runtime, since it is run many
                % times.
                reward = sim_rocket_mex(K_temp, x_start, m_rocket, m_fuel, g, Isp, T_max);

                if reward > reward_best
                    reward_best = reward;
                    K_best = K_temp;
                end

            end
            
            % If the best reward for this iteration is better than the best
            % stored reward, update the current best K to be the best K for
            % this iteration. If there's no improvement, decrease the step
            % size alpha by factor c and perform a finer search.

            if reward_best > reward_curr
                diff = reward_best - reward_curr;
                reward_curr = reward_best;
                K_curr = K_best;
            else
                alpha = alpha * c;
            end

        end

        K_final{i} = reshape(K_curr, [3 6]);
        rewards(i) = reward_curr;

    end

end