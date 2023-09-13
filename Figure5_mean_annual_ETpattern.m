








clc
clear

load meanAnnualETdata_SiTHv2_ETPs.mat
load landmask01deg.mat

close all
krange = [0,1800];
cbTick = [0:300:1800];
IDs = 'Mean annual ET';
Yticks2 = [0:500:1500];
label2 = '(mm year^{-1})';
ETyS = ETySP;
plotglobalETraster3(ETym,landprop,krange,cbTick,IDs,Yticks2,label2,ETyS);

%% export figure
exportgraphics(gcf,'GlobalETpatternv1.png','Resolution',600);
close all

