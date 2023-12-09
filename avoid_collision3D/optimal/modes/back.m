function [best_inc,done] = back(pos,options,back,n_back,safety_dist)
N=numel(options);
aircraft_back=randperm(n_back);
for i=1:N
    if ismember(i, aircraft_back) && isnumeric(back{i})
        options{i}=[options{i};back{i}];
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