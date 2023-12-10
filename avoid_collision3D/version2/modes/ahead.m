function [best_inc,close,done] = ahead(pos,options,safety_dist)
 % Function to find the best increments for moving ahead while maintaining safety
    % Inputs:
    %   - pos: Matrix representing the positions of all aircraft
    %   - options: Cell array of increment options for each aircraft
    %   - safety_dist: Safety distance threshold
    % Outputs:
    %   - best_inc: Best increments for moving ahead
    %   - close: Indices of close aircraft (within safety_dist)
    %   - done: Flag indicating if the operation is completed

% Call the search function to find the best increments that maximize distance
% between aircraft while considering safety_dist
[best_ahead, d_min,close]=search(pos,options,safety_dist);

% Check if the safety distance condition is met and the minimum distance is finite
if safety_dist<=d_min && (d_min<inf) %Second condition is for avoiding all the aircrafts stay on the ground
    best_inc=best_ahead;
    done=true;
else
    best_inc=[];
    done=false; 
end

