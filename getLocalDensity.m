function rhos = getLocalDensity(distset, dc)
    casenum = size(distset, 1);
    %rhos = zeros(1, casenum);
    gaus = exp(-((distset / dc) .^ 2));%
    rhos = sum(gaus) - 1;
end

% function rhos = getLocalDensity(distset, dc)
%     casenum = size(distset, 1);
%     rhos = zeros(1, casenum);
%     % Gaussian kernel
%     for i = 1:casenum-1
%         for j = i+1:casenum
%             gk = exp(-(distset(i,j) / dc) * (distset(i,j) / dc));
%             %fprintf('i: %d, j: %d, gk: %f\n', i, j, gk);
%             rhos(i) = rhos(i) + gk;
%             rhos(j) = rhos(j) + gk;
%         end
%     end
% end
