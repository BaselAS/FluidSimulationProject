function [ new_particles ] = SpawnParticles3D( g, i )
%   SPAWNPARTICLES3D Spawn particles in Emitter i
%   g: Grid
%   i: Emitter index

    em = g.ems{i};
    %% Check if max number of particles reached
    if g.np_cur >= g.np_max
        new_particles = [];
        return;
    end
    
    eps = 10^-5;
    
    loc = em.loc_abs; %Centre location in absolute values
    sz = em.sz_abs; %Size in absolute values
    
    %% Emitter Bounds
    sX = loc(1)-sz(1)/2+eps;
    tX = loc(1)+sz(1)/2-eps;
    
    sY = loc(2)-sz(2)/2+eps;
    tY = loc(2)+sz(2)/2-eps;
    
    sZ = loc(3)-sz(3)/2+eps;
    tZ = loc(3)+sz(3)/2-eps;
    
    %% Distance between each particle
    step = g.dx/g.p_res;
    
    %% Spawn
    if em.randSpawn % Random Spawning
        lenX = ceil(abs(tX-sX)/step);
        lenY = ceil(abs(tY-sY)/step);
        lenZ = ceil(abs(tZ-sZ)/step);
        np = lenX*lenY*lenZ; %Number of spawned particles
        
        if sz(1) == 0 % support size = 0
            pX = repelem(loc(1), np);
        else
            pX = random('uniform', sX, tX, 1, np);
        end
        if sz(2) == 0
            pY = repelem(loc(2), np);
        else
            pY = random('uniform', sY, tY, 1, np);
        end
        if sz(3) == 0
            pZ = repelem(loc(3), np);
        else
            pZ = random('uniform', sZ, tZ, 1, np);
        end
    else % Uniform Spawning
        if sz(1) == 0 % support size = 0
            pX = loc(1);
        else
            pX = sX : step : tX;
        end
        if sz(2) == 0
            pY = loc(2);
        else
            pY = sY : step : tY;
        end
        if sz(3) == 0
            pZ = loc(3);
        else
            pZ = sZ : step : tZ;
        end
        
        [pX, pY, pZ] = meshgrid(pX,pY,pZ);
    end
    
    %% Discard particles if maximum exceeded
    np = numel(pX);
    if g.np_max - g.np_cur < numel(pX)
        np = g.np_max - g.np_cur;
    end
    
    %% Locations
    pX = pX(:);
    pY = pY(:);
    pZ = pZ(:);
    
    new_particles = [pX(1:np) pY(1:np) pZ(1:np)];
end

