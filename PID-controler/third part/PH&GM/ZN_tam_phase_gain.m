kp= 0.14267;
Ti= 0.14637;
Td=2.7491 ;

s=tf('s');
g=63/((s+0.5)*(s+2)*(s+4));
c=kp+(kp/(Ti*s))+((kp*Td*s)/(((Td/10)*s)+1));
cg=c*g;
% hold on
% nyquist(g)
% nyquist(cg)
% r=1;
% for j=0:360
%     x(j+1)=r*cos((pi/180)*j);
%     y(j+1)=r*sin((pi/180)*j);
% end
% 
% hold on
% axis([-2 2 -2 2])
% plot(x,y,'r')
% plot(x,y,'y');
% legend('G','GC','r=1')

[GMg_1,PMg,~,~]=margin(g);
GMg=20*log10(GMg_1);

%PMg=2.04 deg
%GMg=0.6 dB
[GMcg_1,PMcg,~,~]=margin(c*g);
GMcg=20*log10(GMcg_1);
%PMcg=37.83 deg
%GMcg=7.4541 dB




% t = out.gp(:, 1); 
% y = out.gp(:, 2); 
% 
% plot(t, y, '-b', 'LineWidth', 1.5); 
% hold on;
% 
% 
% horizontal_lines = [1.02, 0.98, 0.1, 0.9]; 
% colors = ['r', 'g', 'm', 'k']; 
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
% %calculating IAE
% error=1-y;
% absIntegralError = trapz(t, abs(error));
% 
% %Tr=0.83
% %Ts%2=4.32
% %overshoot%=-
% %d=-
% %IAE=3.05