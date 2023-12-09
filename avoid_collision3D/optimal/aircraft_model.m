function [ahead_exp,ortho_exp, back_exp] = aircraft_model(pos, target)
% Function to calculate increments for different actions based on the controller's decision
    % Inputs:
    %   - pos: Current position of the aircraft
    %   - target: Target position for the aircraft
    % Outputs:
    %   - ahead_exp: Increments for getting closer to the target
    %   - ortho_exp: Increments for going perpendicular to the target
    %   - back_exp: Increments for moving apart from the target

    % if the aircraft is on the ground, the only possible increment is going up
    if pos(3)==0
        ahead_exp=[0,0,1];
        ortho_exp=[0,0,0];
        back_exp=false;
    else
        % Calculate increments for moving towards the target
        ahead = sign(target - pos);
        ahead_exp=diag(ahead);
        indices_zero_rows = ~any(ahead_exp, 2);
        ahead_exp(indices_zero_rows, :) = [];

        % Calculate increments for moving away from the target
        back_exp= -ahead_exp;
        
        % Calculate increments for going perpendicular to the target
        ortho_exp=diag(ahead==0);
        indices_zero_rows=~any(ortho_exp, 2);
        ortho_exp(indices_zero_rows, :) = [];
        
        % Duplicate and negate rows for the opposite direction
        ortho_exp=[ortho_exp;-ortho_exp];
        
        % Avoid landing on other place different than the target
        if pos(3)==1 && (ahead(1)~=0 || ahead(2)~=0)
            rows_to_delete = all(ahead_exp == [0, 0, -1], 2);
            ahead_exp(rows_to_delete, :)=[];
            rows_to_delete = all(ortho_exp == [0, 0, -1], 2);
            ortho_exp(rows_to_delete, :)=[];
            rows_to_delete = all(back_exp == [0, 0, -1], 2);
            back_exp(rows_to_delete, :)=[];
    
        end
    end
end
