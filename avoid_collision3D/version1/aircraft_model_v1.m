function [new_pos, dir] = aircraft_model_v1(pos, target, avoid)
% This function calculates the new position (new_pos) and direction (dir) for an aircraft.
% Inputs:
%   - pos: Current position of the aircraft
%   - target: Target position for the aircraft
%   - avoid: Boolean specifying avoidance behavior (set by the controller)

%rng('shuffle') % Uncomment this line if you want to seed the random number generator

if isnumeric(avoid)
    increment = avoid; % Use the specified increment to avoid
elseif pos(3) == 0
    % If z = 0 then aircraft in on the ground. Increment in the upward direction for take-off
    increment = [0, 0, 1]; 
else
    % Calculate the increment based on the sign of the difference between the target and current position
    increment = sign(target - pos);
    
    % Avoid landing on other place different than the target
    if pos(3)==1 && (increment(1)~=0 || increment(2)~=0)
        increment(3) = 0;
    end
    
    % Randomly choose one non-zero element to set to zero, ensuring
    % movement is in only one direction at a time
    nonZeroIndices = find(increment ~= 0);
    randomIndex = nonZeroIndices(randi(length(nonZeroIndices)));
    increment(1:randomIndex-1) = 0;
    increment(randomIndex+1:end) = 0;
end

% Calculate the new position and direction of future step
new_pos = pos + increment;
dir = sign(target - new_pos);

end
