function [ p_dest ] = CorrectParticles3D( g, p_src, p_dest )
%   CORRECTPARTICLES3D Fixes positions of particles who either escaped the
%   Fluid Domain or ended up inside obstacles
%   g: Grid
%   p_src: Particle position source
%   p_dest: Particle position destination(After Advection)
%   p_v: Particle Velocities

    %% Aux Functions
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    function [ escaped ] = DetectEscapedParticles()
        % Detect out of bounds particles
        % 1-Top; 2-Bottom; 3-Left; 4-Right; 5-Near; 6-Far
        escaped = cell(6,1);
        escaped{3} = find(p_dest(:,1) < g.xmin);
        if isempty(escaped{3})
            escaped{3} = [];
        end
        escaped{4} = find(p_dest(:,1) > g.xmax);
        if isempty(escaped{4})
            escaped{4} = [];
        end
        escaped{5} = find(p_dest(:,2) < g.xmin);
        if isempty(escaped{5})
            escaped{5} = [];
        end
        escaped{6} = find(p_dest(:,2) > g.xmax);
        if isempty(escaped{6})
            escaped{6} = [];
        end
        escaped{2} = find(p_dest(:,3) < g.xmin);
        if isempty(escaped{2})
            escaped{2} = [];
        end
        escaped{1} = find(p_dest(:,3) > g.xmax);
        if isempty(escaped{1})
            escaped{1} = [];
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%
    function [ inObs ] = DetectInObstaclesParticles()
        % Aux Functions
        function idx = checkParticle(idx, ob)
            if isempty(ob)
                idx = [];
                return;
            end
            if ( p_dest(idx,1) < ob.xmin || ...
            p_dest(idx,1) > ob.xmax || ...
            p_dest(idx,2) < ob.ymin || ...
            p_dest(idx,2) > ob.ymax || ...
            p_dest(idx,3) < ob.zmin || ...
            p_dest(idx,3) > ob.zmax )
                idx = [];
            end
        end
        
        function inObs = checkObstacle(ob)
            inObs = arrayfun(@(idx) checkParticle(idx, ob), ...
                (1:size(p_dest,1))', 'UniformOutput', false);
            inObs = cell2mat(inObs);
        end
        
        % Check Obstacles
        inObs = arrayfun( @(i) checkObstacle(g.obs{i}), (1:4)', ...
            'UniformOutput', false);
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%
    function [ normals, p_Is ] = ObstacleCollisionPoints(ob, inObs)
        [normals, p_Is] = arrayfun( ...
                    @(idx) ...
                    FindIntersectedFace3D(p_src(idx,:), p_dest(idx,:),...
                    ob), inObs, 'UniformOutput', false);
        normals = cell2mat(normals);
        p_Is = cell2mat(p_Is);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Correct Particles
    disp '- WALLS - Detect Escaped Particles'
    es = DetectEscapedParticles();
    all_escaped = cell2mat(es);
    isEscaped = not(isempty(all_escaped));
    if not(isempty(g.obs{1}) && isempty(g.obs{2}) && ...
        isempty(g.obs{3}) && isempty(g.obs{4}))
        %%%%    Detect In-Obstacles Particles  %%%%
        disp '- OBSTACLES - detect In-Obstacles Particles'
        inObs = DetectInObstaclesParticles();
        all_inObs = cell2mat(inObs);
        isInObs = not(isempty(all_inObs));
        %%%%    --------------------------  %%%%
    else
        all_inObs = [];
        isInObs = false;
    end
    it = 0;
    while ( isEscaped || isInObs )
        it = it + 1;
        %%%%    WALLS   %%%%
        if it >= g.bounceNum
            %%%%    Prevent infinite loop   %%%%
            disp '- bounceNum reached, respawning escaped particles'
            validRespawns = datasample(g.fluid.all_e, ...
                numel(all_escaped));
            p_dest(all_escaped, :)=[...
                col(g.grid_mesh.X(validRespawns)), ...
                col(g.grid_mesh.Y(validRespawns)), ...
                col(g.grid_mesh.Z(validRespawns)) ];
            isEscaped = false;
            %%%%    ---------------------   %%%%
        elseif isEscaped
            sides = {'Top', 'Bottom', 'Left', 'Right', 'Near', 'Far'};
            for side = 1:6
                if isempty(es{side})
                    continue;
                end
                %%%%    Find Collision points   %%%%
                disp (['- WALL ' sides{side} ' - Find collision point'])
                [normals, p_Is] = arrayfun( ...
                @(idx) FindIntersectedFace3D(p_src(idx,:), p_dest(idx,:),...
                    g, sides{side}), es{side}, ...
                    'UniformOutput', false);
                normals = cell2mat(normals);
                p_Is = cell2mat(p_Is);
                %%%%    ---------------------   %%%%
                
                %%%%    Bounce  %%%%
                disp (['- WALL ' sides{side} ' - Bounce'])
                
                dir = p_Is - p_dest(es{side},:);
                bounce = 2*normals.*repmat(dot(dir,normals,2),1,3)-dir;
                p_dest(es{side},:) = p_Is + bounce;
                %%%%    ------  %%%%
            end
            
            %%%%    Rescan  %%%%
            disp '- WALLS - Rescan'
            es = DetectEscapedParticles();
            all_escaped = cell2mat(es);
            isEscaped = not(isempty(all_escaped));
            %%%%    -----   %%%%
        end
        %%%%    -----   %%%%
        
        %%%%    OBSTACLES   %%%%
        if it >= g.bounceNum
            %%%%    Prevent infinite loop   %%%%
            disp '- bounceNum reached, respawning in-obstacles particles'
            validRespawns = datasample(g.fluid.all_e, ...
                numel(all_inObs));
            p_dest(all_inObs, :)=[...
                col(g.grid_mesh.X(validRespawns)), ...
                col(g.grid_mesh.Y(validRespawns)), ...
                col(g.grid_mesh.Z(validRespawns)) ];
            isInObs = false;
            %%%%    ---------------------   %%%%
        elseif isInObs
            %%%%    Find collisions points  %%%%
            disp '- OBSTACLES - Find collision point'
            [normals, p_Is] = arrayfun( ...
                @(i) ObstacleCollisionPoints(g.obs{i}, inObs{i}), ...
                (1:4)', 'UniformOutput', false);
            %%%%    ----------------------  %%%%
            %%%%    Bounce  %%%%
            disp '- OBSTACLES - Bounce'
            for i = 1:4
                if isempty(inObs{i})
                    continue;
                end
                dir = p_Is{i} - p_dest(inObs{i},:);
                bounce = ...
                    2*normals{i}.*repmat(dot(dir,normals{i},2),1,3)-dir;
                p_dest(inObs{i},:) = p_Is{i} + bounce;
            end
            %%%%    ------  %%%%
            
            %%%%    Rescan  %%%%
            disp '- OBSTACLES - Rescan'
            inObs = DetectInObstaclesParticles();
            all_inObs = cell2mat(inObs);
            isInObs = not(isempty(all_inObs));
            %%%%    --------------------------  %%%%
        end
        %%%%    ---------   %%%%
    end
end

