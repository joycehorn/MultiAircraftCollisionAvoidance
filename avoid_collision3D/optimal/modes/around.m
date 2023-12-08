function [best_inc,done] = around(pos,options,ortho,safety_dist)
N=numel(options);
for i=1:N
    if isnumeric(ortho{i}) 
        options{i}=[options{i};ortho{i}];
    end
end
inc_options=shuffle(options);
[inc, d_min,~]=search(pos,inc_options,safety_dist);
if safety_dist<=d_min && d_min<inf
    best_inc=inc;
    done=true; 
else
    best_inc=[];
    done=false; 
end