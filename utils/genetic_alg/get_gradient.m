function [gradK,curr_loss] = get_gradient(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt,c,delta)
%GET_GRADIENT Summary of this function goes here
%   Detailed explanation goes here

[x,~,m,~] = simulate_feedback(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt);
curr_loss = evaluate_trajectory(x(:,end),m(end),m0,c);
gradK = zeros(3,6);
for i=1:3
    for j=1:6
        Kp = K;
        Kp(i,j) = Kp(i,j) + delta;
        [x,~,m,~] = simulate_feedback(w,g,x0,m0,mf,alpha,theta,Tmax,Kp,dt);
        loss = evaluate_trajectory(x(:,end),m(end),m0,c);
        gradK(i,j) = (loss - curr_loss) / delta;
    end
end
end

