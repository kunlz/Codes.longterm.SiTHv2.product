
function [op] = evaluation(obs,sim)
% Evaluation function for Simulation and Observation
%-----------------
% function input:
%                obs -- Observation data
%                sim -- Simulation data
% function output:
%                1-Bias
%                2-R2
%                3-slope
%                4-intecept
%                5-RMSE
%                6-NRMSE (Normalized Root Mean Square Error)
%                7-NSE
%-----------------
% a = zeros(size(obs,1),1);
% b = a;
% for i=1:length(obs)
%     a(i,1)=(obs(i,1)-sim(i,1))^2;
%     b(i,1)=(obs(i,1)-mean(obs))^2;
% end

a = (obs-sim).^2;
b = (obs-mean(obs)).^2; 
% NSE=1-(sum(a)./sum(b));
[x,y]=prepareCurveData(obs,sim);
ft=fittype('poly1');
opts=fitoptions(ft);
[fitresult]=fit(x,y,ft,opts);
slope=fitresult.p1;
intercept=fitresult.p2;
R2=(corr(sim,obs))^2;
RMSE=sqrt(sum(a)/length(sim));
NRMSE=RMSE/mean(obs);
NSE=1-(sum(a)/sum(b));
Bias=sum(sim-obs)/length(obs);
RE = abs(Bias)/mean(obs);
RMSEpec = 100.*RMSE./mean(obs);

% Bias = (sum(sim)-sum(obs))/length(obs);
op = [Bias,sqrt(R2),slope,intercept,RMSE,NRMSE,NSE,RE,RMSEpec];
end

