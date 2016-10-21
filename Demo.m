function Demo
    fig = figure('units','normalized','outerposition',[0 0.05 1 0.95]);
    %% Groups
    simSettingsGroup = uipanel('Parent', fig, 'Units', 'normal', ...
        'Position', [0 6/7 0.25 1/7]);
    gridGroup = uipanel('Parent', fig, 'Units', 'normal', ...
        'Position', [0 5/7 0.25 1/7]);
    forceGroup = uipanel('Parent', fig, 'Units', 'normal', ...
        'Position', [0 4/7 0.25 1/7]);
    particlesGroup = uipanel('Parent', fig, 'Units', 'normal', ...
        'Position', [0 3/7 0.25 1/7]);
    emittersGroup = uipanel('Parent', fig, 'Units', 'normal', ...
        'Position', [0 2/7 0.25 1/7]);
    obstaclesGroup = uipanel('Parent', fig, 'Units', 'normal', ...
        'Position', [0 1/7 0.25 1/7]);
    plotSettingsGroup = uipanel('Parent', fig, 'Units', 'normal', ...
        'Position', [0 0 0.25 1/7]);

    %% Group Titles
    uicontrol('Style','text', 'Parent', simSettingsGroup, ...
        'String','Simulation Settings', 'Units', 'normal', ...
        'Position',[0 0.8 1 0.2], 'FontWeight', 'bold');
    uicontrol('Style','text', 'Parent', gridGroup, ...
        'String','Grid Dimensions and Size', 'Units', 'normal', ...
        'Position',[0 0.8 1 0.2], 'FontWeight', 'bold');
    uicontrol('Style','text', 'Parent', forceGroup, ...
        'String','Force', 'Units', 'normal', ...
        'Position',[0 0.8 1 0.2], 'FontWeight', 'bold');
    uicontrol('Style','text', 'Parent', particlesGroup, ...
        'String','Particles', 'Units', 'normal', ...
        'Position',[0 0.8 1 0.2], 'FontWeight', 'bold');
    uicontrol('Style','text', 'Parent', emittersGroup, ...
        'String','Emitters', 'Units', 'normal', ...
        'Position',[0 0.8 1 0.2], 'FontWeight', 'bold');
    uicontrol('Style','text', 'Parent', obstaclesGroup, ...
        'String','Obstacles', 'Units', 'normal', ...
        'Position',[0 0.8 1 0.2], 'FontWeight', 'bold');
    uicontrol('Style','text', 'Parent', plotSettingsGroup, ...
        'String','Plot and Export Options', 'Units', 'normal', ...
        'Position',[0 0.8 1 0.2], 'FontWeight', 'bold');

    %% Group Details
    % Simulation Settings
    simSettings1Group = uipanel('Parent', simSettingsGroup, ...
        'Units', 'normal', ...
        'Position', [0 0 0.5 0.88]);
    dimB = uicontrol('Style','pushbutton', ...
        'Parent', simSettings1Group, ...
        'String','Dimensions: 2D', 'Units', 'normal', ...
        'Position',[0 0.75 1 0.25], 'Callback', @Toggle2D3D);
    ntB = uicontrol('Style','pushbutton', ...
        'Parent', simSettings1Group, ...
        'String','Number of frames: 300', 'Units', 'normal', ...
        'Position',[0 0.5 1 0.25], 'Callback', @Setnt);
    isSimpleB = uicontrol('Style','pushbutton', ...
        'Parent', simSettings1Group, ...
        'String','Pressure Solving: In Volume', 'Units', 'normal', ...
        'Position',[0 0.25 1 0.25], 'Callback', @ToggleisSimple);
%     isVelCheatB = uicontrol('Style','pushbutton', ...
%         'Parent', simSettings1Group, ...
%         'String','Velocity Cheat: No', 'Units', 'normal', ...
%         'Position',[0 0 1 0.25], 'Callback', @ToggleisVelCheat);

    simSettings2Group = uipanel('Parent', simSettingsGroup, ...
        'Units', 'normal', ...
        'Position', [0.5 0 0.5 0.88]);
    dtB = uicontrol('Style','pushbutton', ...
        'Parent', simSettings2Group, ...
        'String','Time Step: 0.5', 'Units', 'normal', ...
        'Position',[0 0.75 1 0.25], 'Callback', @Setdt);
    v_cen_itB = uicontrol('Style','pushbutton', ...
        'Parent', simSettings2Group, ...
        'String','Midpoint Iterations Number: 5', 'Units', 'normal', ...
        'Position',[0 0.5 1 0.25], 'Callback' ,@Setv_cen_it);
    bounceNumB = uicontrol('Style','pushbutton', ...
        'Parent', simSettings2Group, ...
        'String','Collision Bounce Number: 3', 'Units', 'normal', ...
        'Position',[0 0.25 1 0.25], 'Callback', @SetbounceNum);
    ext_layersB = uicontrol('Style','pushbutton', ...
        'Parent', simSettings2Group, ...
        'String','Extrapolation Layers Number: 2', 'Units', 'normal', ...
        'Position',[0 0 1 0.25], 'Callback', @Setext_layers);

    % Grid Dimensions and Size
    grid1Group = uipanel('Parent', gridGroup, ...
        'Units', 'normal', ...
        'Position', [0 0 1 0.88]);
    NB = uicontrol('Style','pushbutton', 'Parent', grid1Group, ...
        'String','N: 64', 'Units', 'normal', ...
        'Position',[0 2/3 1 1/3], 'Callback', @SetN);
    xminxmaxB = uicontrol('Style','pushbutton', 'Parent', grid1Group, ...
        'String','xmin: 0, xmax: 100', 'Units', 'normal', ...
        'Position',[0 1/3 1 1/3], 'Callback', @Setxminxmax);

    % Force
    force1Group = uipanel('Parent', forceGroup, ...
        'Units', 'normal', ...
        'Position', [0 0 1 0.88]);
    forceB = uicontrol('Style','pushbutton', 'Parent', force1Group, ...
        'String','Force: [0 -1]', 'Units', 'normal', ...
        'Position',[0 0.5 1 0.5], 'Callback', @Setforce);

    % Particles
    particles1Group = uipanel('Parent', particlesGroup, ...
        'Units', 'normal', ...
        'Position', [0 0 1 0.88]);
    p_resB = uicontrol('Style','pushbutton', ...
        'Parent', particles1Group, ...
        'String','Particle Resolution: 4', 'Units', 'normal', ...
        'Position',[0 2/3 1 1/3], 'Callback', @Setp_res);
    np_maxB = uicontrol('Style','pushbutton', ...
        'Parent', particles1Group, ...
        'String','Max Particles: 1000000', 'Units', 'normal', ...
        'Position',[0 1/3 1 1/3], 'Callback', @Setnp_max);
    particle_diffusionB = uicontrol('Style','pushbutton', ...
        'Parent', particles1Group, ...
        'String','Particle Diffusion: 0.05', 'Units', 'normal', ...
        'Position',[0 0 1 1/3], 'Callback', @Setparticle_diffusion);

    % Emitters
    emitters1Group = uipanel('Parent', emittersGroup, ...
        'Units', 'normal', ...
        'Position', [0 0 0.2 0.88]);
    uicontrol('Style','pushbutton', ...
        'Parent', emitters1Group, ...
        'String','Add', 'Units', 'normal', ...
        'Position',[0 0.75 0.5 0.25], ...
        'Callback', @(s,c) AddEmitter(s,c,1));
    uicontrol('Style','pushbutton', ...
        'Parent', emitters1Group, ...
        'String','Del', 'Units', 'normal', ...
        'Position',[0.5 0.75 0.5 0.25], ...
        'Callback', @(s,c) DelEmitter(s,c,1));
    uicontrol('Style','pushbutton', ...
        'Parent', emitters1Group, ...
        'String','Add', 'Units', 'normal', ...
        'Position',[0 0.5 0.5 0.25], ...
        'Callback', @(s,c) AddEmitter(s,c,2));
    uicontrol('Style','pushbutton', ...
        'Parent', emitters1Group, ...
        'String','Del', 'Units', 'normal', ...
        'Position',[0.5 0.5 0.5 0.25], ...
        'Callback', @(s,c) DelEmitter(s,c,2));
    uicontrol('Style','pushbutton', ...
        'Parent', emitters1Group, ...
        'String','Add', 'Units', 'normal', ...
        'Position',[0 0.25 0.5 0.25], ...
        'Callback', @(s,c) AddEmitter(s,c,3));
    uicontrol('Style','pushbutton', ...
        'Parent', emitters1Group, ...
        'String','Del', 'Units', 'normal', ...
        'Position',[0.5 0.25 0.5 0.25], ...
        'Callback', @(s,c) DelEmitter(s,c,3));
    uicontrol('Style','pushbutton', ...
        'Parent', emitters1Group, ...
        'String','Add', 'Units', 'normal', ...
        'Position',[0 0 0.5 0.25], ...
        'Callback', @(s,c) AddEmitter(s,c,4));
    uicontrol('Style','pushbutton', ...
        'Parent', emitters1Group, ...
        'String','Del', 'Units', 'normal', ...
        'Position',[0.5 0 0.5 0.25], ...
        'Callback', @(s,c) DelEmitter(s,c,4));
    emitters2Group = uipanel('Parent', emittersGroup, ...
        'Units', 'normal', ...
        'Position', [0.2 0 0.8 0.88]);
    emsT = { uicontrol('Style','text', 'Parent', emitters2Group, ...
        'String','[0.1 0.4], [0.2 0.8], [0 0], true, 0', ...
        'Units', 'normal', ...
        'Position',[0 0.75 1 0.25]); ...
        uicontrol('Style','text', 'Parent', emitters2Group, ...
        'String','', 'Units', 'normal', ...
        'Position',[0 0.5 1 0.25]); ...
        uicontrol('Style','text', 'Parent', emitters2Group, ...
        'String','', 'Units', 'normal', ...
        'Position',[0 0.25 1 0.25]); ...
        uicontrol('Style','text', 'Parent', emitters2Group, ...
        'String','', 'Units', 'normal', ...
        'Position',[0 0 1 0.25]) };

    % Obstacles
    obstacles1Group = uipanel('Parent', obstaclesGroup, ...
        'Units', 'normal', ...
        'Position', [0 0 0.2 0.88]);
    uicontrol('Style','pushbutton', ...
        'Parent', obstacles1Group, ...
        'String','Add', 'Units', 'normal', ...
        'Position',[0 0.75 0.5 0.25], ...
        'Callback', @(s,c) AddObstacle(s,c,1));
    uicontrol('Style','pushbutton', ...
        'Parent', obstacles1Group, ...
        'String','Del', 'Units', 'normal', ...
        'Position',[0.5 0.75 0.5 0.25], ...
        'Callback', @(s,c) DelObstacle(s,c,1));
    uicontrol('Style','pushbutton', ...
        'Parent', obstacles1Group, ...
        'String','Add', 'Units', 'normal', ...
        'Position',[0 0.5 0.5 0.25], ...
        'Callback', @(s,c) AddObstacle(s,c,2));
    uicontrol('Style','pushbutton', ...
        'Parent', obstacles1Group, ...
        'String','Del', 'Units', 'normal', ...
        'Position',[0.5 0.5 0.5 0.25], ...
        'Callback', @(s,c) DelObstacle(s,c,2));
    uicontrol('Style','pushbutton', ...
        'Parent', obstacles1Group, ...
        'String','Add', 'Units', 'normal', ...
        'Position',[0 0.25 0.5 0.25], ...
        'Callback', @(s,c) AddObstacle(s,c,3));
    uicontrol('Style','pushbutton', ...
        'Parent', obstacles1Group, ...
        'String','Del', 'Units', 'normal', ...
        'Position',[0.5 0.25 0.5 0.25], ...
        'Callback', @(s,c) DelObstacle(s,c,3));
    uicontrol('Style','pushbutton', ...
        'Parent', obstacles1Group, ...
        'String','Add', 'Units', 'normal', ...
        'Position',[0 0 0.5 0.25], ...
        'Callback', @(s,c) AddObstacle(s,c,4));
    uicontrol('Style','pushbutton', ...
        'Parent', obstacles1Group, ...
        'String','Del', 'Units', 'normal', ...
        'Position',[0.5 0 0.5 0.25], ...
        'Callback', @(s,c) DelObstacle(s,c,4));
    obstacles2Group = uipanel('Parent', obstaclesGroup, ...
        'Units', 'normal', ...
        'Position', [0.2 0 0.8 0.88]);
    obsT = {uicontrol('Style','text', 'Parent', obstacles2Group, ...
        'String','22:42, 1:20', 'Units', 'normal', ...
        'Position',[0 0.75 1 0.25]); ...
        uicontrol('Style','text', 'Parent', obstacles2Group, ...
        'String','', 'Units', 'normal', ...
        'Position',[0 0.5 1 0.25]); ...
        uicontrol('Style','text', 'Parent', obstacles2Group, ...
        'String','', 'Units', 'normal', ...
        'Position',[0 0.25 1 0.25]); ...
        uicontrol('Style','text', 'Parent', obstacles2Group, ...
        'String','', 'Units', 'normal', ...
        'Position',[0 0 1 0.25])};

    % Plot and Export Options
    plot1Group = uipanel('Parent', plotSettingsGroup, ...
        'Units', 'normal', ...
        'Position', [0 0 1 0.88]);
    isQuiverB = uicontrol('Style','pushbutton', ...
        'Parent', plot1Group, ...
        'String','Plot Velocity: No', 'Units', 'normal', ...
        'Position',[0 2/3 1 1/3], 'Callback', @ToggleQuiver);
    isScreenshotB = uicontrol('Style','pushbutton', ...
        'Parent', plot1Group, ...
        'String','Take Screenshot: No', 'Units', 'normal', ...
        'Position',[0 1/3 1 1/3], 'Callback', @ToggleScreenshot);
    isExportFrameB = uicontrol('Style','pushbutton', 'Parent', ... 
        plot1Group, ...
        'String','Export Frames: No', 'Units', 'normal', ...
        'Position',[0 0 1 1/3]', 'Callback', @ToggleExport);

    %% Plot Group
    SimStopResetGroup = uipanel('Parent', fig, 'Units', 'normal', ...
        'Position', [0.25 0 0.75 1/7]);
    simB = uicontrol('Style','pushbutton', 'Parent', SimStopResetGroup, ...
        'String','Simulate', 'Units', 'normal', ...
        'Position',[0 0 1/3 1], 'FontWeight', 'bold', ...
        'Callback', @Simulate);
    uicontrol('Style','pushbutton', 'Parent', SimStopResetGroup,...
        'String','Stop', 'Units', 'normal', ...
        'Position',[1/3 0 1/3 1], 'FontWeight', 'bold', ... 
        'Callback', @Stop);
    resetB=uicontrol('Style','pushbutton', 'Parent', SimStopResetGroup, ...
        'String','Reset', 'Units', 'normal', ...
        'Position',[2/3 0 1/3 1], 'FontWeight', 'bold', ... 
        'Callback', @Reset);
    set(resetB, 'Enable', 'off');
    plotGroup = uipanel('Parent', fig, 'Units', 'normal', ...
        'Position', [0.25 1/7 0.75 6/7]);
    plotAxes = axes('Parent', plotGroup, 'Units', 'normal', ...
            'Position', [0 0 1 1]);
    axes(plotAxes);
    np_curA = annotation(plotGroup, 'textbox',[0 1 0 0],'String', ...
        '#Particles: 0', 'FitBoxToText','on');
    
    %% Default values
    is3D = false;
    N = 64;                        
    xmin = 0;   xmax = 100;
    dt = 0.5;
    nt = 300;
    force = [0 -1];
    particle_diffusion = 0.05;
    np_max = 10^6;
    p_res = 4;
    bounceNum = 3;
    v_cen_it = 5;
    ext_layers = 2;
    isSimple = false;
    isVelCheat = false;
    isQuiver = false;
    isScreenshot = false;
    isExportFrame = false;
    L = [];
    pathData = [];
    pathSC = [];
    
    %% Globals And Functions
    isStopRequest = false;
    g = [];
    colors = [];
    ems = cell(4,1);
    obs = cell(4,1);
    particle_plot = [];
    quiver_plot = [];
    
    function InitGrid()
        if is3D
            g = InitGrid3D(N,xmin,xmax,np_max,p_res,isSimple,isVelCheat,...
            v_cen_it,bounceNum,ext_layers,particle_diffusion);
        else
            g = InitGrid2D(N,xmin,xmax,np_max,p_res,isSimple,isVelCheat,...
            v_cen_it,bounceNum,ext_layers,particle_diffusion);
        end
        colors = ['r', 'g', 'b', 'y'];
    end
    function InitPlot()
        if is3D
            [particle_plot, quiver_plot] = InitPlot3D(g, colors);
        else
            
            [particle_plot, quiver_plot] = InitPlot2D(g, colors);
        end
        set(np_curA, 'String', '#Particles: 0');
    end
    function AddEmitters()
        for i = 1:4
            if isempty(ems{i})
                continue;
            end
            if is3D
                g = InitEmitter3D(ems{i}{1}, ems{i}{2}, ems{i}{3}, ...
                    ems{i}{4}, ems{i}{5}, g, i);
            else
                g = InitEmitter2D(ems{i}{1}, ems{i}{2}, ems{i}{3}, ...
                    ems{i}{4}, ems{i}{5}, g, i);
            end
        end
    end
    function AddObstacles()
        for i = 1:4
            if isempty(obs{i})
                continue;
            end
            if is3D
                g = CreateObstacle3D(obs{i}{1}(1):obs{i}{1}(end), ...
                    obs{i}{2}(1):obs{i}{2}(end),...
                    obs{i}{3}(1):obs{i}{3}(end), ...
                    g, i);
            else
                g = CreateObstacle2D(obs{i}{1}(1):obs{i}{1}(end), ...
                    obs{i}{2}(1):obs{i}{2}(end), g, i);
            end
        end
    end
    function SetEmsObsText()
        for i = 1:4
            if not(isempty(ems{i}))
                if ems{i}{4}
                    b = 'true';
                else
                    b = 'false';
                end
                set(emsT{i}, 'String', ...
                [ '[' num2str(ems{i}{1}, '%1.2f ') '], ' ...
                '[' num2str(ems{i}{2}, '%1.2f ') '], '...
                '[' num2str(ems{i}{3}, '%1.2f ') '], ' ...
                b ', ' num2str(ems{i}{5}) ]);
            end
            if not(isempty(obs{i}))
                str = [ ...
                    num2str(obs{i}{1}(1)) ':' num2str(obs{i}{1}(end)) ', ' ...
                    num2str(obs{i}{2}(1)) ':' num2str(obs{i}{2}(end)) ];
                if is3D
                    str = [ str ', ' ...
                    num2str(obs{i}{3}(1)) ':' num2str(obs{i}{3}(end)) ];
                end
                set(obsT{i}, 'String', str);
            end
        end
    end
    function EnableButtons(en)
        set(dimB, 'Enable', en);
        set(ntB, 'Enable', en);
        set(isSimpleB, 'Enable', en);
        set(dtB, 'Enable', en);
        set(v_cen_itB, 'Enable', en);
        set(bounceNumB, 'Enable', en);
        if not(isSimple)
            set(ext_layersB, 'Enable', en);
        end
        set(NB, 'Enable', en);
        set(xminxmaxB, 'Enable', en);
        set(forceB, 'Enable', en);
        set(p_resB, 'Enable', en);
        set(np_maxB, 'Enable', en);
        set(particle_diffusionB, 'Enable', en);
        set(findall(emitters1Group, '-property', 'enable'), ...
            'enable', en);
        set(findall(obstacles1Group, '-property', 'enable'), ...
            'enable', en);
        set(isScreenshotB, 'Enable', en);
        set(isExportFrameB, 'Enable', en);
        set(simB, 'Enable', en);
    end
    function clearPlot()
        delete(particle_plot);
        delete(quiver_plot);
        cla;
    end
    function Init()
        L = [];
        InitGrid();
        AddEmitters();
        AddObstacles();
        InitPlot();
    end

    %% Button Callbacks
    function Stop(source, callbackdata)
        isStopRequest = true;
        set(resetB, 'Enable', 'on');
    end
    function Reset(source, callbackdata)
        if isStopRequest
            isStopRequest = false;
            clearPlot();
            Init();
            EnableButtons('on');
            set(resetB, 'Enable', 'off');
        end
    end
    function ToggleQuiver(source, callbackdata)
        if isQuiver
            t = 'Plot Velocity: No';
        else
            t = 'Plot Velocity: Yes';
        end
        isQuiver = not(isQuiver);
        set(isQuiverB, 'String', t);
    end
    function ToggleScreenshot(source, callbackdata)
        if isScreenshot
            t = 'Take Screenshot: No';
        else
            t = 'Take Screenshot: Yes';
        end
        isScreenshot = not(isScreenshot);
        set(isScreenshotB, 'String', t);
    end
    function ToggleExport(source, callbackdata)
        if isExportFrame
            t = 'Export Frames: No';
        else
            t = 'Export Frames: Yes';
        end
        isExportFrame = not(isExportFrame);
        set(isExportFrameB, 'String', t);
    end
    function Setp_res(source, callbackdata)
        prompt = {'Enter Particle Resolution:'};
        dlg_title = 'Particle Resolution';
        num_lines = 1;
        defaultans = {num2str(p_res)};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            return;
        end
        p_res = str2double(answer{1});
        set(p_resB, 'String', ['Particle Resolution: ' answer{1}]);
        clearPlot();
        Init();
    end
    function Setnp_max(source, callbackdata)
        prompt = {'Enter Maximum Number of Particles:'};
        dlg_title = 'Maximum Number of Particles';
        num_lines = 1;
        defaultans = {num2str(np_max)};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            return;
        end
        np_max = str2double(answer{1});
        set(np_maxB, 'String', ['Max Particles: ' answer{1}]);
        clearPlot();
        Init();
    end
    function Setparticle_diffusion(source, callbackdata)
        prompt = {'Enter Particle Diffusion Coefficient:'};
        dlg_title = 'Particle Diffusion';
        num_lines = 1;
        defaultans = {num2str(particle_diffusion)};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            return;
        end
        particle_diffusion = str2double(answer{1});
        set(particle_diffusionB, 'String', ['Particle Diffusion: ' ...
            answer{1}]);
        clearPlot();
        Init();
    end
    function AddEmitter(source, callbackdata, i)
        wasEmpty = false;
        if isempty(ems{i})
            wasEmpty = true;
            ems{i} = cell(5,1);
        end
        prompt = {'Enter Location(Normalised):', ...
            'Enter Size(Normalised):', 'Enter Velocity', ...
            'Random Spawn?(true/false):', 'Enter Spawn Rate:'};
        dlg_title = 'Add Emitter';
        num_lines = 1;
        if not(wasEmpty)
            loc = num2str(ems{i}{1});
            sz = num2str(ems{i}{2});
            vel = num2str(ems{i}{3});
            if ems{i}{4}
                randSpawn = 'true';
            else
                randSpawn = 'false';
            end
            spawnRate = num2str(ems{i}{5});
        else
            if is3D
                loc = num2str([0.5 0.5 0.5]);
                sz = num2str([0.5 0.5 0.5]);
                vel = num2str([0 0 0]);
            else
                loc = num2str([0.5 0.5]);
                sz = num2str([0.5 0.5]);
                vel = num2str([0 0]);
            end
            randSpawn = 'true';
            spawnRate = '1';
        end
        defaultans = {loc, sz, vel, randSpawn, spawnRate};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            if wasEmpty
                ems{i} = [];
            end
            return;
        end
        ems{i}{1} = str2double(strsplit(answer{1}));
        ems{i}{2} = str2double(strsplit(answer{2}));
        ems{i}{3} = str2double(strsplit(answer{3}));
        ems{i}{4} = str2num(lower(answer{4}));
        ems{i}{5} = str2num(answer{5});
        SetEmsObsText();
        clearPlot();
        Init();
    end
    function DelEmitter(source, callbackdata, i)
        ems{i} = [];
        set(emsT{i}, 'String', '');
        clearPlot();
        Init();
    end
    function AddObstacle(source, callbackdata, i)
        wasEmpty = false;
        if isempty(obs{i})
            wasEmpty = true;
            obs{i} = cell(3,1);
        end
        if is3D
            prompt = {'Enter X range(indices range):', ...
            'Enter Y range(indices range):',  ...
            'Enter Z range(indices range):'};
        else
            prompt = {'Enter X range(indices range):', ...
            'Enter Z range(indices range):'};
        end
        dlg_title = 'Add Obstacle';
        num_lines = 1;
        if is3D
            if wasEmpty
                defaultans = {'1:2', '1:2', '1:2'};
            else
                defaultans = { ...
                [num2str(obs{i}{1}(1)) ':' num2str(obs{i}{1}(end))], ...
                [num2str(obs{i}{2}(1)) ':' num2str(obs{i}{2}(end))], ...
                [num2str(obs{i}{3}(1)) ':' num2str(obs{i}{3}(end))]};
            end
        else
            if wasEmpty
                defaultans = {'1:2', '1:2'};
            else
                defaultans = {...
                [num2str(obs{i}{1}(1)) ':' num2str(obs{i}{1}(end))], ...
                [num2str(obs{i}{2}(1)) ':' num2str(obs{i}{2}(end))]};
            end
        end
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            if wasEmpty
                obs{i} = [];
            end
            return;
        end
        obs{i}{1} = str2double(strsplit(answer{1},':'));
        obs{i}{2} = str2double(strsplit(answer{2},':'));
        if is3D
            obs{i}{3} = str2double(strsplit(answer{3},':'));
        end
        SetEmsObsText();
        clearPlot();
        Init();
    end
    function DelObstacle(source, callbackdata, i)
        obs{i} = [];
        set(obsT{i}, 'String', '');
        clearPlot();
        Init();
    end
    function Setforce(source, callbackdata)
        prompt = {'Enter Force:'};
        dlg_title = 'Force';
        num_lines = 1;
        defaultans = {num2str(force)};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            return;
        end
        force = str2double(strsplit(answer{1}));
        set(forceB, 'String', ['[' num2str(force, '%1.2f ') ']' ]);
        Init();
    end
    function SetN(source, callbackdata)
        prompt = {'Enter Dimension:'};
        dlg_title = 'Grid Dimension';
        num_lines = 1;
        defaultans = {num2str(N)};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            return;
        end
        N_old = N;
        N = str2double(answer{1});
        for i = 1:4
            if isempty(obs{i})
                continue;
            end
            if length(obs{i}{1}) == 1
                obs{i}{1} = ceil(obs{i}{1}(1)/N_old*N);
            else
                obs{i}{1} = ceil(obs{i}{1}(1)/N_old*N): ...
                    floor(obs{i}{1}(end)/N_old*N);
            end
            if length(obs{i}{2}) == 1
                obs{i}{2} = ceil(obs{i}{2}(1)/N_old*N);
            else
                obs{i}{2} = ceil(obs{i}{2}(1)/N_old*N): ...
                    floor(obs{i}{2}(end)/N_old*N);
            end
            if is3D
                if length(obs{i}{3}) == 1
                    obs{i}{3} = ceil(obs{i}{3}(1)/N_old*N);
                else
                    obs{i}{3} = ceil(obs{i}{3}(1)/N_old*N): ...
                        floor(obs{i}{3}(end)/N_old*N);
                end
            end
        end
        SetEmsObsText();
        set(NB, 'String', ['N: ' answer{1}]);
        clearPlot();
        Init();
    end
    function Setxminxmax(source, callbackdata)
        prompt = {'Enter Range(xmin xmax):'};
        dlg_title = 'Grid Size';
        num_lines = 1;
        defaultans = {[num2str(xmin) ' ' num2str(xmax)]};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            return;
        end
        range = strsplit(answer{1});
        xmin = str2double(range{1});
        xmax = str2double(range{2});
        set(xminxmaxB, 'String',['xmin: ' range{1} ', xmax: ' range{2}]);
        clearPlot();
        Init();
    end
    function Setext_layers(source, callbackdata)
        prompt = {'Enter Number of Extrapolation Layers:'};
        dlg_title = 'Velocity Extrapolation';
        num_lines = 1;
        defaultans = {num2str(ext_layers)};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            return;
        end
        if strcmp(answer{1}, 'inf')
            ext_layers = inf;
        else
            ext_layers = str2double(answer{1});
        end
        set(ext_layersB, 'String', ...
            ['Extrapolation Layers Number: ' answer{1}]);
        clearPlot();
        Init();
    end
    function SetbounceNum(source, callbackdata)
        prompt = {'Enter Number of Bounces Before Respawn:'};
        dlg_title = 'Collisions';
        num_lines = 1;
        defaultans = {num2str(bounceNum)};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            return;
        end
        bounceNum = str2double(answer{1});
        set(bounceNumB, 'String', ...
            ['Collision Bounce Number: ' answer{1}]);
        clearPlot();
        Init();
    end
    function Setv_cen_it(source, callbackdata)
        prompt = {'Enter Number of Midpoint Iterations:'};
        dlg_title = 'Midpoint Method';
        num_lines = 1;
        defaultans = {num2str(v_cen_it)};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            return;
        end
        v_cen_it = str2double(answer{1});
        set(v_cen_itB, 'String', ...
            ['Midpoint Iterations Number: ' answer{1}]);
        clearPlot();
        Init();
    end
    function Setdt(source, callbackdata)
        prompt = {'Enter Time Step:'};
        dlg_title = 'Time Step';
        num_lines = 1;
        defaultans = {num2str(dt)};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            return;
        end
        dt = str2double(answer{1});
        set(dtB, 'String', ...
            ['Time Step: ' answer{1}]);
        clearPlot();
        Init();
    end
    function ToggleisSimple(source, callbackdata)
        if isSimple
            t = 'Pressure Solving: In Volume';
        else
            t = 'Pressure Solving: Simple';
        end
        if isSimple
            set(ext_layersB, 'Enable', 'on');
        else
            ext_layers = 0;
            set(ext_layersB, 'String', 'Extrapolation Layers Number: 0');
            set(ext_layersB, 'Enable', 'off');
        end
        isSimple = not(isSimple);
        set(isSimpleB, 'String', t);
        
        clearPlot();
        Init();
    end
    function Setnt(source, callback)
        prompt = {'Enter Number of Frames:'};
        dlg_title = 'Simulation Length';
        num_lines = 1;
        defaultans = {num2str(nt)};
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
        if isempty(answer)
            return;
        end
        nt = str2double(answer{1});
        set(ntB, 'String', ...
            ['Number of Frames: ' answer{1}]);
        clearPlot();
        Init();
    end
    function Toggle2D3D(source, callback)
        if is3D
            is3D = false;
            force = force([1,3]);
            for i = 1:4
                if not(isempty(ems{i}))
                    ems{i}{1} = ems{i}{1}([1,3]);
                    ems{i}{2} = ems{i}{2}([1,3]);
                    ems{i}{3} = ems{i}{3}([1,3]);
                end
                if not(isempty(obs{i}))
                    obs{i}{2} = obs{i}{3};
                    obs{i}{3} = [];
                end
            end
            set(dimB, 'String', '2D');
        else
            is3D = true;
            force = [force(1) 0 force(2)];
            for i = 1:4
                if not(isempty(ems{i}))
                    ems{i}{1} = [ems{i}{1}(1) 0.5 ems{i}{1}(2)];
                    ems{i}{2} = [ems{i}{2}(1) 0 ems{i}{2}(2)];
                    ems{i}{3} = [ems{i}{3}(1) 0 ems{i}{3}(2)];
                end
                if not(isempty(obs{i}))
                    obs{i}{3} = obs{i}{2};
                    obs{i}{2} = N/2+1;
                end
            end
            set(dimB, 'String', '3D');
        end
        set(forceB, 'String', ['[' num2str(force, '%1.2f ') ']' ]);
        SetEmsObsText();
        clearPlot();
        Init();
    end
    %% Init and Plot
    ems{1} = cell(5,1);
    ems{1}{1} = [0.1 0.4];
    ems{1}{2} = [0.2 0.8];
    ems{1}{3} = [0 0];
    ems{1}{4} = true;
    ems{1}{5} = 0;
    obs{1}{1} = [22 42];
    obs{1}{2} = [1 20];
    Init();
    
    %% Simulate
    function Simulate(source, callbackdata)
        EnableButtons('off');
        if isExportFrame || isScreenshot
            [pathData, pathSC] = InitDirectories();
        end
        if is3D
            Simulate3D();
        else
            Simulate2D();
        end
    end
    
    %% Simulate 2D
    function Simulate2D
        clc;
        if isExportFrame
            ExportObs2D(g, pathData);
        end
        for frameNo = 0:nt-1
            if isStopRequest
                break;
            end
            disp '--------------------------------'
            disp(['Frame: ' num2str(frameNo)])

            disp '+ Advect Velocity'
%             tic
            g = AdvectVelocity2D(g, dt);
%             toc
            
            disp '+ Spawn Particles'
%             tic
            for i=1:4
                if isEmitterEmpty(g, i)
                    continue;
                end
                if mod(frameNo,GetSpawnRate(g,i)) ~= 0
                    continue;
                end
                new_particles = SpawnParticles2D(g, i);
                if isempty(new_particles)
                    break;
                end

                g = AddParticles(new_particles, g);
                
                g = TraceFluid2D(g, new_particles, i);

                g = ApplyEmitterVelocity2D(g, i);
            end
%             toc
            disp '+ Exporting Data'
            if isExportFrame
                ExportFrame2D(g, frameNo, pathData);
            end

            disp '+ Trace Fluid'
%             tic
            g = TraceAndClassifyFluid2D(g);
%             toc

            disp '+ Add Force'
%             tic
            g = AddForce2D(g, force, dt);
%             toc
            
            disp '+ Cells to Faces'
%             tic
            g = CellsToFaces2D(g);
%             toc
            
            disp '+ Enforce Boundaries'
%             tic
            g = ApplyBoundaries2D(g);
%             toc
            
            disp '+ Projection'
%             tic
            if isSimpleCase(g)
                [g, L] = Project2DSimple(g, dt, L);
            else
                g = Project2D(g, dt);
            end
%             toc
            
            disp '+ Faces to Cells'
%             tic
            g = FacesToCells2D(g);
%             toc
            
            disp '+ Extrapolate Velocity'
%                 tic
            g = ExtrapolateVelocity2D(g);
%                 toc

            disp '+ Advect Particles'
%             tic
            g = AdvectParticles2D(g, dt);
%             toc
            
            [particle_plot, quiver_plot] = UpdatePlot2D(g,...
                particle_plot, isQuiver, quiver_plot, isScreenshot, ...
                frameNo, pathSC);
            set(np_curA,'String',['#Particles: ' ...
                num2str(GetParticleCount(g))]);
        end
        Stop([],[]);
    end

    %% Simulate 3D
    function Simulate3D
        clc;
        if isExportFrame
            ExportObs3D(g, pathData);
        end
        for frameNo = 0:nt-1
            if isStopRequest
                break;
            end
            disp '--------------------------------'
            disp(['Frame: ' num2str(frameNo)])

            disp '+ Advect Velocity'
%             tic
            g = AdvectVelocity3D(g, dt);
%             toc
            
            disp '+ Spawn Particles'
%             tic
            for i=1:4
                if isEmitterEmpty(g, i)
                    continue;
                end
                if mod(frameNo,GetSpawnRate(g,i)) ~= 0
                    continue;
                end
                new_particles = SpawnParticles3D(g, i);
                if isempty(new_particles)
                    break;
                end

                g = AddParticles(new_particles, g);
                
                g = TraceFluid3D(g, new_particles, i);

                g = ApplyEmitterVelocity3D(g, i);
            end
%             toc

            disp '+ Exporting Data'
            if isExportFrame
                ExportFrame3D(g, frameNo, pathData);
            end

            disp '+ Trace Fluid'
%             tic
            g = TraceAndClassifyFluid3D(g);
%             toc

            disp '+ Add Force'
%             tic
            g = AddForce3D(g, force, dt);
%             toc
            
            disp '+ Cells to Faces'
%             tic
            g = CellsToFaces3D(g);
%             toc
            
            disp '+ Enforce Boundaries'
%             tic
            g = ApplyBoundaries3D(g);
%             toc
            
            disp '+ Projection'
%             tic
            if isSimpleCase(g)
                [g, L] = Project3DSimple(g, dt, L);
            else
                g = Project3D(g, dt);
            end
%             toc
            
            disp '+ Faces to Cells'
%             tic
            g = FacesToCells3D(g);
%             toc

            disp '+ Extrapolate Velocity'
%                 tic
            g = ExtrapolateVelocity3D(g);
%                 toc

            disp '+ Advect Particles'
%             tic
            g = AdvectParticles3D(g, dt);
%             toc
            
            [particle_plot, quiver_plot] = UpdatePlot3D(g,...
                particle_plot, isQuiver, quiver_plot, isScreenshot, ...
                frameNo, pathSC);
            set(np_curA,'String',['#Particles: ' ...
                num2str(GetParticleCount(g))]);
        end
        Stop([],[]);
    end
end
