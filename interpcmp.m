

function [cmp3] = interpcmp(cmp2,N)
for i = 1 : 3

    a = cmp2(:,i);

    x = 1:1:length(a);

    
    xq = 1:1/(N/length(a)):length(a);
    vq = interp1(x,a,xq,'pchip');

    cmp3(:,i) = vq;
end

end