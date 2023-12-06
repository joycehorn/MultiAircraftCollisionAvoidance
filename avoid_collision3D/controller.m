function [control]=controller(pos,dirs)
N=size(pos, 1);
box=min(pos,pos+dirs);
control=cell(N,1);
control(:)={false};
for i=1:N
    for j=i+1:N
        distance = sum(abs(box(i,:)-box(j,:)));
        if distance<=4 
            if pos(j,3)==0
                control{j}=[0,0,0];
            else
                inc=[[dirs(j,1),0,0];[0,dirs(j,2),0];[0,0,1]];
                next_pos=pos(j,:)+inc;
                sum(abs([pos(i,:);pos(i,:);pos(i,:)]-next_pos));
                [~,index]=max(sum(abs([pos(i,:);pos(i,:);pos(i,:)]-next_pos),2));
                control{j} = inc(index,:); % increment Z up
            end
        end
    end
end 


end