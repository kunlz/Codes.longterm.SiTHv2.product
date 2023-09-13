
function [ax] = basinscatter(ETwby,result_ET1,cmp,xx,yy)

for i = 1 : 52

    % sum2yearly
    x_y = ETwby(:,i);
    y_y1 = result_ET1(:,i);
    
    % reject 3 basins without valid ETwb
    a = x_y;
    y_y1(a>10000,:) = [];
    a(a>10000,:) = [];
    x_y = a;

    if isempty(a) || length(a)<3
        continue
    end

    if i == 0
        cmp1 = [0,0,0];
    else
        cmp1 = cmp;
    end

    yneg = std(y_y1);
    ypos = std(y_y1);
    xneg = std(x_y);
    xpos = std(x_y);

    xx(i,1) = mean(x_y);
    yy(i,1) = mean(y_y1);

    errorbar(xx(i,1),yy(i,1),yneg,ypos,xneg,xpos,'MarkerSize',16,...
        'MarkerFaceColor',cmp1,...
        'MarkerEdgeColor',cmp1,...
        'Marker','.',...
        'LineStyle','none',...
        'LineWidth',.5,...
        'CapSize',1,...
        'Color',cmp1);
    hold on
    axis square; box on; grid off;
end

% plot 1:1 line
x = -20:0.1:1800;
y = x;
plot(x, y, 'LineWidth', .8, 'LineStyle', '--', 'Color',[0, 0, 0, 0.5]);
xlabel('ET_{wb} (mm year^{–1})');
ylabel('ET_{sim} (mm year^{–1})');
xlim([0, 1800])
ylim([0, 1800])
[op] = evaluation(xx,yy);
ys = op(3).*x + op(4);


% plot trend line
plot(x, ys, 'LineWidth', .8, 'LineStyle', '-', 'Color',[cmp1, 0.7]);
set(gca, 'FontName', 'Arial', 'FontSize', 12);
set(gca,'Linewidth',1,'XTick',[300,600,900,1200,1500],...
    'XTickLabel',{'300','600','900','1200','1500'},...
    'YTick',[300,600,900,1200,1500],...
    'YTickLabel',{'300','600','900','1200','1500'});
ytickangle(90)
% opx(1,:) = op;
% set white background for this figure
set(gcf, 'color', 'w');

% write statistics
opp = op;
R = sprintf('%0.2f',opp(2));
% Bias = sprintf('%0.2f',opp(1));
RMSE = sprintf('%0.2f',opp(5));
NSE = sprintf('%0.2f',opp(7));
k = sprintf('%0.2f',opp(3));
b = opp(4);
if b > 0
    b = sprintf('%0.2f',opp(4));
    texx = {['R = ' R],['RMSE = ' RMSE],['NSE = ' NSE],['y = ' k 'x+' b]};
else
    b = abs(b);
    b = sprintf('%0.2f',opp(4));
    texx = {['R = ' R],['RMSE = ' RMSE],['NSE = ' NSE],['y = ' k 'x-' b]};
end

text(0.5,0.2,texx,'Units','normalized','FontSize',12,'Interpreter','latex',...
    'Color',cmp,'EdgeColor','none','FontName','Arial')
xlim([0, 1800])
ylim([0, 1800])
ax = gca;

end


