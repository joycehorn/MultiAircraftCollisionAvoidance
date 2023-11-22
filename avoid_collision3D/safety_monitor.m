function [safety] = safety_monitor(pos)
%SAFATY_MONITOR Summary of this function goes here
%   Detailed explanation goes here
N=size(pos, 1);
safety=1;
for i=1:N
    for j=i+1:N
        distance = sum(abs(pos(i,:) - pos(j,:)));
        if distance<2
            safety = 0;
            break
        end
    end
end 

