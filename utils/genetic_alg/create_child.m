function [K] = create_child(K1,K2)
%CREATE_CHILD Combines two feedback control matrices

mask = rand(size(K1)) < 0.5;
K = (K1 .* mask) + (K2 .* ~mask);
end

