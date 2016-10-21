function [ g ] = AdvectParticles3D(g, dt)
%   ADVECTPARTICLES3D Advect Particles using velocity field.
%   g: Grid
%   dt: Time step
    %% Get Particle Velocities
    p_src = g.particles(1:g.np_cur,:);
    p_v = zeros(g.np_cur,3);
    p_v(:,1) = ...
        interp3(g.grid_mesh.Y, g.grid_mesh.X, g.grid_mesh.Z, ...
        g.v_c.X, ...
        p_src(:,2), p_src(:,1), p_src(:,3), 'cubic');
    
    p_v(:,2) = ...
        interp3(g.grid_mesh.Y, g.grid_mesh.X, g.grid_mesh.Z, ...
        g.v_c.Y, ...
        p_src(:,2), p_src(:,1), p_src(:,3), 'cubic');
    
    p_v(:,3) = ...
        interp3(g.grid_mesh.Y, g.grid_mesh.X, g.grid_mesh.Z, ...
        g.v_c.Z, ...
        p_src(:,2), p_src(:,1), p_src(:,3), 'cubic');
    
    %% Advect Particles
    p_dest = p_src + p_v*dt;
    
    %% For assigining color on plot
    g.particle_vel_abs = sqrt(sum(p_v.^2,2));
    
    %% Fix Position of escaped/in-obstacles particles
    correctedParticles = CorrectParticles3D(g, p_src, p_dest);
    g.particles(1:g.np_cur,:) = correctedParticles;
end