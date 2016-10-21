function [ new_particles ] = SpawnParticles2D( g, i )
%   SPAWNPARTICLES2D Spawn particles in Emitter i
%   g: Grid
%   i: Emitter index

    em = g.ems{i};
    %% Check if max number of particles reached
    if g.np_cur >= g.np_max
        new_particles = [];
        return;
    end
    
    eps = 10^-2;
    
    loc = em.loc_abs; %Centre location in absolute values
    sz = em.sz_abs; %Size in absolute values
    
    %% Emitter Bounds
    sX = loc(1)-sz(1)/2+eps;
    tX = loc(1)+sz(1)/2-eps;
    
    sZ = loc(2)-sz(2)/2+eps;
    tZ = loc(2)+sz(2)/2-eps;
    
    %% Distance between each particle
    step = g.dx/g.p_res;
    
    %% Spawn
    if em.randSpawn % Random Spawning
        lenX = ceil(abs(tX-sX)/step);
        lenZ = ceil(abs(tZ-sZ)/step);
        np = lenX*lenZ; %number of spawned particles
        
        if sz(1) == 0 % support size = 0
            pX = repelem(loc(1), np);
        else
            pX = random('uniform', sX, tX, 1, np);
        end
        if sz(2) == 0
            pZ = repelem(loc(2), np);
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
            pZ = loc(2);
        else
            pZ = sZ : step : tZ;
        end
        
        [pX, pZ] = meshgrid(pX,pZ);
    end
    
    %% Discard particles if maximum exceeded
    np = numel(pX);
    if g.np_max - g.np_cur < numel(pX)
        np = g.np_max - g.np_cur;
    end
    
    %% Locations
    pX = pX(:);
    pZ = pZ(:);
    
    new_particles = [pX(1:np) pZ(1:np)];
end

