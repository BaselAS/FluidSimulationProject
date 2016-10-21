function [ g ] = InitEmitter3D(loc, sz, vel, randSpawn, spawnRate, g, idx)
%   INITEMITTER3D Create and add Emitter to Grid
%   loc: location in Fluid Domain(Normalised values)
%   sz: size in Fluid Domain(Normalised values)
%   vel: velocity of emitted particles
%   randSpawn: random location spawning of particles in emitter
%   spawnRate: spawn particles every $spawnRate$ frames
%   g: Grid

    if g.em_cur > 4
        disp 'Maximum 4 Emitters allowed!'
        return;
    end

    em.loc_norm = loc;
    em.sz_norm = sz;
    
    % Location and size(Absolute values)
    em.loc_abs = ([1 1 1]-loc)*g.xmin + loc*g.xmax;
    em.sz_abs = sz*(g.xmax - g.xmin);
    
    em.vel = vel;
    em.randSpawn = randSpawn;
    em.spawnRate = spawnRate;
    g.ems{idx} = em;
    g.em_cur = g.em_cur + 1;
    g.em_cir = g.em_cur + 1;
end

