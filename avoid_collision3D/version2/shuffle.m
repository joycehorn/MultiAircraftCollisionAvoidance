function [inc_shuffled] = shuffle(inc_options)
    % Function to shuffle each set of increments in inc_options
    % Input: inc_options: Cell array of increment options for each aircraft
    % Output: inc_shuffled: Shuffled increments for each aircraft

    % Initialize inc_shuffled
    inc_shuffled = inc_options;

    for i = 1:numel(inc_options)
        % Shuffle using random permutation of the integers from 1 to the size of the matrix
        inc_shuffled{i} = inc_options{i}(randperm(size(inc_options{i}, 1)), :);
    end
end


