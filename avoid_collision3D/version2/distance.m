function [d] = distance(pos1,pos2,min_dist)
 % Function to calculate the distance between two positions
    % Inputs:
    %   - pos1: Position of the first object (aircraft)
    %   - pos2: Position of the second object (aircraft)
    %   - min_dist: Minimum distance threshold
    % Outputs:
    %   - d: Calculated distance

    %Check if both aircraft are on the ground
    if pos1(3)==0 && pos2(3)==0
        d=-1;
    else
        % Calculate the Manhattan distance between the two positions
        d=sum(abs(pos1-pos2));
        % If either of the aircraft is on the ground, enforce the minimum distance threshold
        if pos1(3)==0 || pos2(3)==0
            d=max(d,min_dist);
        end
    end
end

