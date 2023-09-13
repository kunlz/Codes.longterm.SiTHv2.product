function [hh] = plotRange(line1,line2,facecolor,xinterval)
% funtion input
% line1 -- the line on the lower location, e.g., row vector [1, 200] 
% line2 -- the line on the upper location, e.g., row vector [1, 200] 
% facecolor -- the color need to be filled, e.g., [0.9,0.2,0.2]
% xinterval -- the step interval for the x-axis, e.g., row vector [1, 200] 
% ---

% --- example:
% % x intervals
% xinterval = (1:0.1:20);
% % y1
% line1 = sin(xinterval);
% % y2
% line2 = sin(xinterval) -1;
% plotRange(line1,line2,[0.9,0.3,0.2],xinterval)

% figure(3)
hh = fill([xinterval fliplr(xinterval)], [line1 fliplr(line2)],...
    facecolor,'EdgeColor','none','facealpha', 0.2); 
% hold on
% plot(xinterval,mean([y1;y2],1),'r','LineWidth',2) 

end