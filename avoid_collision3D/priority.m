function [,] = priority(pos,dirs)
N=size(pos_aircraft,1)-1;
pos_aircraft=pos(1,:);
dir_aircraft=dirs(1,:);
for i=1:N
    distance = sum(abs(box(i,:)-box(j,:)));
    [coll_dist,index]=max(sum(abs(pos(i,:)-next_pos),2));
end

