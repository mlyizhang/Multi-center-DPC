%% 计算dc的函数，按照手动输入的比例取值
function dc = computeDc(distset, percent)
    casenum = size(distset, 1);
    filter = logical(triu(ones(casenum, casenum),1)); 
    crossnum = sum(sum(filter));% 
    pos = round(crossnum * percent / 100);%
    sda = sort(distset(filter)); % 
    dc = sda(pos);% 
end
