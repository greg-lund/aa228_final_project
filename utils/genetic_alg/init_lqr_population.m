function [population] = init_lqr_population(A,B,pop_size)
%INIT_LQR_POPULATION Creates pop_size feedback gain matrices from random
%   LQR problems

[n,m] = size(B);
population = zeros(m,n,pop_size);

i=1;
while i <= pop_size
    Q = rand(n,n);
    Q = triu(Q) + triu(Q,1)';
    for j=4:6
        Q(j,j) = 5000*Q(j,j);
    end
    R = rand(m,m);
    R = triu(R) + triu(R,1)';
    P = icare(A,B,Q,R);
    if isempty(P)
        continue
    end
    population(:,:,i) = inv(R) * B' * P;
    i=i+1;
end
end

