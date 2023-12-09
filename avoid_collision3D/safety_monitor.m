function [safety] = safety_monitor(pos)
% Function to check if the safety requirement is being violated
    % Inputs:
    %   - pos: Matrix representing the positions of all aircraft
    % Outputs:
    %   - safety: Binary flag indicating whether safety is maintained (1) or violated (0)

% Get the number of aircraft (N) based on the number of rows in the pos matrix
N=size(pos, 1);
% Initialize safety flag to 1 (safe)
safety=1;

 % Loop through all pairs of aircraft
for i=1:N
    for j=i+1:N
         % Check if both aircraft are in the air (z > 0)
        if (pos(i,3)>0) && (pos(j,3)>0)
            % Calculate the Manhattan distance between the two aircraft using Manhattan distance
            distance = sum(abs(pos(i,:) - pos(j,:)));
            % Check if the distance violates safety requirement
            if distance<2 
                safety = 0; %Set safety flag to 0 (unsafe)
                break
            end
        end
    end
end 

