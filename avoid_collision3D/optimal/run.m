function [] = run(source, target)
% This function simulates the movement of aircraft from source to target positions in 3D space.

safety_dist=2;

%delete targets=sources
done_aircrafts = ~any(source-target, 2);
source(done_aircrafts, :) = []; 
target(done_aircrafts, :) = []; 


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
ahead_exp=cell(N,1);
ortho_exp=cell(N,1);
back_exp=cell(N,1);
old_pos=source;

%colors generation
hue_values = linspace(0, 1, N)';
saturation = 0.8 * ones(N, 1);
value = 0.8 * ones(N, 1);
colors_hsv = [hue_values, saturation, value];

% Convert HSV to RGB
colors_rgb = hsv2rgb(colors_hsv);

colors = colors_rgb; %rand(N, 3);
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
axis([min_values(1)-3, max_values(1)+5, min_values(2)-5, max_values(2)+5, 0, max_values(3)+5])

% Plot the initial positions of the aircrafts
scatter3(source(:, 1), source(:, 2), source(:, 3), 50, colors, 'filled','Marker', 'o');
% Plot the final positions of the aircrafts
scatter3(target(:, 1), target(:, 2), target(:, 3), 50, colors, 'x', 'LineWidth', 2);

% Simulation loop: run until all aircrafts have reached their targets
n=N;% n = number of aircrafts that has not arrived 
while n>0
    aircraft=1;
    while aircraft <= n 
        plot3([old_pos(aircraft, 1); pos(aircraft,1)], [old_pos(aircraft, 2); pos(aircraft,2)], [old_pos(aircraft, 3); pos(aircraft,3)], '-', 'Color', colors(aircraft, :), 'LineWidth', 2);
        if any(pos(aircraft, :) ~= target(aircraft, :)) %if current po
            % if isequal(old_pos(aircraft, :),pos(aircraft,:)) && (pos(aircraft,3)~=0)
            %     disp('Didnt move being at hthe air')
            % end
            % sition is not the final destination
            [ahead_exp{aircraft},ortho_exp{aircraft}, back_exp{aircraft}] = aircraft_model(pos(aircraft, :), target(aircraft, :)); % call model for new position
            aircraft=aircraft+1;
        else
            colors(aircraft,:)=[];
            ahead_exp=ahead_exp([1:aircraft-1, aircraft+1:end]);
            ortho_exp=ortho_exp([1:aircraft-1, aircraft+1:end]);
            back_exp=back_exp([1:aircraft-1, aircraft+1:end]);
            pos(aircraft, :) = [];
            old_pos(aircraft, :) = [];
            target(aircraft, :)= [];
            n=n-1;
            disp(n)
        end
    end
    if n>0
        old_pos=pos;
        inc=controller(old_pos,ahead_exp,ortho_exp, back_exp,safety_dist);
        pos=pos+inc;       
    end

    drawnow;
    %plot3([old_pos(aircraft, 1); pos(aircraft,1)], [old_pos(aircraft, 2); pos(aircraft,2)], [old_pos(aircraft, 3); pos(aircraft,3)], '-', 'Color', colors(aircraft, :), 'LineWidth', 2);
    %Call Safety Monitor and pause plot if in unsafe state
    clock_cycle=clock_cycle+1;
    if ~safety_monitor(pos) && ~paused
        disp(['Not safe at clock = ' num2str(clock_cycle) ', collision @ = [' num2str(pos(:).') ']']);
        pause_text = text(mean(xlim), mean(ylim), mean(zlim), 'Unsafe Condition!', 'FontSize', 20, 'HorizontalAlignment', 'center', 'Color', 'red');
        
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
pause;
close all

%Examples
%run([0, 0, 0; 1, 1, 0; 2, 2, 0], [5, 5, 0; 7, 7, 0; 10, 10, 0]);%safe
%run([0, 0, 0; 0, 1, 0; 1, 0, 0], [10, 10, 0; 5, 5, 0; 2, 2, 0]);%collide
%run([0, 0, 0; 0, 1, 0; 0, 2, 0; 0, 0, 0; 2, 2, 0; 4, 4, 0], [5, 5, 0; 5, 5, 0; 5, 5, 0; 5, 5, 0; 5, 5, 0; 5, 5, 0]);
%run([-2, 2, 0;3, 3, 0;0, 0, 0; 0, 1, 0; 0, 2, 0; 0, 0, 0; 2, 2, 0; 4, 4, 0], [5, 5, 0;5, 5, 0;5, 5, 0; 5, 5, 0; 5, 5, 0; 5, 5, 0; 5, 5, 0; 5, 5, 0])
%run([-2, 2, 0;3, 3, 0;-2, 2, 0;3, 3, 0;-2, 2, 0;3, 3, 0;0, 0, 0; 0, 1, 0; 0, 2, 0; 0, 0, 0; 2, 2, 0; 4, 4, 0], [5, 5, 0;5, 5, 0;5, 5, 0; 5, 1, 0; 5, 5, 0; 4, 5, 0; 5, 3, 0; 5, 5, 0;5, 3, 0; 5, 5, 0; 5, 5, 0; 5, 5, 0])

% random position
% N=12
% grid_size=15
%run([round(grid_size * rand(N, 2)), zeros(N, 1)], [round(grid_size * rand(N, 2)), zeros(N, 1)])