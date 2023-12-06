function [control]=controller(pos,dirs)
N=size(pos, 1);
box=min(pos,pos+dirs);
control=cell(N,1);
control(:)={false};
dirs(:,3)=1;
%priority=randperm(6);
%pos=pos(priority,:);
%dirs=dirs(priority,:);
n_land_aircraft=sum(pos(:, 3) == 0);
[~, sorted_indices] = sortrows(pos, 3);
opt_priority=[sorted_indices(n_land_aircraft+1:N);sorted_indices(1:n_land_aircraft)];
pos=pos(opt_priority,:);
dirs=dirs(opt_priority,:);
for i=1:N
    for j=i+1:N
        distance = sum(abs(box(i,:)-box(j,:)));
        if distance<=4 
            if pos(j,3)==0
                control{j}=[0,0,0];
            else
                inc=diag(dirs(j,:));
                indices_zero_rows = ~any(inc, 2);
                inc(indices_zero_rows, :) = []; % Delete zero rows

                num_rows = size(inc, 1);
                shuffled_indices = randperm(num_rows);
                % Rearrange rows based on the shuffled indices
                inc = inc(shuffled_indices, :);


                next_pos=pos(j,:)+inc;
                [~,index]=max(sum(abs(pos(i,:)-next_pos),2));
                % if coll_dist>=3
                control{j} = inc(index,:); % increment Z up
                % else
                %     inc=diag(dirs(i,:));
                %     indices_zero_rows = ~any(inc, 2);
                %     inc(indices_zero_rows, :)=[];
                % 
                %     num_rows = size(inc, 1);
                %     shuffled_indices = randperm(num_rows);
                %     % Rearrange rows based on the shuffled indices
                %     inc = inc(shuffled_indices, :);
                % 
                %     next_pos=pos(i,:)+inc;
                %     [~,index]=max(sum(abs(pos(j,:)-next_pos),2));
                %     control{i} = inc(index,:);
                % end
            end
        end
    end
end 
[~, inverse_priority] = ismember(1:N, opt_priority);
control=control(inverse_priority,:);

%[~, inverse_priority] = ismember(1:N, priority);
%control=control(inverse_priority,:);
end