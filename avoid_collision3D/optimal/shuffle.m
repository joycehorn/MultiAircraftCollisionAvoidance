function [inc_shuffled] = shuffle(inc_options)
inc_shuffled=inc_options;
for i = 1:numel(inc_options)
    inc_shuffled{i} = inc_options{i}(randperm(size(inc_options{i}, 1)), :);
end

