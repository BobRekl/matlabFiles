%Precalc demo
clear
close all
%addpath(genpath('C:\Users\BobR\Documents\MyDocs\Matlab\FunctionLibrary'),...
%    genpath('C:\Users\BobR\Documents\MyDocs\Matlab\Statistics'));

h0 = figure;
set(h0, 'Position', [19    65   978   638])
set(h0,'DefaultAxesColorOrder',[0 0 1], ...
    'DefaultAxesLineStyleOrder','-|--|:|-.')
h_reset = uicontrol(gcf, 'Style', 'pushbutton', ...
    'Units', 'inches', 'Position', [.2 .01 .7 0.2083], 'String', 'Run', ...
    'CallBack', 'go=1;');
h_accumulate = uicontrol(gcf, 'Style', 'pushbutton', ...
    'Units', 'inches', 'Position', [.9 .01 .7 0.2083], 'String', 'Accumulate', ...
    'CallBack', 'if(accumulate) accumulate=0;bound=0; else accumulate=1;bound=1;end');

% h_bound = uicontrol(gcf, 'Style', 'pushbutton', ...
%     'Units', 'inches', 'Position', [1.6 .01 .7 0.2083], 'String', 'Bound', ...
%     'CallBack', 'if(bound) bound=0; else bound=1;end');

ntoss = 10000;

accumulate = 0;
bound = 0;
RESULT = [];
h_line = -1;
go = 1;
while(go)
    go = 0;
    
    COUNT = 1 : 1 : ntoss;
    TOSS = round(rand(1,ntoss));
    semilogx([1 ntoss], [.5 .5], 'k', 'LineWidth', 2)
    hold on
    
    if(bound == 1)
        semilogx(1:ntoss, .5+(1:ntoss).^-.5, 'r', 'LineWidth', 1)
        semilogx(1:ntoss, .5-(1:ntoss).^-.5, 'r', 'LineWidth', 1)
    end
    
    
    if(accumulate == 0)
        RESULT = cumsum(TOSS)./COUNT;
    else
        RESULT = [RESULT; cumsum(TOSS)./COUNT];
    end
    
        
    semilogx (COUNT, RESULT, 'LineWidth', 2);
    grid on
    hold off
    xlabel('Number of tosses','fontsize',18)
    ylabel('Proportion of heads','fontsize',18)
    axis([0 ntoss 0 1])    
    
    fig_exists = 1;
    while(fig_exists && go==0)
        pause(.01)
        
        figure_handles = get(0, 'Children');
        fig_exists = ~isempty(find(figure_handles == h0, 1));
    end
end
