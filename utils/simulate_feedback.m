function [x,u,m,t] = simulate_feedback(w,g,x0,m0,mf,alpha,theta_max,Tmax,K,dt)
%simulate_feedback Simulates the rocket trajectory given feedback gain
%   matrix K
%
%   w:     constant planetary rotation rate [rad/s] (3,1)
%   g:     constant planetary gravitational acc [m/s^2] (3,1)
%   x0:    starting state [r;r_dot] [m;m/s] (6,1)
%   m0:    initial mass [kg]
%   mf:    empty mass [kg]
%   alpha: fuel consumption rate [kg/Ns]
%   theta_max: maximum gimbal angle for thruster [rad]
%   Tmax:  maximum thrust [N]
%   K:     feedback gain matrix (3,6)
%   dt:    timestep [s]
%
% x_dot(t) = A(w) * x(t) + B(g + Tc(t)/m(t))
% m_dot(t) = -alpha * norm(Tc(t))


S = [0,-w(3),w(2); w(3),0,-w(1);-w(2),w(1),0];
A = [zeros(3,3),eye(3);-S^2,-2*S];
B = [zeros(3,3);eye(3)];

t = 0; x = x0; u = [0;0;0]; m = m0;

while true
    if m(end) <= mf
        control = g;
    else
        control = clamp_input(g,theta_max,Tmax,m(end),-K*x(:,end));
    end
    Tc = m(end)*(control-g);
    new_x = x(:,end)+(A*x(:,end)+B*control)*dt;
    x = [x,new_x];
    m = [m,m(end)-alpha*norm(Tc)*dt];
    t = [t,t(end)+dt];
    u = [u,control];

    % Stop if we hit the surface
    if (x(1,end) <= 0)
        break
    end
end

end

