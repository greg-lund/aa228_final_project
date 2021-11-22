function [x,m] = simulate_thrust(w,g,x0,m0,alpha,t,Tc)
%simulate simulates the rocket problem at times denoted by t
%
%simulate_thrust(w,g,x0,m0,alpha,t,Tc)
%
%   w: constant angular velocity of planet    
%   g: constant gravitational acceleration due to planet
%   x0: starting position and velocities wrt goal [r;r_dot]
%   m0: starting mass of rocket
%   alpha: fuel consumption rate
%   t: discrete time points to simulate at
%   Tc: control inputs at points in t
%
% Follows the following dynamics model:
% x_dot(t) = A(w) * x(t) + B(g + Tc(t)/m(t))
% m_dot(t) = -alpha * norm(Tc(t))


S = [0,-w(3),w(2); w(3),0,-w(1);-w(2),w(1),0];
A = [zeros(3,3),eye(3);-S^2,-2*S];
B = [zeros(3,3);eye(3)];

N = length(t);
x = zeros(6,N);
x(:,1) = x0;

m = zeros(1,N);
m(1) = m0;

for i=1:(N-1)
    dt = t(i+1)-t(i);
    x_dot = A * x(:,i) + B*(g + Tc(i) ./ m(i));
    m_dot = -alpha * norm(Tc(i));
    
    x(:,i+1) = x(:,i) + x_dot .* dt;
    m(i+1) = m(i) + m_dot .* dt;
end

end

