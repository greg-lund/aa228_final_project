function [new_pop] = resample_population(pop,weights)
% resample_population

new_pop = zeros(size(pop));
[pop_size,~,~] = size(pop);

for i=1:pop_size
    valid = false;
    while ~valid
        idxs = randsample(1:pop_size,2,true,weights);
        valid = idxs(1) ~= idxs(2);
    end
    new_pop(i,:,:) = create_child(pop(idxs(1),:,:),pop(idxs(2),:,:));
end

end

