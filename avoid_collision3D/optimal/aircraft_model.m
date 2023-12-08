function [ahead_exp,ortho_exp, back_exp] = aircraft_model(pos, target)
% Take the action given by the controller and calculates:
% ahead:increments for get close to the target
% ortho:increments for going perpendicular to the target
% back: increments for going apart from the target


if pos(3)==0
    % if the aircrft is in the land the only increment possible is going up
    ahead_exp=[0,0,1];
    ortho_exp=[0,0,0];
    back_exp=false;
else
    ahead = sign(target - pos);
    ahead_exp=diag(ahead);
    indices_zero_rows = ~any(ahead_exp, 2);
    ahead_exp(indices_zero_rows, :) = []; % Delete zero rows
    back_exp= -ahead_exp;
    ortho_exp=diag(ahead==0);
    indices_zero_rows=~any(ortho_exp, 2);
    ortho_exp(indices_zero_rows, :) = [];
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
