function inc = random(options)
% Function to randomly select increments from a shuffled set of options
    % Inputs:
    %   - options: Cell array of increment options for an aircraft
    % Outputs:
    %   - inc: Randomly selected increments
options_shuffled=shuffle(options);
inc=options_shuffled{1}(1,:);
end

