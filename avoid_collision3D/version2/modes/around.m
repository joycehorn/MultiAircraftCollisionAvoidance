function [best_inc,done] = around(pos,options,ortho,safety_dist)
% Function to find the best increments around the current positions
    % Inputs:
    %   - pos: Matrix representing the positions of all aircraft
    %   - options: Cell array of original increment options for each aircraft
    %   - ortho: Cell array of additional increment options for each aircraft (optional)
    %   - safety_dist: Safety distance threshold
    % Outputs:
    %   - best_inc: Best increments for each aircraft
    %   - done: Boolean indicating whether the search is successful
    
N=numel(options);

for i=1:N
    if isnumeric(ortho{i}) 
        options{i}=[options{i};ortho{i}];
    end
end

% Shuffle the combined increment options
inc_options=shuffle(options);

% Use the search function to find the best increments and minimum distance
[inc, d_min,~]=search(pos,inc_options,safety_dist);
if safety_dist<=d_min && d_min<inf %check if the min distance satisfies the safety threshold
    best_inc=inc;
    done=true; 
else
    best_inc=[];
    done=false; 
end