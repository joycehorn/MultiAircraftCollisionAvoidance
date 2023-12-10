function [best_inc,done] = emergency(pos,options,ortho,back,safety_dist)
% Function to handle emergency situations by considering additional options
    % Inputs:
    %   - pos: Matrix representing the positions of all aircraft
    %   - options: Cell array of original increment options for each aircraft
    %   - ortho: Cell array of orthogonal increment options for each aircraft
    %   - back: Cell array of backward increment options for each aircraft
    %   - safety_dist: Safety distance threshold
    % Outputs:
    %   - best_inc: Best increments for each aircraft in the emergency situation
    %   - done: Boolean indicating whether the emergency maneuver is successfully executed

N=numel(options);

% Incorporate orthogonal and backward options
for i=1:N
    if isnumeric(ortho{i}) 
        options{i}=[options{i};ortho{i}];
    end
    if isnumeric(back{i}) 
        options{i}=[options{i};back{i}];
    end
end
inc_options=shuffle(options);

% Search for the best increments considering emergency options
[inc, d_min,~]=search(pos,inc_options,safety_dist);

% Check if the safety condition is satisfied with the selected increments
if safety_dist<=d_min && d_min<inf
    best_inc=inc;
    done=true; 
else
    best_inc=[];
    done=false; 
end
