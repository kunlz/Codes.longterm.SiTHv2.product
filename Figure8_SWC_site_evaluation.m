clc
clear

load Selected_sites_for_SWC_evaluation.mat


close all
figure
set(gcf,'Position',[0 100 1800 850])
ha = tight_subplot(4, 3, [0.05 0.03], [0.05 0.05], [0.1 0.05]);
n = 1;
for i = 1 : size(dataC,1)
    
  
    tt = dataC{i,5};
    obs = dataC{i,3};
    sim = dataC{i,4};
    ID = dataC{i,1};
    PFT = dataC{i,2};

    yy = ymd(tt);
    yyu = unique(yy);
    yyutick = datetime(num2str(yyu),'InputFormat','yyyy');

    axes(ha(i))

    % plot scatter for observation and simulation
    scatter(tt,obs,12,'k','MarkerFaceAlpha',0.3,...
        'MarkerEdgeColor','none','MarkerFaceColor','k'); 
    hold on
    plot(tt,sim,'-','Color',[[21, 101, 192]./255,0.8],'LineWidth',1);
    
    % set the ylims for each axis (site)
    if i == 11 
        ylim([0,0.82])
    elseif i == 6
        ylim([0,0.78])
    elseif i == 7
        ylim([0,0.75])
    elseif i == 8
        ylim([0,0.65])
    elseif i == 10
        ylim([0,0.65])
    else
        ylim([0,0.55])
    end
    box off
    set(gca,'LineWidth',1,'Color','w','TickDir','out','FontSize',14)
    
    % remove NaN-values
    inx = isnan(obs) | isnan(sim);
    obs1 = obs;
    obs1(inx,:) = [];
    sim1 = sim;
    sim1(inx,:) = [];
    % statistics
    opp = evaluation(obs1,sim1);

    % statistics
    R = sprintf('%0.2f',opp(2));
    texx1 = {['R = ' R]};
    RMSE = sprintf('%0.2f',opp(5));
    texx2 = {['RMSE = ' RMSE ]};
    NSE = sprintf('%0.2f',opp(7));
    texx3 = {['NSE = ' NSE]};
    text(0.27,0.82,texx1,'Units','normalized','FontSize',13,'Interpreter','latex',...
    'Color','k','EdgeColor','none','FontName','Arial') 
    text(0.44,0.835,'|','Units','normalized','FontSize',13,'Interpreter','tex',...
    'Color','k','EdgeColor','none','FontName','Arial') 
    text(0.47,0.82,texx2,'Units','normalized','FontSize',13,'Interpreter','latex',...
    'Color','k','EdgeColor','none','FontName','Arial')  
    
    % set the x-axis labels
    if ismember(i,4)
        ax = gca;
        ax.XTick = yyutick;
    else
        datetick('x','yyyy','keeplimits')
    end
    
    % write the site ID for each axis
    ax = gca;
    p = get(ax,'Position');
    w = 0.045;
    h = 0.035;
    dim = [p(1) (p(2)+p(4)-h) w h];
    annotation(gcf,'textbox',dim,'Units','centimeters',...
        'LineStyle','-','LineWidth',0.8,...
        'String',ID,...
        'EdgeColor',[0 0 0],...
        'BackgroundColor',[0.9 0.9 0.9],...
        'FontSize',12,'FontWeight','bold');

    % set the y-axis label for the left panel
    if ismember(i,[1,4,7,10])
        ylabel('SWC (m^3 m^{-3})')
    else
        ylabel(' ')
    end

    % set the figure legend
    if i == 1
        legend({'In-situ','SiTHv2'},"Box","off",'FontSize',14,...
            'Color',[0.8,0.8,0.8])
    end

    dsm(n:n+length(obs)-1,1) = obs;
    dsm(n:n+length(obs)-1,2) = sim;
    n = n+length(obs);
end
%% export figure
exportgraphics(gcf,'siteSMeva34.png','Resolution',600);
close all