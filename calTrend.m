function [tr1,h1,p1] = calTrend(a)

x1 = (1:1:length(a))';

Ir_ij1 = a;
x1(isnan(Ir_ij1) | isinf(Ir_ij1)) = 0;
Ir_ij1(isnan(Ir_ij1)) = 0;
Ir_ij1(isinf(Ir_ij1)) = 0;

[h1, p1] = Mann_Kendall(Ir_ij1);

f1 = fit(x1,Ir_ij1,'poly1');
tr1 = f1.p1;



end