function [] = plot_trajectory(x,u,m,t,g,disp,path)
%PLOT_TRAJECTORY Displays and/or saves plots of a given rocket trajectory
%
% plot_trajectory(x,u,m,t,g,disp,path)

lw = 1.5;
Tc = (u-g) .* m;

if disp
    vis = 'on';
else
    vis = 'off';
end

f1=figure('visible',vis);
plot(t,x(1:3,:) ./ 1000,'linewidth',lw)
legend('x','y','z','location','northeast')
xlabel('Time [s]')
ylabel('Position [km]')

f2=figure('visible',vis);
plot(t,x(4:end,:),'linewidth',lw)
legend('v_x','v_y','v_z','location','northeast')
xlabel('Time [s]')
ylabel('Velocity [m/s]')

f3=figure('visible',vis);
hold on
plot(t,Tc(3,:) ./ 1000,'linewidth',lw);
plot(t,Tc(2,:) ./ 1000,'linewidth',lw)
plot(t,Tc(1,:) ./ 1000,'linewidth',lw)
legend('T_z','T_y','T_x')
xlabel('Time [s]')
ylabel('Thrust [kN]')

f4=figure('visible',vis);
plot(t,m,'linewidth',lw)
xlabel('Time [s]')
ylabel('Rocket Mass [kg]')

if ~isempty(path)
    exportgraphics(f1,path+"pos.png","Resolution",450);
    exportgraphics(f2,path+"vel.png","Resolution",450);
    exportgraphics(f3,path+"thrust.png","Resolution",450);
    exportgraphics(f4,path+"mass.png","Resolution",450);
end


end

