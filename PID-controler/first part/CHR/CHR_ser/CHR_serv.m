%CHR_SERV OPEN LOOP
k=15.7452;
T=2.37;
T_d=0.5788;
alpha=T_d/T;

%PID CONTROLER PARAMERTERS
kp=0.6/(k*alpha);
Ti=T_d;
Td=T_d*0.5;
%KP=0.1560
%Ti=0.5788
%Td=0.2894
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
% legend('G','GC','r=1');
[GMg_1,PMg,~,~]=margin(g);
GMg=20*log10(GMg_1);
%PMg=2.4 deg
%GMg=0.6 dB
[GMcg_1,PMcg,~,~]=margin(c*g);
GMcg=20*log10(GMcg_1);
%PMcg=16.8863 deg
%GMcg=31.5971 dB




t = out.chos(:, 1); 
y = out.chos(:, 2); 

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

error=1-y;
absIntegralError = trapz(t, abs(error));

%parameters for step
%Tr=1.24
%Ts%2=5.16
%overshoot%=9.8%
%d=-
%IAE=1.1537