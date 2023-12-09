function [best_inc,close,done] = ahead(pos,options,safety_dist)
[best_ahead, d_min,close]=search(pos,options,safety_dist);
if safety_dist<=d_min && (d_min<inf) %second condition is for avoiding all the aircrafts stay on the ground
    best_inc=best_ahead;
    done=true;
else
    best_inc=[];
    done=false; 
end
