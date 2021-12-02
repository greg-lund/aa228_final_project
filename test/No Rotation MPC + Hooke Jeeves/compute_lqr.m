% Computes the initial K value using LQR

function K = compute_lqr(lat, omega)

    % Angular velocity vector in ECI fram (rad/s);
    w_I = [omega; 0; 0];

    % Update angle of rotation (theta) given latitude
    if lat >= 0
        theta = 90 - lat;
    elseif lat < 0 
        theta = 90 + abs(lat);
    end
    theta = deg2rad(theta);

    % Rotation matrix for rotation of theta about e3 unit vector
    A = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];
    % Rotated angular velocity vector in target reference frame(rad/s)
    w_T = A * w_I;

    % Updated for rotation omega of central body
    Sw = [0 -w_T(3) w_T(2); w_T(3) 0 -w_T(1); -w_T(2) w_T(1) 0]; 
    M0 = zeros(3);
    I = eye(3);
    A = [M0 I; -Sw^2 -2*Sw];
    B = [M0; I];
      
    Q = eye(6);
% 
%     for i = 10:10
        R = 100*eye(3);
        P = icare(A, B, Q, R);
        K{1} = R^-1*B'*P;
%         [K{i}, ~, ~] = lqr(A, B, Q, R, zeros(6,3));
%     end
          
end