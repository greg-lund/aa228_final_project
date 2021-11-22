function [u_clamped] = clamp_input(g,theta_max,Tmax,m,u)
%clamp_input clamps the input u based on pointing and thrust constraints
%
%u = g + Tc/m

Tc = (u - g)*m;
mag = min(norm(Tc),Tmax);

theta = acos(Tc(1)/norm(Tc));
theta = max(min(theta,theta_max),-theta_max);
phi = atan2(Tc(3),Tc(2));

u_clamped = mag * [cos(theta);cos(phi)*sin(theta);sin(phi)*sin(theta)] / m + g;

end