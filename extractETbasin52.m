
function [result_ET1] = extractETbasin52(ETy,mask)

result_ET1 = zeros(size(ETy,3),52);

for i = 1 : 52

    disp(i)
    maski = mask;
    maski(maski~=i) = NaN;

    % use the real area for weighted mean
    k = 0.25;
    [~,~,landweight] = callandarea_weight(k,maski);

    for j = 1 : size(ETy,3)

        ET1 = ETy(:,:,j);

        % yearly
        ET1(isnan(maski)) = NaN;


        % sum2region
        %         result_ET1(j, i) = mean(ET1(:),'omitnan');
        result_ET1(j, i) = sum(ET1.*landweight,"all","omitnan");

    end
end

end