function [best_inc,mode]=controller(pos,ahead_exp,ortho_exp, back_exp,safety_dist)
inc_options=shuffle(ahead_exp);
N=numel(inc_options);
%mode lonely
if N==1
    best_inc=inc_options{1};
    mode='lonely';
else
    [best_ahead d_min]=search(pos,inc_options,safety_dist);
    if safety_dist<=d_min && (d_min<inf)
        best_inc=best_ahead;
    else
        for i=1:N
            if isnumeric(ortho_exp{i}) && pos(i,3)==0 %prioritize the taake off
                inc_options{i}=[inc_options{i};ortho_exp{i}];
            end
        end
        inc_options=shuffle(inc_options);
        [best_ortho d_min]=search(pos,inc_options,safety_dist);
        if safety_dist<=d_min && d_min<inf
            best_inc=best_ortho;
        else
            for i=1:N
                if isnumeric(ortho_exp{i}) %prioritize the taake off
                    inc_options{i}=[inc_options{i};ortho_exp{i}];
                end
            end
            inc_options=shuffle(inc_options);
            [best_ortho d_min]=search(pos,inc_options,safety_dist);
            if safety_dist<=d_min && d_min<inf
                best_inc=best_ortho;
            else
                for i=1:N
                    if isnumeric(back_exp{i})
                        inc_options{i}=[inc_options{i};back_exp{i}];
                    end
                end
                inc_options=shuffle(inc_options);
                [best_back d_min]=search(pos,inc_options,safety_dist);
                if safety_dist<=d_min && d_min<inf
                    best_inc=best_back;
                else
                    disp('no soluble')
                end
            end
    end
end
end