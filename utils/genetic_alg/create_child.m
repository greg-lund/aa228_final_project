function [K] = create_child(K1,K2,mutation_prob)
%CREATE_CHILD Combines two feedback control matrices

[m,n] = size(K1);

mask = rand(size(K1)) < 0.5;
K = (K1 .* mask) + (K2 .* ~mask);

if rand() < mutation_prob
    idx = [randi(m),randi(n)];
    K(idx) = K(idx) + mvnrnd(0,1);
end
end

