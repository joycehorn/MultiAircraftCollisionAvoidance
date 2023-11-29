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
colors = rand(N, 3);
clock_cycle=0;
delay = 0.2;
paused = false;

% Create a figure for plotting
figure;
hold on;
grid on;
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('Aircraft Movement Simulation');
view(3);

% Calculate minimum and maximum values for x, y, and z for display
all_points = [source; target];
min_values = min(all_points);
max_values = max(all_points);
axis([min_values(1)-1, max_values(1)+1, min_values(2)-1, max_values(2)+1, 0, max_values(3)+5])

% Plot the initial positions of the aircrafts
scatter3(source(:, 1), source(:, 2), source(:, 3), 50, colors, 'filled','Marker', 'o');
% Plot the final positions of the aircrafts
scatter3(target(:, 1), target(:, 2), target(:, 3), 50, colors, 'x', 'LineWidth', 2);

% Simulation loop: run until all aircrafts have reached their targets
while any(pos ~= target, 'all')
    for aircraft = 1:N % N = number of instantiated aircrafts
        if any(pos(aircraft, :) ~= target(aircraft, :)) %if current position is not the final destination
            [new_pos, ~] = aircraft_model(pos(aircraft, :), target(aircraft, :), false); % call model for new position
            % Plot path between previous position and current position
            if clock_cycle == 0
                plot3([source(aircraft, 1); new_pos(1)], [source(aircraft, 2); new_pos(2)], [source(aircraft, 3); new_pos(3)], '-', 'Color', colors(aircraft, :), 'LineWidth', 2);
            else
                plot3([pos(aircraft, 1); new_pos(1)], [pos(aircraft, 2); new_pos(2)], [pos(aircraft, 3); new_pos(3)], '-', 'Color', colors(aircraft, :), 'LineWidth', 2);
            end
            pos(aircraft, :) = new_pos;
            
        end
    end
    
    drawnow;
    
    %Call Safety Monitor and pause plot if in unsafe state
    clock_cycle=clock_cycle+1;
    if ~safety_monitor(pos) && ~paused
        disp(['Not safe at clock = ' num2str(clock_cycle) ', collision @ = [' num2str(pos(:).') ']']);
        pause_text = text(mean(xlim), mean(ylim), mean(zlim), 'Unsafe Consition!', 'FontSize', 20, 'HorizontalAlignment', 'center', 'Color', 'red');
        
        % Pause the simulation until key is pressed
        disp('Press any key to resume...');
        paused = true;
        pause;
        delete(pause_text);
        paused = false;
    end

    pos_hist = [pos_hist, pos];
    pause(delay);
end

%run([0, 0, 0; 1, 1, 0; 2, 2, 0], [5, 5, 0; 7, 7, 0; 10, 10, 0]);%safe
%run([0, 0, 0; 0, 1, 0; 1, 0, 0], [10, 10, 0; 5, 5, 0; 2, 2, 0]);%collide
