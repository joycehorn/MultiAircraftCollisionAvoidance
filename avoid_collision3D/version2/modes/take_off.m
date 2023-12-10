function [best_inc,close,done] = take_off(pos,options,ortho,safety_dist)
% Function to determine the best take-off increments for aircraft
    % Inputs:
    %   - pos: Matrix representing the positions of all aircraft
    %   - options: Cell array of available increment options for each aircraft
    %   - ortho: Cell array of orthogonal increment options for aircraft on land
    %   - safety_dist: Safety distance threshold
    % Outputs:
    %   - best_inc: Best increments for take-off
    %   - close: Indices of close aircraft (within safety_dist)
    %   - done: Flag indicating if take-off is successful
N=numel(options);

for i=1:N
    if isnumeric(ortho{i}) && pos(i,3)==0 %Prioritize take-off by adding orthogonal increments for aircrafts on land
        options{i}=[options{i};ortho{i}];
    end
end
inc_options=shuffle(options);
% Search for the best increments that maximize distance during take-off
[inc, d_min,close]=search(pos,inc_options,safety_dist);

% Check if take-off is successful based on safety distance and minimum distance
if safety_dist<=d_min && d_min<inf
    best_inc=inc;
    done=true; 
else
    best_inc=[];
    done=false; 
end

