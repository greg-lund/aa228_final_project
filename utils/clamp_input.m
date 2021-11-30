function [u_clamped] = clamp_input(g,theta_max,Tmax,m,u)
%clamp_input clamps the input u based on pointing and thrust constraints
%
%u = g + Tc/m

Tc = (u - g)*m;
mag = min(norm(Tc),Tmax);
Tc = Tc / norm(Tc) * mag;

Tc(1) = max(mag*cos(theta_max),Tc(1));

u_clamped = g + Tc ./ m;
end