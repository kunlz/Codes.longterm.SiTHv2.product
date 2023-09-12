%% Comparison T/ET data over China

clc
clear
load annual_T_ET_data_comparison.mat

close all
set(gcf,'unit','centimeters','position',[5,2,18,12]);

% axis-1
% map in axis-1 was generated in QGIS

% axis-2
ax1 = axes('Position',[0.55,0.55,0.4,0.4],'Units','normalized');

% reshape the raster to vector
xx = Tratio1x(:);
yy = Tratio2x(:);
inx = isnan(xx) | isnan(yy);
xx(inx,:) = [];
yy(inx,:) = [];
h = dscatter(xx,yy); hold on
cmp = brewermap(128,'*YlGnBu');
colormap(cmp);

% plot fit line
[a, b] = fityy(xx,yy);
xxx = 0:0.1:1;
yyy = xxx;
y1 = a.*xxx + b;
plot(xxx,yyy,'--','LineWidth',1.5,'Color',[0.3,0.6,0.4,0.8]);
plot(xxx,y1,'LineWidth',1.5,'Color',[255, 179, 0]./255);

axis square
xlim([0,1]);
ylim([0,1]);
set(ax1,'TickDir','out','LineWidth',1,'FontSize',9);
set(ax1,'XTick',0:0.2:1,'YTick',0:0.2:1);
xlabel(ax1,'T/ET (MDF)','FontSize',9)
ylabel(ax1,'T/ET (SiTHv2)','FontSize',9)
op1 = evaluation(xx,yy);

opp = op1;
R = sprintf('%0.2f',opp(2));
Bias = sprintf('%0.2f',opp(1));
RMSE = sprintf('%0.2f',opp(5));
NSE = sprintf('%0.2f',opp(7));
k = sprintf('%0.2f',opp(3));
b = opp(4);
if b > 0
    b = sprintf('%0.2f',opp(4));
    texx = {['R = ' R],['RMSE = ' RMSE],['y = ' k 'x+' b]};
else
    b = abs(b);
    b = sprintf('%0.2f',b);
    texx = {['R = ' R],['RMSE = ' RMSE],['y = ' k 'x-' b]};
end
text(ax1,0.58,0.14,texx,'Units','normalized','FontSize',8,'Interpreter','tex',...
    'Color','k','EdgeColor','none','FontName','Arial',...
    'BackgroundColor',[1 1 1])

% axis-3
ax3 = axes('Position',[0.05,0.1,0.9,0.35],'Units','normalized');
set(ax3,'Position',[0.25,0.1,0.635,0.34],'Units','normalized');
set(ax3,'TickDir','out','LineWidth',1,'FontSize',14);
p1 = plot(1981:2015,bm,'LineWidth',2,'Color',[25, 111, 61]./255); hold on
p2 = plot(1982:2020,am,'LineWidth',2,'Color',[231, 76, 60]./255);
xlim([1982,2020]);
ylim([0.52,0.62]);
ax3.Box = "off";
set(ax3,'TickDir','out','LineWidth',1,'FontSize',9);
xlabel(ax3,'Years')
ylabel(ax3,'T/ET')

% statistics
op2 = evaluation(bm(2:35,1),am(1:34,1));
Rx = sprintf('%0.2f',op2(2));

x1 = (1981:2015)';
[a, b] = fityy(x1,bm);
y1 = a*x1 + b;
plot(ax3,x1,y1,'LineWidth',1.5,'Color',[56, 142, 60]./255);
tr1x = sprintf('%0.3f',a);

x1 = (1982:2020)';
[a, b] = fityy(x1,am);
y1 = a*x1 + b;
plot(ax3,x1,y1,'LineWidth',1.5,'Color',[244, 81, 30]./255);
tr2x = sprintf('%0.3f',a);

text(ax3,0.595, 0.24, 'Linear trend = ', 'Units', 'Normalized',...
    'Color','k','fontsize', 9);
text(ax3,0.766, 0.24, [' ' tr1x '  MDF'], 'Units', 'Normalized',...
    'Color',[56, 142, 60]./255,'fontsize', 9);
text(ax3,0.766, 0.12, [' ' tr2x '  SiTHv2'], 'Units', 'Normalized',...
    'Color',[244, 81, 30]./255,'fontsize', 9);
text(ax3,0.722, 0.37, ['R = ' Rx], 'Units', 'Normalized',...
    'Color','k','fontsize', 9);


% export figure
exportgraphics(gcf,'T_ET.png','Resolution',600);
close all