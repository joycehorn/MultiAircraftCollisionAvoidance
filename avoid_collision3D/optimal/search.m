function [best_inc,d_max,close] = search(pos,inc_options,safety_dist)
dim = cellfun(@(x) size(x, 1), inc_options');
cart = arrayfun(@(x) 1:x, dim , 'UniformOutput', false);

inc = cell(numel(dim), 1);
[grid{1:numel(dim)}] = ndgrid(cart{:});
for i = 1:numel(dim)
    inc{i}=grid{i}(:);
end 
d_max=0;
N=numel(dim);
inc_ind=1;
close=[1,2];
for i=1:prod(dim)
    d_min=inf; %fix this
    for j=1:N
        for k=j+1:N
            pos1=pos(j,:)+inc_options{j}(inc{j}(i),:);
            pos2=pos(k,:)+inc_options{k}(inc{k}(i),:);
            d=distance(pos1,pos2,safety_dist);
            if 0<=d && d<d_min  %but a break for crossing the threshold
                d_min=d;
                close=[j,k];
            end
        end
    end
    if d_max<d_min && d_min<inf
        d_max=d_min;
        inc_ind=i;
    end
end
best_inc=zeros(N,3);
for i=1:N
    best_inc(i,:)=inc_options{i}(inc{i}(inc_ind),:);
end
end