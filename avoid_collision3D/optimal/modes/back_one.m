function [best_inc,done] = back_one(pos,options,ortho,back,close,safety_dist)
N=numel(options);
for i=1:N
    if i==close(1) && isnumeric(back{i})
        options{i}=back{i};
    elseif i~=close(2) && isnumeric(ortho{i})
        options{i}=[options{i};ortho{i}];
    end
end
inc_options=shuffle(options);
[inc, d_min]=search(pos,inc_options,safety_dist);
if safety_dist<=d_min && d_min<inf
    best_inc=inc;
    done=true; 
else
    best_inc=[];
    done=false; 
end