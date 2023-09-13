
function [] = plotglobalETraster3(ETym,landprop,krange,cbTick,IDs,Yticks2,label2,ETyS)
% plot section


figure('unit','centimeters','position',[6,6,26,14]);

% left axis
ax1 = axes('Position',[0.1 0.05 0.65 0.9]);

ETym(landprop>=90) = NaN;
[ch,cmm] = plotmap(ETym, 'Equidistant Cylindrical',...
    'ytics',cbTick,... % 'latlon', {latx,lonx}
    'globres', 0.1,'latlim', [-89.9,89.9], 'lonlim', [-180,179.9],... % 'latlim', [-20,15], 'lonlim', [-85,-30]
    'krange', krange, 'colormap', 'YlGnBu',...
    'labelname', [IDs ' (mm year^{–1})'],...
    'fontsize', 14,...
    'title',' ');
% load cmap.mat
% cmp = cmap.MPLterrain;
% % cmp = brewermap(128,'PuBuGn');
% colormap(flipud(cmp))
% cmp2 = readmatrix('GMT_haxby.txt');
% cmp3 = interpcmp(cmp2,132);
cmp2 = [236, 240, 241;
    130, 119, 23;
    244, 208, 63;
    205, 220, 57;
    139, 195, 74;
    34, 153, 84;
    14, 102, 85;
    108, 52, 131;
    ]./255;
cmp3 = interpcmp(cmp2,128);
colormap(cmp3)


% text(0.001,1.04,'a','FontSize',18,'FontWeight','bold','Units','normalized');

% right axis
% set a white background
ax2 = axes('Position',[0.85 0.05 0.9 0.9],'Color','w');
% our results
ETym1 = ETym;
LatC = mean(ETym1,2,'omitnan');
LatCstd = std(ETym1,0,2,'omitnan');
cmp1 = [229, 57, 53]./255;
bx1800  = rot90(-90+0.05:0.1:90-0.05);
a1 = (LatC-LatCstd)';
a2 = (LatC+LatCstd)';
a1(isnan(a1)) = 0;
a2(isnan(a2)) = 0;
h3 = plotRange(a1,a2,cmp1,bx1800'); hold on

bx720  = rot90(-90+0.125:0.25:90-0.125);

cmp = [19, 141, 117;
    243, 156, 18;
    125, 60, 152;
    240, 98, 146;
    192, 202, 51]./255;
for i = 1 : 5
    ETys1 = ETyS(:,:,i);
    LatCs = mean(ETys1,2,'omitnan');

    plot(bx720,LatCs,'DisplayName','Mean ET', 'LineWidth',1.5,...
        'Color',cmp(i,:),'LineStyle','-.');
    hold on
end

h2 = plot(bx1800,LatC,'DisplayName','Mean ET', 'LineWidth',2,...
    'Color',cmp1); hold on
h2.LineWidth = 1.5;


% Create ylabel
ylabel('(mm year^{–1})');
% Create xlabel
xlabel(' ');
xlim([-90,90])
ylim([0,Yticks2(end)])
% title('Zonally mean')

% Set the remaining axes properties
set(gca, 'FontName', 'Arial', 'FontSize',14);
% Create legend
% legend1 = legend(h2,'SiTHv2'); hold on
% legend2 = legend(h3,'s.t.d.');

legend1 = legend(gca,{'','GLEAM','CR','GLDAS-Noah','FluxCOM',...
    'ERA5L','SiTHv2'});

set(legend1,'FontSize',10,'FontName','Arial','Box','on');
set(gca,'XTick',[-45,0,45],...
    'XTickLabel',{' ',' ',' ',' ',' '},...
    'XGrid','on','YGrid','on','LineWidth',1,...
    'TickDir','in','TickLength',[0.01,0.1])
set(gca,'YTick',Yticks2)
view(90,-90)

ax2.Position = [0.77 0.2745 0.17 0.6034];

% text(0.01,1.04,'b','FontSize',18,'FontWeight','bold','Units','normalized');

end