function [slope, intercept] = fityy(x,y)

[x1,y1] = prepareCurveData(x,y);
ft = fittype('poly1');
opts = fitoptions(ft);
[fitresult] = fit(x1,y1,ft,opts);
slope = fitresult.p1;
intercept = fitresult.p2;

end