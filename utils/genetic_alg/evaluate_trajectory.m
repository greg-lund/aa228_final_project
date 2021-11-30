function [loss] = evaluate_trajectory(xf,mf,m0,c)
%EVALUATE_GAIN Calculates the loss for a given trajectory
%
% cost = evaluate_gain(x,u,m,t)
%   xf: final position and velocity
%   mf: final mass
%   m0: initial mass
%   c:  cost weight vector [pos_cost, vel_cost, mass_cost]

loss = c(1) * norm(xf(1:3)) + c(2) * norm(xf(4:6)) + c(3) * (m0-mf);
end

