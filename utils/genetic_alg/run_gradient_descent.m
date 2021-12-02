function [K,loss] = run_gradient_descent(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt,cost_weights,delta,step_size,num_iter)
%RUN_GRADIENT_DESCENT Summary of this function goes here
%   Detailed explanation goes here

Kbest = K;
loss = inf;

for i=1:num_iter
    [gradK,curr_loss] = get_gradient(w,g,x0,m0,mf,alpha,theta,Tmax,K,dt,cost_weights,delta);
    gradK = gradK / norm(gradK);
    K = K - step_size * gradK;
    if curr_loss < loss
        loss = curr_loss;
        Kbest = K;
    end
end
K = Kbest;
end

