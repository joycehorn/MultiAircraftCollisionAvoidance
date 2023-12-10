function best_inc=controller(pos,ahead_exp,ortho_exp, back_exp,safety_dist)
% Controller function to determine the best increments for the aircraft
    % Inputs:
    %   - pos: Matrix representing the positions of all aircraft
    %   - ahead_exp: Increments for getting closer to the target
    %   - ortho_exp: Increments for going perpendicular to the target
    %   - back_exp: Increments for going away from the target
    %   - safety_dist: Safety distance threshold
    % Outputs:
    %   - best_inc: Best increments for the aircraft

% Shuffle the increments for each aircraft
inc_options=shuffle(ahead_exp);

N=numel(inc_options);
% If there is only one aircraft up in the air, select a random increment and return
if N==1
    best_inc=random(ahead_exp);
    return
end
 % Attempt to move closer to the target
[best_inc, close1,done] = ahead(pos,ahead_exp,safety_dist);
if done 
    return
end
% Attempt to take off if needed
[best_inc,close2, done] = take_off(pos,ahead_exp,ortho_exp,safety_dist);
if done 
    return
end
% Attempt to move one step back
[best_inc, done] = back_one(pos,ahead_exp,ortho_exp,back_exp,close1,close2,safety_dist);
if done 
    return
end

% [best_inc, done] = back(pos,ahead_exp,back_exp,n_back,safety_dist);
% if done 
%     return
% end
% 

% Attempt to move around
[best_inc, done] = around(pos,ahead_exp,ortho_exp,safety_dist);
if done 
    return
end
% Attempt emergency maneuver
[best_inc, done] = emergency(pos,ahead_exp,ortho_exp,back_exp,safety_dist);
if done 
    return
end
% If none of the strategies succeed, display a message and choose a random increment
disp('Controller Failed')
best_inc=random(ahead_exp);
end

