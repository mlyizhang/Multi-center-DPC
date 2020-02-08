function showShapeSet(shapeset)%
    scrsz = get(0,'ScreenSize');%  
    %ScreenSize is 四维向量: [left, bottom, width, height]。
%     figure('Position', [6 72 scrsz(3)/2. scrsz(4)/1.3]);% 
%     subplot(2,2,1); % 
 set(gca,'looseInset',[0 0 0 0]);
    tt = plot(shapeset(:, 1), shapeset(:, 2), 'o', 'MarkerSize', 2, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');%返回点句柄
%     text = 'LoadShape';
%     title (text, 'FontSize', 15.0);
%     xlabel ('x');
%     ylabel ('y');
end