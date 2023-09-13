


function [Ratio] = calRatio(basinE52, result_ET0)


for i = 1 : 52

    a = basinE52(1:11,i); % 2003 -- 2016
    b = result_ET0(:,i); % 1982 -- 2020 --> 2003 (22) -- 2016 (35)
    b(a==99999) = [];
    a(a==99999) = [];

    if length(a) < 3

        Ratio(1,i) = 999;

    else

        op1 = evaluation(a,b);
        Ratio(1,i) = mean(b)/mean(a);
        RE(1,i) = op1(1)/mean(a);

    end
    
end
Ratio(:,[16,19,50]) = [];

end