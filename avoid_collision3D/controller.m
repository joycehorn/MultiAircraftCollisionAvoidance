function [control]=controller(pos,dirs)
% Function responsible for safety maneuvers when multiple aircraft are
% coming close to violating the safety requirement
    % Inputs:
    %   - pos: Matrix representing the positions of all aircraft
    %   - dirs: Matrix representing the directions of all aircraft
    % Outputs:
    %   - control: Cell array indicating control actions for each aircraft

% Get the number of aircraft (N) based on the number of rows in the pos matrix
N=size(pos, 1);
% Initialize control cell array with all elements set to false
control=cell(N,1);
control(:)={false};
% Set the z-component of dirs to 1 for all aircraft
dirs(:,3)=1;

% Count the number of aircraft that are on the ground
n_land_aircraft=sum(pos(:, 3) == 0);

% Sort aircraft based on their z-coordinates and prioritize airborne aircraft
[~, sorted_indices] = sortrows(pos, 3);
opt_priority=[sorted_indices(n_land_aircraft+1:N);sorted_indices(1:n_land_aircraft)];
pos=pos(opt_priority,:);
dirs=dirs(opt_priority,:);

% Create a bounding box for each aircraft based on its current position and
% direction (defined by the minimum)
box=min(pos,pos+dirs);

% Iterate through all pairs of aircraft
for i=1:N
    for j=i+1:N
        % Calculate the manhattan distance between the boxes of two aircraft
        distance = sum(abs(box(i,:)-box(j,:)));
         % If the distance is less than or equal to 4, perform safety
         % maneuver because the aircraft would violate safety requirement
         % in the next step
        if distance<=4 
            if pos(j,3)==0 % Grounded aircraft, no movement
                control{j}=[0,0,0];
            else
                control{j} = [0,0,1]; % Airborne aircraft, increment Z up
            end
        end
    end
end
% Reorder the control actions based on the original order of aircraft
[~, inverse_priority] = ismember(1:N, opt_priority);
control=control(inverse_priority,:);
end