function best_inc=controller(pos,ahead_exp,ortho_exp, back_exp,safety_dist)
inc_options=shuffle(ahead_exp);
N=numel(inc_options);
if N==1
    best_inc=random(ahead_exp);
    return
end
[best_inc, close1,done] = ahead(pos,ahead_exp,safety_dist);
if done 
    return
end
[best_inc,close2, done] = take_off(pos,ahead_exp,ortho_exp,safety_dist);
if done 
    return
end

[best_inc, done] = back_one(pos,ahead_exp,ortho_exp,back_exp,close1,close2,safety_dist);
if done 
    return
end

% [best_inc, done] = back(pos,ahead_exp,back_exp,n_back,safety_dist);
% if done 
%     return
% end
% 
[best_inc, done] = around(pos,ahead_exp,ortho_exp,safety_dist);
if done 
    return
end

[best_inc, done] = emergency(pos,ahead_exp,ortho_exp,back_exp,safety_dist);
if done 
    return
end

disp('Controller Failed')
best_inc=random(ahead_exp);
end

