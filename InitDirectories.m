function [pathData, pathSC] = InitDirectories()
    recycle('on');
    t = datetime('now','Format','HH:mm:ss');
    [h,m,s] = hms(t);
    s = round(s);
    if not(exist('simOut', 'dir'))
        mkdir('simOut');
        cd 'simOut'
        
        mkdir('Data');
        cd 'Data'
        mkdir(['SimData' num2str(h) '-' num2str(m) '-' num2str(s)]);
        pathData = [pwd '/' 'SimData' num2str(h) '-' num2str(m) '-' num2str(s)];
        cd ..
        
        mkdir('Screenshots');
        cd 'Screenshots'
        mkdir(['SimSC' num2str(h) '-' num2str(m) '-' num2str(s)]);
        pathSC = [pwd '/' 'SimSC' num2str(h) '-' num2str(m) '-' num2str(s)];
        cd ..
        cd ..
    else
        cd 'simOut'
        
        if not(exist('Data', 'dir'))
            mkdir('Data');
        end
        cd 'Data'
        mkdir(['SimData' num2str(h) '-' num2str(m) '-' num2str(s)]);
        pathData = [pwd '/' 'SimData' num2str(h) '-' num2str(m) '-' num2str(s)];
        cd ..

        if not(exist('Screenshots', 'dir'))
            mkdir('Screenshots');
        end
        cd 'Screenshots'
        mkdir(['SimSC' num2str(h) '-' num2str(m) '-' num2str(s)]);
        pathSC = [pwd '/' 'SimSC' num2str(h) '-' num2str(m) '-' num2str(s)];
        cd ..
        cd ..
    end
end