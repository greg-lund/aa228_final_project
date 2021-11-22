function [x,u] = sim_lqr(A,B,K,min_thrust,max_thrust,t,x0)
%SIM_LQR 

g = [-10,0,0]';
N = length(t);
dt = t(2)-t(1);

x = zeros(6,N);
x(:,1) = x0;
u = zeros(3,N);
for i = 1:(N-1)
    T = -K*x(:,i);
    % Clamp x thrust 
    T(1) = min(max_thrust,max(min_thrust,T(1)));
    % clamp T magnitude
    u(:,i) = T + g; % Set T in our bounds
    
    dx = A*x(:,i) + B*u(:,i);
    x(:,i+1) = x(:,i) + dx*dt;
end

end

