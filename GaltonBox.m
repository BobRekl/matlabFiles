%A simulated Galton box 
clear
close all
%addpath(genpath('C:\Users\BobR\Documents\MyDocs\Matlab\FunctionLibrary'),...
%   genpath('C:\Users\BobR\Documents\MyDocs\Matlab\Statistics'));

ballr = .25;
CRCX = ballr*cos(0:pi/16:2*pi);
CRCY = ballr*sin(0:pi/16:2*pi);
SS1 = sin(-7*pi:pi/8:7*pi);
SS2 = sin(-20*pi:pi/6:20*pi);

ntoss = 10;

%[XX YY] = meshgrid([-ntoss : 1 : ntoss],[-ntoss : 1 : 0]-.5);
XX = [0, -1, 1, -2, 0, 2, -3, -1, 1, 3, -4, -2, 0, 2, 4, -5, -3, -1, 1, 3, 5,...
    -6 -4 -2 0 2 4 6 -7 -5 -3 -1 1 3 5 7, -8 -6 -4 -2 0 2 4 6 8, ...
    -9 -7 -5 -3 -1 1 3 5 7 9];
YY = [0, -1, -1, -2, -2, -2, -3, -3, -3, -3, -4, -4, -4, -4, -4, -5, -5, -5, -5, -5, -5,...
    -6 -6 -6 -6 -6 -6 -6 -7 -7 -7 -7 -7 -7 -7 -7, -8 -8 -8 -8 -8 -8 -8 -8 -8, ...
    -9 -9 -9 -9 -9 -9 -9 -9 -9 -9];
YY = YY - .5;


COUNT = 1 : 1 : ntoss;
COUNT =[0, COUNT];
go = 1;
while (go)
    go = 0;
    speed = .3;
    
    NUMBERS = [];
    NUMBERS2 = [];
    PILE = zeros(1, 2*ntoss + 1);
    h0 = figure;
    %set(h0, 'Position', [403 46 560 620])
    set(h0, 'Position', [238    68   560   620])
    plot (XX,YY,'dk','MarkerFaceColor', 'k') %Draw grid of diamonds
    axis([-ntoss ntoss -3*ntoss-ballr 0])
    set(gca,'Visible','off')
    axis equal
    hold on
    
    for n = -11:2:11 %draw bins at bottom of rack
        plot([n n],[-3*ntoss-ballr -1.2*ntoss],'b')
        if(n>-11)
        text(n-1.1,-3*ntoss-.6-ballr,num2str((n+9)/2)) %write numbers on axis
        %text(n-1.1,-3*ntoss-.6,num2str((n-1)/2)) %write numbers -5 to 5
        end
    end
    plot([-11 11],[-3*ntoss-ballr -3*ntoss-ballr],'b')
    plot([-11 11],[-3*ntoss+9*ballr -3*ntoss+9*ballr],'b--')
    plot([-11 11],[-3*ntoss+19*ballr -3*ntoss+19*ballr],'b--')
    plot([-11 11],[-3*ntoss+29*ballr -3*ntoss+29*ballr],'b--')
    plot([-11 11],[-3*ntoss+39*ballr -3*ntoss+39*ballr],'b--')
    plot([-11 11],[-3*ntoss+49*ballr -3*ntoss+49*ballr],'b--')
    plot([-11 11],[-3*ntoss+59*ballr -3*ntoss+59*ballr],'b--')
    plot([-11 11],[-3*ntoss+69*ballr -3*ntoss+69*ballr],'b--')
    BNOM = 0:10;
    for n = 0:10
        BNOM(n+1) = nchoosek(10,n);
    end
    MODEL = ((1.8/3)*BNOM/nchoosek(10,5) - 1)*3*ntoss;
    %plot(-10:2:10, MODEL)
    
    h_drop_button = uicontrol(gcf, 'Style', 'pushbutton', ...
        'Units', 'inches', 'Position', [.2 .1 .7 0.2083], 'String', 'Drop', 'CallBack', 'hold_drop=1;speed=.3;');
    
    h_drop20_button = uicontrol(gcf, 'Style', 'pushbutton', ...
        'Units', 'inches', 'Position', [.9 .1 .7 0.2083], 'String', 'Drop20', 'CallBack', 'hold_drop=20;speed=.02;');
    
    h_drop100_button = uicontrol(gcf, 'Style', 'pushbutton', ...
        'Units', 'inches', 'Position', [1.6 .1 .7 0.2083], 'String', 'Drop100', 'CallBack', 'hold_drop=100;speed=.002;');
    
    h_model_button = uicontrol(gcf, 'Style', 'pushbutton', ...
        'Units', 'inches', 'Position', [2.3 .1 .7 0.2083], 'String', 'Pattern', 'CallBack', 'plot(-10:2:10,MODEL,''r'')');
    
    h_reset_button = uicontrol(gcf, 'Style', 'pushbutton', ...
        'Units', 'inches', 'Position', [3.0 .1 .7 0.2083], 'String', 'Reset', 'CallBack', 'go=1;close gcf;');
    
    h_mean = uicontrol(gcf, 'Style', 'text', ...
        'Units', 'inches', 'Position', [4 .1 .7 0.2083], 'String', '');
    
    first = 1;
    hold_drop = 0;
    fig_exists = 1;
    while(fig_exists)
        set(h_mean, 'String', '');
        if(~first)
            RND = rand(1,ntoss);
            TOSS = 2*round(RND) - 1; %set random path
            %TOSS = 2*round(ones(1,ntoss)) - 1; %test path
            TOSS2 = round(RND);
            
            RESULT = cumsum(TOSS); %result is the cumulative sum of ntoss tosses
            RESULT =[0, RESULT]; %set first result to 0
            NUMBERS = [NUMBERS, RESULT(ntoss+1)*.5]; %list of where balls drop
            NUMBERS2 = [NUMBERS2, sum(TOSS2)];
            
            %plot(RESULT, -COUNT, 'or')
            for n = 0:ntoss %animation for ball drop
                h_path = plot(RESULT(1:n+1), -(0:n),'k'); %draw path
                h_ball = patch(CRCX + RESULT(n+1), CRCY - n, 'r'); %draw ball
                set(h_ball, 'FaceColor','r','EdgeColor','r')
                drawnow
                if(speed>=.1)
                    sound(SS2)
                end
                %sound(SS1);
                %if(RESULT(n+1)<0)
                %    sound(SS1);
                %else
                %    sound(SS2)
                %end
                
                
                pause(speed)
                delete(h_ball)
                delete(h_path)
            end
            %RESULT(ntoss+1)
            PILE(RESULT(ntoss+1)+ntoss+1) = PILE(RESULT(ntoss+1)+ntoss+1) + 1; %add one to the pile
            plot(-ntoss:1:ntoss, 2*ballr*PILE-3.05*ntoss,'or','MarkerFaceColor', 'r') %draw the top of the pile
            if(speed>=.01)
                sound(SS1);
            end
            
            if(hold_drop==1)
                set(h_mean, 'String', ['Mean = ', num2str(round(mean(NUMBERS2),3))]);
                %meanDrop = mean(NUMBERS2)
            end
        end %~first
        pos = get(h0, 'Position');
        first = 0;
        hold_drop = hold_drop - 1;
        while(hold_drop<1 && fig_exists)
            pause(.01)
            
            figure_handles = get(0, 'Children');
            fig_exists = ~isempty(find(figure_handles == h0, 1));
            
        end %hold_drop
        
    end %fig_exists
    
end %go




