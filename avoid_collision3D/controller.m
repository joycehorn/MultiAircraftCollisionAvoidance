function [control]=controller(pos,dirs)
N=size(pos, 1);

control=cell(N,1);
control(:)={false};
dirs(:,3)=1;
n_land_aircraft=sum(pos(:, 3) == 0);
[~, sorted_indices] = sortrows(pos, 3);
opt_priority=[sorted_indices(n_land_aircraft+1:N);sorted_indices(1:n_land_aircraft)];
pos=pos(opt_priority,:);
dirs=dirs(opt_priority,:);
box=min(pos,pos+dirs);
for i=1:N
    for j=i+1:N
        distance = sum(abs(box(i,:)-box(j,:)));
        if distance<=4 
            if pos(j,3)==0
                control{j}=[0,0,0];
            else
                control{j} = [0,0,1]; %inc(index,:); % increment Z up
            end
        end
    end
end 
[~, inverse_priority] = ismember(1:N, opt_priority);
control=control(inverse_priority,:);
end