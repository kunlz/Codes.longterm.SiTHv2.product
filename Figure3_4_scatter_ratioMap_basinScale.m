

clc
clear

load waterbalancedET_compare_data.mat


% plot section
close all

cmp1 = [203, 67, 53]./255;
cmp2 = [0,0,0];


ha = tight_subplot(2, 3, [0 0], [0.1 0.1], [0.1 0.1]);
set(gcf,'unit','centimeters','position',[5,2,27,18]);

axes(ha(1))
ax1 = basinscatter(basinE52(1:11,:),result_ET0,cmp1);
text(0.1,0.9,'a','Units','normalized','FontSize',16,'FontWeight','bold')
text(0.1,0.7,'SiTHv2','Units','normalized','FontSize',12,'FontWeight','bold')
ax1.XTickLabel = {''};
ax1.XLabel.String = {''};

axes(ha(2))
ax2 = basinscatter(basinE52(1:11,:),result_ET1,cmp2);
text(0.1,0.9,'b','Units','normalized','FontSize',16,'FontWeight','bold')
text(0.1,0.7,'GLEAM','Units','normalized','FontSize',12,'FontWeight','bold')
ax2.XTickLabel = {''};
ax2.YTickLabel = {''};
ax2.YLabel.String = {''};
ax2.XLabel.String = {''};

axes(ha(3))
ax3 = basinscatter(basinE52(1:11,:),result_ET2,cmp2);
text(0.1,0.9,'c','Units','normalized','FontSize',16,'FontWeight','bold')
text(0.1,0.7,'CR','Units','normalized','FontSize',12,'FontWeight','bold')
ax3.XTickLabel = {''};
ax3.YTickLabel = {''};
ax3.YLabel.String = {''};
ax3.XLabel.String = {''};

axes(ha(4))
ax4 = basinscatter(basinE52(1:11,:),result_ET3,cmp2);
text(0.1,0.9,'d','Units','normalized','FontSize',16,'FontWeight','bold')
text(0.1,0.7,'GLDAS-Noah','Units','normalized','FontSize',12,'FontWeight','bold')

axes(ha(5))
ax5 = basinscatter(basinE52(1:11,:),result_ET4,cmp2);
text(0.1,0.9,'e','Units','normalized','FontSize',16,'FontWeight','bold')
text(0.1,0.7,'FluxCOM','Units','normalized','FontSize',12,'FontWeight','bold')
ax5.YTickLabel = {''};
ax5.YLabel.String = {''};

axes(ha(6))
ax6 = basinscatter(basinE52(1:11,:),result_ET5,cmp2);
text(0.1,0.9,'f','Units','normalized','FontSize',16,'FontWeight','bold')
text(0.1,0.7,'ERA5L','Units','normalized','FontSize',12,'FontWeight','bold')
ax6.YTickLabel = {''};
ax6.YLabel.String = {''};

%% export figure
exportgraphics(gcf,'basin2.png','Resolution',600);
close all

%% process to Ratio map

[RatioX(1,:)] = calRatio(basinE52, result_ET0);
[RatioX(2,:)] = calRatio(basinE52, result_ET1);
[RatioX(3,:)] = calRatio(basinE52, result_ET2);
[RatioX(4,:)] = calRatio(basinE52, result_ET3);
[RatioX(5,:)] = calRatio(basinE52, result_ET4);
[RatioX(6,:)] = calRatio(basinE52, result_ET5);

RatioX2 = RatioX'; 

Zc_tem = mask;
for i = 1 : 52
    ai = Zc_tem;
    ai(ai~=i) = 0;
    ai(ai~=0) = 1;
    Zc_new{i,1} = ai;
end

% 49 basins
Zc_new([16,19,50],:) = []; 

 
FFdata = zeros(720,1440);
for i = 1 : 49
    fdata = RatioX(1,i)*ones(720,1440);
    Zc = Zc_new{i,1};

    fdata(Zc~=1) = 0;
    FFdata = FFdata + fdata;
end

%% plot section

close all

cmp1 = [203, 67, 53]./255;
cmp2 = [0,0,0];

ha = tight_subplot(1, 2, [0 0.08], [0.1 0.1], [0.1 0.1]);
set(gcf,'unit','centimeters','position',[5,2,26,12]);

axes(ha(1))
[ax,ch,cmp] = plotBasinRatio(FFdata, [0,2]); 
pos = ch.Position;
pos(4) = 0.5*pos(4); % colorbar height/width
pos(3) = 0.8*pos(3); % colorbar height/width
pos(2) = pos(2)-0.08; % colorbar offset to axis
pos(1) = pos(1)+0.035; % colorbar offset to axis
ch.Position = pos;
cbarrow(ch,cmp)

axes(ha(2))
% cgroupdata = repmat([1,2,3,4,5,6],49,1);
bc = boxchart(RatioX2); hold on
bc.BoxWidth = 0.4;
ggThemeBox(gca,'fresh');

plot([0,6.8],[1,1],'LineWidth',1,'Color',cmp1,...
    'LineStyle','--');
% 
% bc.BoxWidth = 0.4;
set(gca,'XTickLabel',{'SiTHv2','GLEAM','CR','GLDAS-Noah','FluxCOM','ERA5L'})
ax2 = gca;
ax2.XLim = categorical([1,6]);
ax2.YLim = [0.4,2.5];
ax2.FontSize = 11;
ax2.TickLength = [0.01,0.1];
set(gca,'TickDir','out','LineWidth',1)
set(ax2,'Position',[0.53,0.304,0.35,0.393],'Units','normalized')

ax2.XColor = [0,0,0]./255;
ax2.YColor = [0,0,0]./255;

% first box
ax2.Children(end-3).FaceColor = cmp1;
ax2.Children(end-2).MarkerFaceColor = cmp1;
ax2.Children(end-1).SizeData = 25;
ax2.Children(end-1).MarkerFaceColor = cmp1;

% bc.WhiskerLineColor = 'k';
bc.MarkerStyle = "none"; 

ax2.YLabel.String = 'Ratio';


annotation(gcf,'textbox',...
        'Units','centimeters',...
        'Position',[2.5 8.1 1 1],...
        'String','a',...
        'FontSize',16,...
        'FontName','Arial',...
        'FontWeight','bold',...
        'FitBoxToText','off',...
        'EdgeColor','none',...
        'Color',[0, 0, 0]./255,...
        'Interpreter','none');
annotation(gcf,'textbox',...
        'Units','centimeters',...
        'Position',[13.6 8.1 1 1],...
        'String','b',...
        'FontSize',16,...
        'FontName','Arial',...
        'FontWeight','bold',...
        'FitBoxToText','off',...
        'EdgeColor','none',...
        'Color',[0, 0, 0]./255,...
        'Interpreter','none');

%% export figure
exportgraphics(gcf,'basin3.png','Resolution',600);
close all



