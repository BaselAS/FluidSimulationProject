function [ g ] = AddParticles( new_particles, g )
%   ADDPARTICLES adds spawned particles to container
%   new_particles: newly spawned particles
%   g: Grid

    np = size(new_particles,1);
    g.particles(g.np_cur+1:g.np_cur+np, :) = new_particles;
    g.np_cur = g.np_cur + np;
end

