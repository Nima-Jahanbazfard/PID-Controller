% %for finding kdmp(d=0.25) and Tdmp
% n=1;
% t = out.znn(:, 1); 
% y = out.znn(:, 2); 
% 
% plot(t, y, '-b', 'LineWidth', 1.5); 
% hold on;
% 
% k=mean(y(end-n+1:end));
% 
% horizontal_lines = [k]; 
% colors = ['r']; 
% 
% % finding and showing points
% for i = 1:length(horizontal_lines)
%     line_value = horizontal_lines(i); 
%     %finding points
%     idx = find((y(1:end-1) - line_value) .* (y(2:end) - line_value) <= 0); 
%     
%     % calculating touching points
%     t_intersect = t(idx) + (t(idx+1) - t(idx)) .* ...
%                   (line_value - y(idx)) ./ (y(idx+1) - y(idx));
%     y_intersect = line_value * ones(size(t_intersect)); % value of output in touching points
%     %drawing lines
%     plot(t, line_value * ones(size(t)), '--', 'Color', colors(i), 'LineWidth', 1.2);
%     
%     % showing touching points
%     plot(t_intersect, y_intersect, 'o', 'MarkerSize', 8, ...
%          'MarkerFaceColor', colors(i), 'MarkerEdgeColor', 'k');
% end
% 
% xlabel('Time (s)');
% ylabel('Output');
% title('Curve and Intersection Points with Horizontal Lines');
% legend_entries = [{'Original Curve'}, ...
%                   arrayfun(@(x) sprintf('Line = %.2f', x), horizontal_lines, 'UniformOutput', false)];
% legend(legend_entries{:});
% grid on;
% hold off;
kdmp=0.545;
Tdmp=2.44;
%PID controler parameters
kp=1.1*kdmp;
Ti=Tdmp/3.6;
Td=Tdmp/9;
%kp=0.5995
%Ti=0.6778
%Td=0.2711
s=tf('s');
c=kp+(kp/(Ti*s))+((kp*Td*s)/(((Td/10)*s)+1));
g=63/((s+0.5)*(s+2)*(s+4));
% hold on
% nyquist(g)
% nyquist(c*g)
% r=1;
% for j=0:360
%     x(j+1)=r*cos((pi/180)*j);
%     y(j+1)=r*sin((pi/180)*j);
% end
% 
% hold on
% axis([-2 2 -2 2])
% plot(x,y,'y');
% legend('G','GC','r=1')
[GMg_1,PMg,~,~]=margin(g);
GMg=20*log10(GMg_1);
%PMg=2.04 deg
%GMg=0.6 dB
[GMcg_1,PMcg,~,~]=margin(c*g);
GMcg=20*log10(GMcg_1);
%PMcg=22.64 deg
%GMcg=20.39 dB




t = out.znn(:, 1); 
y = out.znn(:, 2); 

plot(t, y, '-b', 'LineWidth', 1.5); 
hold on;


horizontal_lines = [1.02, 0.98, 0.1, 0.9]; 
colors = ['r', 'g', 'm', 'k']; 

% finding and showing points
for i = 1:length(horizontal_lines)
    line_value = horizontal_lines(i); 
    %finding points
    idx = find((y(1:end-1) - line_value) .* (y(2:end) - line_value) <= 0); 
    
    % calculating touching points
    t_intersect = t(idx) + (t(idx+1) - t(idx)) .* ...
                  (line_value - y(idx)) ./ (y(idx+1) - y(idx));
    y_intersect = line_value * ones(size(t_intersect)); % value of output in touching points
    %drawing lines
    plot(t, line_value * ones(size(t)), '--', 'Color', colors(i), 'LineWidth', 1.2);
    
    % showing touching points
    plot(t_intersect, y_intersect, 'o', 'MarkerSize', 8, ...
         'MarkerFaceColor', colors(i), 'MarkerEdgeColor', 'k');
end

xlabel('Time (s)');
ylabel('Output');
title('Curve and Intersection Points with Horizontal Lines');
legend_entries = [{'Original Curve'}, ...
                  arrayfun(@(x) sprintf('Line = %.2f', x), horizontal_lines, 'UniformOutput', false)];
legend(legend_entries{:});
grid on;
hold off;
%calculating IAE
error=1-y;
absIntegralError = trapz(t, abs(error));
%Tr=0.4
%Ts%2=3.53
%overshoot%=43.18%
%d=0.14
%IAE=0.8309

