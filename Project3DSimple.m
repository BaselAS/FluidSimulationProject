function [ g, L ] = Project3DSimple( g, dt, L)
%   PROJECT3DSIMPLE Makes Velocity field on Faces div free. Solves pressure
%   in every non-solid cell.
%   g: Grid
%   dt: Time step
%   L: System of equations to solve pressure, initially [] is passed. The
%   purpose is to prevent unnecessary building of the same system at every
%   frame.

    %% Build System if not already
    if isempty(L)
        disp '- Building System'
        L = dt/g.dx^2*SystemMatrixSimple3D(g);
    end
    
    %% Get Divergence
    disp '- Get Div'
    divU = -reshape(GetDiv3D(g.v_f,g.dx), g.N^3, 1);
    divU = divU(g.nonSolids);
    
    %% Solve Pressure
    disp '- Solve'
    p = zeros(g.shape-2);
    p(g.nonSolids) = L\divU;
    
    %% Particle Diffusion
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

