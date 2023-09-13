clc
clear

load mask25.mat

%
% time series
% IDs = {'SiTHv2','GLEAM','CR','GL-Noah','FluxCOM','ERA5L'};
% for k = 1 : 6
%     k
%     datak = ETdata{k};
%     len = size(datak,3);
%     clear TET MET RLA
%     for i = 1 : len
%
%         ETi = datak(:,:,i);
%         [TET(i,1),MET(i,1),RLA(i,1),area2,X2] = CalglobalETamount(ETi,0.25,0.01.*mask25);
%     end
%
%     ETx{1,k} = IDs{k};
%     ETxm{1,k} = IDs{k};
%     ETx{2,k} = TET;
%     ETxm{2,k} = MET;
% end


% plot section
load annual_global_ET_variation_multi_products.mat
load CMIP6.ETy.20member.Yearly.A2001_2014.mat

yrs = {1982:2020,1982:2020,1982:2016,1982:2014,...
    2001:2013,1982:2020};
cmp1 = [229, 57, 53]./255;
cmp = [19, 141, 117;
    243, 156, 18;
    125, 60, 152;
    240, 98, 146;
    192, 202, 51]./255;
cmpx = [cmp1;cmp;[1,1,1]./255];

close all

% ha = tight_subplot(1, 2, [0 0.08], [0.1 0.1], [0.1 0.1]);
set(gcf,'unit','centimeters','position',[5,2,28,12]);
% axis 1
ax1 = axes('Position',[0.08,0.2,0.6,0.6],'Units','normalized');

METx = MET - mean(MET,1);
lr = iqr(METx,2);
line3 = mean(METx,2);
lineM = mean(line3);
xinterval = 1979:2014;
hold on
% figure
plotRange((line3-lr)',(line3+lr)',[0.2,0.2,0.2]./255,xinterval)
plot(xinterval, median(METx,2),'LineWidth',2,'LineStyle','-','Color','k')

% ax1 = gca;
ax1.Box = "off";
ax1.TickDir = "out";
ax1.LineWidth = 1;
ax1.FontSize = 12;
ax1.XLim = [1982,2020];
ax1.YLim = [-26,24];
ax1.YLabel.String = 'ET anomalies (mm year^{–1})';
text(ax1,0.03,0.93,'a','FontSize',18,'FontWeight','bold','Units','normalized')

% ET model
n = 1;
for i = 2 : 6

    ETi = ETxm1{2,i};
    ETia = ETi-mean(ETi);
    plot(yrs{i},ETia,'LineWidth',2,'Color',cmp(n,:),'LineStyle','-.');
    n = n+1;
    [tr1(i,1),h1,p1(i,1)] = calTrend(ETia);

end

% plot SiTHv2
ETi = ETxm1{2,1};
ETia = ETi-mean(ETi);
plot(yrs{1},ETia,'LineWidth',3,'Color',cmp1);
[tr1(1,1),h1,p1(1,1)] = calTrend(ETia);
[tr1(7,1),h1,p1(7,1)] = calTrend(median(METx,2)); % CMIP6 median

ax3 = axes('Position',[0.4,0.2,0.6,0.3],'Units','normalized');
set(ax3,'Position',[0.51,0.22,0.16,0.18],'Units','normalized');
plot([0,8],[0,0],'LineWidth',1,'Color','k'); hold on
for p = 1 : 7
    ba = bar(ax3,p,tr1(p,1),'barwidth',0.7,'FaceColor',cmpx(p,:)); hold on
    if p1(p,1) <0.01
        txx = '**';
    elseif p1(p,1) >0.01 && p1(p,1) <0.05
        txx = '*';
    else
        %         txx = [num2str(tr1(p,1),'%4.2f') '^{n.s.}'];
        txx = 'n.s.';
    end
    if tr1(p,1) > 0
        text(gca,p,tr1(p,1),txx,"HorizontalAlignment","center",...
            'VerticalAlignment','baseline');
    else
        text(gca,p,tr1(p,1),txx,"HorizontalAlignment","center",...
            'VerticalAlignment','top');
    end
end
ax3.Box = "off";
ax3.XColor = 'none'; % Red
ax3.YLim = [-0.22,0.54];
ax3.XLim = [0.2,7.8];
ax3.TickDir = "out";
ax3.FontSize = 10;
ax3.LineWidth = 1;
% ba.BarWidth = 0.5;
text(ax1,0.52, 0.2, 'Linear trend ', 'Units', 'Normalized',...
    'Color','k','fontsize', 12);
text(ax1,0.53, 0.12, '(mm year^{–1})', 'Units', 'Normalized',...
    'Color','k','fontsize', 11);



IDs = {'SiTHv2','GLEAM','CR','GL-Noah','FluxCOM','ERA5L','CMIP6'};
% for xx = 1 : 6
%     if p1(xx,1) < 0.01
%         labels{xx} = [IDs{xx} '=' num2str(tr1(xx,1),'%4.2f') '^{**}'];
%     elseif p1(xx,1) > 0.01 && p1(xx,1) < 0.05
%         labels{xx} = [IDs{xx} '=' num2str(tr1(xx,1),'%4.2f') '^{*}'];
%     else
%         labels{xx} = [IDs{xx} '=' num2str(tr1(xx,1),'%4.2f') '^{n.s.}'];
%     end
% end


% text(ax1,0.4, 0.2, labels{1}, 'Units', 'Normalized',...
%     'Color',cmp1,'fontsize', 12);
% text(ax1,0.65, 0.2, labels{2}, 'Units', 'Normalized',...
%     'Color',cmp(1,:),'fontsize', 12);
% text(ax1,0.8, 0.2, labels{3}, 'Units', 'Normalized',...
%     'Color',cmp(2,:),'fontsize', 12);
% text(ax1,0.4, 0.12, labels{4}, 'Units', 'Normalized',...
%     'Color',cmp(3,:),'fontsize', 12);
% text(ax1,0.6, 0.12, labels{5}, 'Units', 'Normalized',...
%     'Color',cmp(4,:),'fontsize', 12);
% text(ax1,0.8, 0.12, labels{6}, 'Units', 'Normalized',...
%     'Color',cmp(5,:),'fontsize', 12);


legend(ax1,{'IQR of CMIP6','Median of CMIP6','GLEAM','CR','GLDAS-Noah','FluxCOM',...
    'ERA5L','SiTHv2'},...
    'Position',[0.16 0.69 0.458 0.089],'NumColumns',4,'Box','off');


% axis-2
clear ETsw ETswl
n = 1;
for i = 1 : 6

    if i == 1
        a = ETx1{2,1};
        ETsw(n:n+length(a)-1,1) = a;
        ETswl(n:n+length(a)-1,1) = ones([length(a) 1]);
        n = n+length(a);
    else
        a = ETx1{2,i};
        ETsw(n:n+length(a)-1,1) = a;
        ETswl(n:n+length(a)-1,1) = repmat(2, [length(a) 1]);
        n = n+length(a);
    end
end

% CMIP6
n = 1;
for i = 1 : 20

    ETi = TET(:,i);
    ETsw2(n:n+length(ETi)-1,1) = ETi;
    ETswl2(n:n+length(ETi)-1,1) = 3.*ones([length(ETi) 1]);
    n = n+length(ETi);
end

% ----
% axis 2
ax2 = axes('Position',[0.78,0.2,0.2,0.6],'Units','normalized');
plotRange(6.5e4.*ones(1,41),7.5e4.*ones(1,41),[153, 163, 164]./255,0:0.1:4);
hold on

TT = table([ETsw;ETsw2],[ETswl;ETswl2]);
% boxchart(TT.Var2,TT.Var1);
plotRange(6.5e4.*ones(1,41),7.5e4.*ones(1,41),[153, 163, 164]./255,0:0.1:4);
hold on
vs = violinplot(TT.Var1, TT.Var2);
vs(1,1).ViolinColor{1,1} = cmp1;
vs(1,2).ViolinColor{1,1} = [26, 82, 118]./255;
vs(1,3).ViolinColor{1,1} = [220, 118, 51]./255;
vs(1, 1).ScatterPlot.SizeData = 8;
vs(1, 2).ScatterPlot.SizeData = 8;
vs(1, 3).ScatterPlot.SizeData = 8;
vs(1, 1).MedianPlot.SizeData = 22;
vs(1, 2).MedianPlot.SizeData = 22;
vs(1, 3).MedianPlot.SizeData = 22;
vs(1, 1).MedianPlot.LineWidth = 1;
vs(1, 2).MedianPlot.LineWidth = 1;
vs(1, 3).MedianPlot.LineWidth = 1;

ax2.Box = "off";
ax2.FontSize = 12;
ax2.TickDir = 'out';
ax2.LineWidth = 1;
ax2.TickLength = [0.02,0.05];
ax2.YLim = [5.8e4,9.7e4];
ax2.XLim = [0.5,3.5];
ax2.YLabel.String = 'ET volume (km^3 year^{–1})';
ax2.XTickLabel = {'SiTHv2','ETPs','CMIP6'};

text(ax2,0.08,0.93,'b','FontSize',18,'FontWeight','bold','Units','normalized')

%% export figure
exportgraphics(gcf,'globalcomparison2.png','Resolution',600);
close all



