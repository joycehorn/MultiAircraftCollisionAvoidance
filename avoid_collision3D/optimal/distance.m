function [d] = distance(pos1,pos2,min_dist)
    if pos1(3)==0 && pos2(3)==0
        d=-1;
    else
        d=sum(abs(pos1-pos2));
        if pos1(3)==0 || pos2(3)==0
            d=max(d,min_dist);
        end
    end
end

