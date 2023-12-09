function [best_inc,d_max,close] = search(pos,inc_options,safety_dist)
% Function to search for the best increments that maximize distance between aircraft
    % Inputs:
    %   - pos: Matrix representing the positions of all aircraft
    %   - inc_options: Cell array of increment options for each aircraft
    %   - safety_dist: Safety distance threshold
    % Outputs:
    %   - best_inc: Best increments for each aircraft
    %   - d_max: Maximum distance between two aircraft
    %   - close: Indices of close aircraft (within safety_dist)

% Determine the number of dimensions for each aircraft's increment options
dim = cellfun(@(x) size(x, 1), inc_options');

% Generate Cartesian indices for each dimension
cart = arrayfun(@(x) 1:x, dim , 'UniformOutput', false);

% Initialize cell array to store indices for each dimension
inc = cell(numel(dim), 1);

% Create a grid of indices for each dimension
[grid{1:numel(dim)}] = ndgrid(cart{:});

% Flatten the grid to obtain indices for each dimension
for i = 1:numel(dim)
    inc{i}=grid{i}(:);
end

d_max=0;
N=numel(dim);
inc_ind=1;
close=[1,2];

% Iterate through all possible combinations of increments
for i=1:prod(dim)
    d_min=inf; %fix this
    for j=1:N
        for k=j+1:N
            %Calculate positions of two aircraft after taking increments
            pos1=pos(j,:)+inc_options{j}(inc{j}(i),:);
            pos2=pos(k,:)+inc_options{k}(inc{k}(i),:);

             % Check if the distance is within the safety threshold and update minimum distance
            d=distance(pos1,pos2,safety_dist);
            if 0<=d && d<d_min  %but a break for crossing the threshold
                d_min=d;
                close=[j,k];
            end
        end
    end
    % Update maximum distance and corresponding increment index
    if d_max<d_min && d_min<inf
        d_max=d_min;
        inc_ind=i;
    end
end
% Extract the best increments for each aircraft based on the selected index
best_inc=zeros(N,3);
for i=1:N
    best_inc(i,:)=inc_options{i}(inc{i}(inc_ind),:);
end
end
