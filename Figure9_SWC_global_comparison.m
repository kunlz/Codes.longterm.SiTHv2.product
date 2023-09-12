

%% global mean annual regression
clc
clear

load meanAnnualSMdata_SiTHv2_SoMo.mat

a1 = double(reshape(sm1a,[720*1440,1]));
b1 = double(reshape(sm1b,[720*1440,1]));

% remove NaN and zero-value
inx = a1==0 | b1 ==0 | isnan(a1) | isnan(b1);
a1(inx) = [];
b1(inx) = [];

close all
h = dscatter(b1,a1);
[map1] = brewermap(128,'*GnBu');
colormap(map1)

% axis square
xlim([0,0.5])
ylim([0,0.5])

% 1:1 line
xx = 0:0.1:0.5;
yy = xx;
hold on
plot(xx,yy,'LineWidth',1,'Color','k','LineStyle','--')
set(gca,'LineWidth',1,'Color','w','TickDir','out','FontSize',12)

% trend line
[opp] = evaluation(b1,a1);
ys = opp(3).*xx + opp(4);
plot(xx, ys, 'LineWidth', 2, 'LineStyle', '-', 'Color',[[39, 174, 96]./255, 0.8]);

% statistics
R = sprintf('%0.2f',opp(2));
Bias = sprintf('%0.2f',opp(1));
RMSE = sprintf('%0.2f',opp(5));
NSE = sprintf('%0.2f',opp(7));
k = sprintf('%0.2f',opp(3));
b = opp(4);
if b > 0
    b = sprintf('%0.2f',b);
    texx = {['R = ' R],['RMSE = ' RMSE],['NSE = ' NSE],['y = ' k 'x+' b]};
else
    b = abs(b);
    b = sprintf('%0.2f',b);
    texx = {['R = ' R],['RMSE = ' RMSE],['NSE = ' NSE],['y = ' k 'x-' b]};
end

text(0.1,0.8,texx,'Units','normalized','FontSize',12,'Interpreter','latex',...
    'Color','k','EdgeColor','none','FontName','Arial') 

axis square

xlabel('SWC from SoMo.ml (m^3 m^{-3})')
ylabel('SWC from SiTHv2 (m^3 m^{-3})')

% export figure
exportgraphics(gcf,'SM_scatter2.png','Resolution',600);
close all

%% temporal variation

clc
clear

load annual_variation_SMdata_SiTHv2_SoMo.mat


% statistics
[opp] = evaluation(a_ssb1,a_ssa1);
R = sprintf('%0.2f',opp(2));
texx = {['R = ' R]};

close all
plot([1998,2020],[0,0],'LineStyle','-','Color','k','LineWidth',1)
hold on
plot(2000:2019,a_ssb1,"LineWidth",2,"Color",[230, 74, 25]./255,...
    'Marker','.','MarkerSize',28,'DisplayName','SoMo.ml'); 
plot(2000:2019,a_ssa1,"LineWidth",2,"Color",[0, 121, 107]./255,...
    'Marker','.','MarkerSize',28,'DisplayName','SiTHv2');
xlim([1999,2020])
box off
set(gca,'LineWidth',1,'Color','w','TickDir','out','FontSize',12)

ylabel('SWC anomalies (m^3 m^{-3})')
xlabel('Years')
legend({'','SoMo.ml','SiTHv2'},"Box","off")
text(0.1,0.25,texx,'Units','normalized','FontSize',12,'Interpreter','latex',...
    'Color','k','EdgeColor','none','FontName','Arial') 

% export figure
exportgraphics(gcf,'SM_temporal2.png','Resolution',600);
close all
%% spatial mean
clc
clear

load meanAnnualSMdata_SiTHv2_SoMo.mat
load mask25.mat
load cmap.mat

close all
plotglobalSMraster(sm1a,mask25,[0,0.4],0:0.1:0.4, 'Surface SWC (m^3 m^{-3})',0:0.2:0.4);
% cmp1 = cmap.WhiteBlueGreenYellowRed;
% cmp1 = flipud(cmap.MPLterrain);
% colormap(cmp1)

exportgraphics(gcf,'SM_gloablpattern.png','Resolution',600);
close all

