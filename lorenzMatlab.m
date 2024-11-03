clear all; clc;
Beta = [10; 28; 8/3]; % Chaotic values
x0 = [0; 1; 20]; % Initial Condition

dt = 0.005;
tSpan = dt:dt:50;

options = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,3));
[t,x] = ode45(@(t,x) lorenz(t,x,Beta), tSpan, x0, options);

%{
plot3(x(:,1),x(:,2),x(:,3),'w','LineWidth',1.5);
set(gca,'color','k','xcolor','w','ycolor','w','zcolor','w');
set(gcf,'color','k');
%}

% Prepare the figure
figure('Position', [100, 0, 1080, 960]);
set(gca, 'color', 'k', 'xcolor', 'k', 'ycolor', 'k', 'zcolor', 'k');
set(gcf, 'color', 'k');
hold on;

% Initialize the plot
h = plot3(x(1,1), x(1,2), x(1,3), 'color', [135/255, 206/255, 235/255], 'LineWidth', 1.5);

% Set axis limits
xlim([-20 20]);
ylim([-30 30]);
zlim([5 50]);

% Set view to isometric
view(3);

% Set up the video writer
v = VideoWriter('D:/CFD/MATLAB/lorenz_attractorFixed.avi'); % Name of the video file
v.FrameRate = 180; % Frame rate of the video
open(v);

% Fix the camera distance to prevent zooming effect
camproj('perspective');
campos([100, 100, 100]); % Set camera position
camtarget([0, 0, 0]); % Set target to origin
camva(7); % Set camera view angle

% Animation loop
for i = 2:length(t)
    % Update the plot data
    set(h, 'XData', x(1:i, 1), 'YData', x(1:i, 2), 'ZData', x(1:i, 3));
    
    % Rotate the view anticlockwise
    %angle = 360 * (i / length(t));
    view([1, -0.5, 0.25]); % Adjust the second parameter for vertical angle
    
    % Update the figure
    drawnow;
    
    % Write frame to video
    frame = getframe(gcf);
    writeVideo(v, frame);
end

% Close the video writer
close(v);