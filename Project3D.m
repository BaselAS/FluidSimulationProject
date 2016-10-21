function [ g ] = Project3D(g, dt)
%   PROJECT3D Makes Velocity field on Faces div free. Solves Pressure in
%   fluid cells only.
%   g: Grid
%   dt: Time step
    
    %% Build system of equations
    L = dt/g.dx^2 * SystemMatrix3D(g);
    
    %% Get Divergence
    disp '- Get Div'
    divU = -reshape(GetDiv3D(g.v_f,g.dx), g.N^3, 1);
    divU = divU(g.fluid.all);
    
    %% Solve system
    disp '- Solve'
    p = zeros(g.shape-2);
    p(g.fluid.all) = L\divU;
    
    %% Apply Particle Diffusion
    disp '- Particle Diffusion'
    p(g.fluid.all) = p(g.fluid.all) + g.particle_diffusion*g.fluid.density;
    
    %% Get Pressure Derivative
    disp '- Pressure Derivative'
    p_x = padarray(ForwardDifference(p,1,g.dx), [1 0 0], 0, 'pre');
    p_y = padarray(ForwardDifference(p,2,g.dx), [0 1 0], 0, 'pre');
    p_z = padarray(ForwardDifference(p,3,g.dx), [0 0 1], 0, 'pre');
    
    %% Apply boundary conditions
    disp '- Fix Pressure Derivative'
    [p_x, p_y, p_z] = FixPressureDerivative3D(g, p_x, p_y, p_z);
    
    %% Fix Velocity field
    disp '- Fix Velocity Field'
    g.v_f.X(g.interior_e) = g.v_f.X(g.interior_e)-dt*p_x;
    g.v_f.Y(g.interior_e) = g.v_f.Y(g.interior_e)-dt*p_y;
    g.v_f.Z(g.interior_e) = g.v_f.Z(g.interior_e)-dt*p_z;
end

