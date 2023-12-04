function [control]=controller(pos,dirs)
N=size(pos, 1);
box=min(pos,pos+dirs);
control=cell(N,1);
control(:)={false};
for i=1:N
    for j=i+1:N
        distance = sum(abs(box(i,:)-box(j,:)));
        if distance<4 
            if pos(j,3)==0
                control{j}=[0,0,0];
            else
                control{j} = [0,0,1];
            end
        end
    end
end 


end