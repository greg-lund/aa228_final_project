function [new_pop] = resample_population(population,weights,mutation_prob)
% resample_population

new_pop = zeros(size(population));
[~,~,pop_size] = size(population);

for i=1:pop_size
    valid = false;
    while ~valid
        idxs = randsample(1:pop_size,2,true,weights);
        valid = idxs(1) ~= idxs(2);
    end
    new_pop(:,:,i) = create_child(population(:,:,idxs(1)),population(:,:,idxs(2)),mutation_prob);
end

end

