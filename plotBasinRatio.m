

function [ax,h,cmp3] = plotBasinRatio(FFdata, k)

FFdata(FFdata==0) = NaN;
lat =  -89.875 : 0.25 : 89.875;
long =  -179.875 : 0.25 : 179.875;
LT11 = flipud(repmat(lat',1,1440));
LG11 = repmat(long,720,1);

% close all
% figure(1)
% set(gcf,'unit','centimeters','position',[2,6,16,8]);
% Set the box limit (Window) for what you want to show
LATLIMS = [-89.9, 89.9]; % set latitude limit
LONLIMS = [-180, 180]; % set longitude limit
m_proj('Equidistant Cylindrical','lon',LONLIMS,'lat',LATLIMS);hold on
cs = m_coast('patch',[1 1 1],'edgecolor',[0.3, 0.3, 0.3]);
m_grid('linewi',1,'tickdir','in',... % set line
    'FontName','Arial','FontSize',10,... % set the font
    'backcolor',[234, 242, 248]/255,...
    'xtick', -120:60:120,'ytick', -90:45:90); % set tha background color

m_pcolor(LG11,LT11,FFdata);
% k = [0,2];
clim(k)
% colormap1 = [
%     84   48    5
%     140   81   10
%     191  129   45
%     223  194  125
%     246  232  195
%     245  245  245
%     199  234  229
%     128  205  193
%     53  151  143
%     1  102   95
%     0   60   48]./255;
% colormap(flipud(colormap1))
load('cmap.mat')
cmp1 = cmap.cmap22;
cmp2 = cmp1;
cmp2([1:50,end-49:end],:) = [];
cmp3 = flipud(cmp2);
colormap(cmp3)

cs = m_coast('color',[0.3, 0.3, 0.3]);
h = colorbar('southoutside');
set(h,'FontName','Arial','FontSize',12,'TickDirection','out',...
    'TickLength',0.005);
set(get(h,'xlabel'),'String','Ratio',...
    'FontName','Arial','FontSize',12);
ax = gca;
end