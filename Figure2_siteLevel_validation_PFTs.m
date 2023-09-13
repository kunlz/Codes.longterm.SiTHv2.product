
clc
clear

load validation_ET_sitesLevel_PFTs.mat
load cmap.mat

close all
ha = tight_subplot(3, 3, [0 0], [0.1 0.1], [0.1 0.1]);
set(gcf,'unit','centimeters','position',[5,2,26,22]);

cmp = brewermap(128,'*YlGnBu');
colormap(cmp);

for i = 1 : size(dataSitesPFTs,1)

    Type = dataSitesPFTs{i,1};
    ETes = dataSitesPFTs{i,2};
    
    xi = ETes(:,1); % in-situ observations
    yi = ETes(:,2); % SiTHv2-derived ET estimates
    inx = isnan(xi) | yi == 0;
    xi(inx,:) = [];
    yi(inx,:) = [];
    
    % plot
    axes(ha(i));
    hb = dscatter(xi,yi);
    hold on

    op = evaluation(xi,yi);
    RMSE = sprintf('%0.2f',op(5));
    NSE = sprintf('%0.2f',op(7));
    
    colormap(cmp);

    R = roundn(corr(xi,yi),-2);
    [a, b] = fityy(xi,yi);
    xx = -2:0.1:10;
    yy = xx;
    y1 = a*xx + b;
    cmp1 = [203, 67, 53]./255;
    plot(xx,yy,'--','LineWidth',1.5,'Color',[0,0,0,0.8]);
    plot(xx,y1,'LineWidth',1.5,'Color',cmp1);
    

    at = num2str(roundn(a,-2));
    bt = num2str(roundn(abs(b),-2));
    if b > 0
        text(2,7.3,['y = ' at 'x + ' bt],'color','k','FontSize',12,'Interpreter','latex');
    else
        text(2,7.3,['y = ' at 'x - ' bt],'color','k','FontSize',12,'Interpreter','latex');
    end
    text(6.3,2.8,['R = ' num2str(R)],'color','k','FontSize',12,'Interpreter','latex');
%     text(1,7.5,Type,'color','k','FontSize',12,'FontWeight','bold');
    text(5.12,1.8,['RMSE = ' RMSE],'color','k','FontSize',12,'Interpreter','latex');
    text(5.63,0.8,['NSE = ' NSE],'color','k','FontSize',12,'Interpreter','latex');
    % text(3,6,['RMSEper = ' RMSEper],'color','k','FontSize',12);
    
    set(gca,'YTick',[2,4,6],'XTick',[2,4,6])

    set(hb,'FontName','Arial','FontSize',12);
    box on
%     axis square
    xlim([0, 9])
    ylim([0, 9])
    
    if ismember(i,[1,4,7])
        ylabel('Estimated ET (mm day^{–1})','FontSize',12)
    end

    if ismember(i,[7,8,9])
        xlabel('Observed ET (mm day^{–1})','FontSize',12)
    end

    if ismember(i,[2,3,5,6,8,9])
        set(gca,'YTickLabel',{'','',''})
    end


    

    ax = gca;
    p = get(ax,'Position');
    w = 0.05;
    h = 0.035;
    dim = [p(1) (p(2)+p(4)-h) w h];
    annotation(gcf,'textbox',dim,'Units','centimeters',...
        'LineStyle','-','LineWidth',0.8,...
        'String',Type,...
        'EdgeColor',[0 0 0],...
        'BackgroundColor',[0.9 0.9 0.9],...
        'FontSize',12,'FontWeight','bold');

    ax.LineWidth = 1;

end
%%
exportgraphics(gcf,'sites3.png','Resolution',600);
close all


















