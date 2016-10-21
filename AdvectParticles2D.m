function [ g ] = AdvectParticles2D(g, dt)
%   ADVECTPARTICLES2D Advect Particles using velocity field.
%   g: Grid
%   dt: Time step
    %% Get Particle Velocities
    p_src = g.particles(1:g.np_cur,:);
    p_v = zeros(g.np_cur,2);
    
    p_v(:,1) = ...
        interp2(g.grid_mesh.Z, g.grid_mesh.X, ...
        g.v_c.X, ...
        p_src(:,2), p_src(:,1), 'cubic');
    
    p_v(:,2) = ...
        interp2(g.grid_mesh.Z, g.grid_mesh.X, ...
        g.v_c.Z, ...
        p_src(:,2), p_src(:,1), 'cubic');
    
    %% Advect Particles
    p_dest = p_src + p_v*dt;
    
    %% For assigining color on plot
    g.particle_vel_abs = sqrt(sum(p_v.^2,2));
    
    %% Fix Position of escaped/in-obstacles particles
    correctedParticles = CorrectParticles2D(g, p_src, p_dest);
    g.particles(1:g.np_cur,:) = correctedParticles;
end