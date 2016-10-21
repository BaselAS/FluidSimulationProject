function [ g ] = AdvectVelocity2D( g, dt )
%   ADVECTVELOCITY2D Advect velocity field on cells using Semi-Lagrangian
%   scheme with Second Order Runge-Kutta method
%   g: Grid
%   dt: Time step

    %% AUX FUNCTION
    function [ v_c_cen ] = GetCenteredVelocity2D( g, dt )
    %   GETCENTEREDVELOCITY2D Find Centered Velocity(Iterative Midpoint
    %   Method).
    %   g: Grid
    %   dt: Time step

        v_c_cen = g.v_c;
        for i = 1:g.v_cen_it %Number of Midpoint Method Iterations
            origins.X = g.grid_mesh.X - dt/2*v_c_cen.X;
            origins.Z = g.grid_mesh.Z - dt/2*v_c_cen.Z;

            v_c_cen.X = ...
                interp2(g.grid_mesh.Z, g.grid_mesh.X, ...
                g.v_c.X, ...
                origins.Z, origins.X,'linear');


            v_c_cen.Z = ...
                interp2(g.grid_mesh.Z, g.grid_mesh.X, ...
                g.v_c.Z, ...
                origins.Z, origins.X,'linear');

            nanX = isnan(v_c_cen.X); %Attempting to interpolate outside
            nanZ = isnan(v_c_cen.Z); %the grid results in NaNs.
            v_c_cen.X(nanX) = g.v_c.X(nanX); %Keep original values.
            v_c_cen.Z(nanZ) = g.v_c.Z(nanZ);
        end
    end

    %% Get Centered Velocity Using Iterative Midpoint Method
    v_c_cen = GetCenteredVelocity2D(g, dt);
    origins.X = g.grid_mesh.X - dt*v_c_cen.X;
    origins.Z = g.grid_mesh.Z - dt*v_c_cen.Z;
    
    %% Advect Velocity field
    v_c_new.X = ...
        interp2(g.grid_mesh.Z, g.grid_mesh.X, ...
        g.v_c.X, ...
        origins.Z, origins.X, 'linear');
    
    v_c_new.Z = ...
        interp2(g.grid_mesh.Z,g.grid_mesh.X, ...
        g.v_c.Z, ...
        origins.Z, origins.X, 'linear');
    
    %% Prevent nans
    nanX = isnan(v_c_new.X);
    nanZ = isnan(v_c_new.Z);
    v_c_new.X(nanX) = g.v_c.X(nanX);
    v_c_new.Z(nanZ) = g.v_c.Z(nanZ);
    
    %% Update
    g.v_c = v_c_new;
end

