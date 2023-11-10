function [new_pos, dir]= aircraft_model(pos, target, avoid)
%rng('shuffle')
if iscell(avoid)
    increment=avoid{1};
elseif pos(3)==0
    increment=[0,0,1];
else
    increment=sign(target-pos);
    if sum(abs(increment))>1
        increment(3)=increment(3)+1;
    end
    nonZeroIndices = find(increment ~= 0);
    randomIndex = nonZeroIndices(randi(length(nonZeroIndices)));
    increment(1:randomIndex-1)=0;
    increment(randomIndex+1:end)=0;
end
new_pos=pos+increment;
dir=sign(target-new_pos);

end