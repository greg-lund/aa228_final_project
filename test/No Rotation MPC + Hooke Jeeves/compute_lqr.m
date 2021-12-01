
% CHANGES WITH ROTATION

% Computes the initial K value using LQR

function K = compute_lqr()

    A = [0 0 0 1 0 0; ... % Update this for rotational dynamics
         0 0 0 0 1 0; ...
         0 0 0 0 0 1; ...
         0 0 0 0 0 0; ...
         0 0 0 0 0 0; ...
         0 0 0 0 0 0];
     
    B =  [0 0 0; ... % Update this for rotational dynamics
          0 0 0; ...
          0 0 0; ...
          1 0 0; ...
          0 1 0; ...
          0 0 1];
      
    Q = eye(6);
% 
%     for i = 10:10
        R = 100*eye(3);
        P = icare(A, B, Q, R);
        K{1} = R^-1*B'*P;
%         [K{i}, ~, ~] = lqr(A, B, Q, R, zeros(6,3));
%     end
          
end