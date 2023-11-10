function [  ] = run(source, target)
%source and target are N x 3 matrices for initial and final (x,y,z) positions of N aircrafts
assert(size(source,2)==3,'Dimension of sources has to be 3')
assert(size(target,2)==3,'Dimension of targets has to be 3')
N=size(source,1);
assert(size(target,1)==N,'Number of targets has to be the same as number of sources')
assert(all(source(:,3)==0),'All soursces have to be on the ground (z=0)')
assert(all(target(:,3)==0),'All targets have to be on the ground (z=0)')

pos=source;
pos_hist = {pos};

while any(pos ~= target,"all")
    for aircraft=1:N
        if any(pos(aircraft,:)~=target(aircraft,:))
            [new_pos,dir]=aircraft_model(pos(aircraft,:),target(aircraft,:),false);
            pos(aircraft,:)=new_pos;
        end
    end
    pos_hist=[pos_hist,pos];
end

% Plot trajectory of aircraft
pos_hist=cat(3,pos_hist{:});
pause(2)
colors = rand(N, 3);
for i=1:length(pos_hist)
    for aircraft=1:N
        plot3(squeeze(pos_hist(aircraft,1, 1:i)), squeeze(pos_hist(aircraft,2, 1:i)),squeeze(pos_hist(aircraft,3, 1:i)),'Color', colors(aircraft, :),'LineWidth', 2,'DisplayName',sprintf('Aircraft %d', aircraft)); %'b+-'
        hold on;
        
        p=plot3(pos_hist(aircraft,1, i), pos_hist(aircraft,2, i),pos_hist(aircraft,3,i), 'ok', 'MarkerSize',5,'MarkerFaceColor',colors(aircraft, :));
        q=plot3(target(aircraft,1), target(aircraft,2),target(aircraft,3), 'xb', 'MarkerSize',10,'MarkerFaceColor',colors(aircraft, :),'MarkerEdgeColor',colors(aircraft, :));
        r=plot3(source(aircraft,1), source(aircraft,2),source(aircraft,3), 'or', 'MarkerSize',4,'MarkerFaceColor',colors(aircraft, :),'MarkerEdgeColor',colors(aircraft, :));
        set([p,q,r], 'HandleVisibility', 'off');
    end  
    % axis
    min_x = min([min(pos_hist(:,1,:),[],"all"),min(source(:,1)), min(target(:,1))]) - 1;
    max_x = max([max(pos_hist(:,1,:),[],"all"),max(source(:,1)), max(target(:,1))]) + 1;
    min_y = min([min(pos_hist(:,2,:),[],"all"),min(source(:,2)), min(target(:,2))]) - 1;
    max_y = max([max(pos_hist(:,2,:),[],"all"),max(source(:,2)), max(target(:,2))]) + 1;
    min_z = 0;
    max_z = max(pos_hist(:,3,:),[],"all") + 3;
    axis([min_x, max_x, min_y, max_y,min_z, max_z])
    title('3D Trajectories');
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    grid on;
    legend('AutoUpdate', 'off', 'Location', 'Best');
    % Add grid lines to the plot
    pause(.5)
    hold off;
end


