function [] = run_alt(source, target)
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

    % Create a figure for plotting
    figure;
    hold on;
    grid on;
    axis equal;
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    title('Aircraft Movement Simulation');
    % Set the view perspective explicitly
    view(3);


    all_points = [source; target];
    min_values = min(all_points);
    max_values = max(all_points);
    axis([min_values(1)-1, max_values(1)+1, min_values(2)-1, max_values(2)+1, 0, max_values(3)+3])

    % Plot the initial positions of the aircraft
    scatter3(source(:, 1), source(:, 2), source(:, 3), 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b');
    % Plot the final positions of the aircraft
    scatter3(target(:, 1), target(:, 2), target(:, 3), 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g');

    % Simulation loop: run until all aircraft have reached their targets
    clock_cycle = 0;
    delay = 0.2; % Adjust the delay time (in seconds) as needed

    while any(pos ~= target, 'all')
        for aircraft = 1:N
            if any(pos(aircraft, :) ~= target(aircraft, :))
                [new_pos, ~] = aircraft_model(pos(aircraft, :), target(aircraft, :), false);
                pos(aircraft, :) = new_pos;
            end
        end

        % Plot the current positions of the aircraft
        scatter3(pos(:, 1), pos(:, 2), pos(:, 3), 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');

        clock_cycle = clock_cycle + 1;
        if ~safety_monitor(pos)
            disp(['Not safe at clock = ' num2str(clock_cycle) ', collision @ = [' num2str(pos(:).') ']']);
        end
        pos_hist = [pos_hist, pos];

        % Pause to observe the plot update
        pause(delay);
    end

    % Plot the paths of the aircraft
    for aircraft = 1:N
        plot3(pos_hist{aircraft}(:, 1), pos_hist{aircraft}(:, 2), pos_hist{aircraft}(:, 3), 'b-');
    end

    hold off;
end
