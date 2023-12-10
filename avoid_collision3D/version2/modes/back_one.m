function [best_inc,done] = back_one(pos,options,ortho,back,close1,close2,safety_dist)
% New function to incorporate backward moves and find the best increments
    % Inputs:
    %   - pos: Matrix representing the positions of all aircraft
    %   - options: Cell array of original increment options for each aircraft
    %   - ortho: Cell array of orthogonal increment options for each aircraft
    %   - back: Cell array of backward increment options for each aircraft
    %   - close1: Indices of the first pair of close aircraft
    %   - close2: Indices of the second pair of close aircraft
    %   - safety_dist: Safety distance threshold
    % Outputs:
    %   - best_inc: Best increments to avoid close encounters
    %   - done: Flag indicating if a valid backward maneuver is found

N=numel(options);

% Check conditions to update increment options of all aircraft
for i=1:N
    if i==close1(1) && isnumeric(back{i})
        options{i}=back{i};
    elseif i==close2(1) && isnumeric(back{i})
        options{i}=back{i};
    elseif i~=close1(2) && i~=close2(2) && isnumeric(ortho{i})
        options{i}=[options{i};ortho{i}];
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