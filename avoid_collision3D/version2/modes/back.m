function [best_inc,done] = back(pos,options,back,n_back,safety_dist)
% Function to incorporate backward moves and find the best increments
    % Inputs:
    %   - pos: Matrix representing the positions of all aircraft
    %   - options: Cell array of increment options for each aircraft
    %   - back: Cell array representing backward move options for each aircraft
    %   - n_back: Number of aircraft for which backward moves are considered
    %   - safety_dist: Safety distance threshold
    % Outputs:
    %   - best_inc: Best increments considering backward moves
    %   - done: Flag indicating if the process is successful

N=numel(options);
% Randomly select a subset 
aircraft_back=randperm(n_back);

% Add backward move options to the corresponding aircraft's increment options
for i=1:N
    if ismember(i, aircraft_back) && isnumeric(back{i})
        options{i}=[options{i};back{i}];
    end
end
inc_options=shuffle(options);
% Use the search function to find the best increments considering backward moves
[inc, d_min]=search(pos,inc_options,safety_dist);
% Check if the safety condition is satisfied
if safety_dist<=d_min && d_min<inf
    best_inc=inc;
    done=true; 
else
    best_inc=[];
    done=false; 
end