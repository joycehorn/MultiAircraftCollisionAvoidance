function [] = run(source, target)
% This function simulates the movement of aircraft from source to target positions in 3D space.

% Input validations
assert(size(source, 2) == 3, 'Dimension of sources has to be 3');
assert(size(target, 2) == 3, 'Dimension of targets has to be 3');
N = size(source, 1);
assert(size(target, 1) == N, 'Number of targets has to be the same as the number of sources');
assert(all(source(:, 3) == 0), 'All sources have to be on the ground (z=0)');
assert(all(target(:, 3) == 0), 'All targets have to be on the ground (z=0)');

% Initialization
pos = source;
pos_hist = {pos};

% Simulation loop: run until all aircrafts have reached their targets
clock_cicle=0;
while any(pos ~= target, 'all')
    for aircraft = 1:N % N = number of instantiated aircrafts
        if any(pos(aircraft, :) ~= target(aircraft, :)) %if current position is not the final destination
            [new_pos, ~] = aircraft_model(pos(aircraft, :), target(aircraft, :), false); % call model for new position
            pos(aircraft, :) = new_pos;
        end
    end
    clock_cicle=clock_cicle+1;
    if ~safety_monitor(pos)
        disp(['Not safe at clock = ' num2str(clock_cicle)])
        disp(['Collision positions are are = [' num2str(pos(:).') ']']) ;
    end
    pos_hist = [pos_hist, pos];
end

% Visualization (keep history of positions to draw trace for each aircraft)
pos_hist = cat(3, pos_hist{:});
pause(2)
colors = rand(N, 3);

for i = 1:length(pos_hist)
    for aircraft = 1:N
        % Plot trajectory
        plot3(squeeze(pos_hist(aircraft, 1, 1:i)), squeeze(pos_hist(aircraft, 2, 1:i)), ...
            squeeze(pos_hist(aircraft, 3, 1:i)), 'Color', colors(aircraft, :), 'LineWidth', 2, ...
            'DisplayName', sprintf('Aircraft %d', aircraft));
        hold on;
        
        % Plot current position, target, and source points
        p = plot3(pos_hist(aircraft, 1, i), pos_hist(aircraft, 2, i), pos_hist(aircraft, 3, i), ...
            'ok', 'MarkerSize', 5, 'MarkerFaceColor', colors(aircraft, :));
        q = plot3(target(aircraft, 1), target(aircraft, 2), target(aircraft, 3), ...
            'xb', 'MarkerSize', 10, 'MarkerFaceColor', colors(aircraft, :), 'MarkerEdgeColor', colors(aircraft, :));
        r = plot3(source(aircraft, 1), source(aircraft, 2), source(aircraft, 3), ...
            'or', 'MarkerSize', 4, 'MarkerFaceColor', colors(aircraft, :), 'MarkerEdgeColor', colors(aircraft, :));
        set([p, q, r], 'HandleVisibility', 'off');
    end  
    
    % Set axis limits
    min_x = min([min(pos_hist(:, 1, :), [], 'all'), min(source(:, 1)), min(target(:, 1))]) - 1;
    max_x = max([max(pos_hist(:, 1, :), [], 'all'), max(source(:, 1)), max(target(:, 1))]) + 1;
    min_y = min([min(pos_hist(:, 2, :), [], 'all'), min(source(:, 2)), min(target(:, 2))]) - 1;
    max_y = max([max(pos_hist(:, 2, :), [], 'all'), max(source(:, 2)), max(target(:, 2))]) + 1;
    min_z = 0;
    max_z = max(pos_hist(:, 3, :), [], 'all') + 3;
    
    axis([min_x, max_x, min_y, max_y, min_z, max_z])
    title('3D Trajectories');
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    grid on; % Add grid lines to the plot
    legend('AutoUpdate', 'off', 'Location', 'Best');
    pause(.5)
    hold off;
end

%run([0, 0, 0; 1, 1, 0; 2, 2, 0], [5, 5, 0; 7, 7, 0; 10, 10, 0]);
%run([0, 0, 0; 2, 2, 0; 4, 4, 0], [10, 10, 0; 8, 8, 0; 6, 6, 0]);
%run([1, 1, 0; 2, 2, 0; 3, 3, 0], [5, 5, 0; 5, 5, 0; 5, 5, 0]);
%run([0, 0, 0; 0, 0, 0; 0, 0, 0], [10, 10, 0; 5, 5, 0; 2, 2, 0]);%collide
%run([2, 2, 0; 3, 3, 0; 5, 5, 0], [8, 8, 0; 7, 7, 0; 2, 2, 0]);

