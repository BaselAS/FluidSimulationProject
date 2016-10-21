function [ g ] = AdvectVelocity3D( g, dt )
%   TRANSPORT3D Advect velocity field on cells using Semi-Lagrangian scheme
%   with Second Order Runge-Kutta method
%   g: Grid
%   dt: Time step

    %% AUX FUNCTION
    function [ v_c_cen ] = GetCenteredVelocity3D( g, dt )
    %   GETCENTEREDVELOCITY3D Find Centered Velocity Iterative Midpoint
    %   Method.
    %   g: Grid
    %   dt: Time step

        v_c_cen = g.v_c;
        for i = 1:g.v_cen_it%Number of Midpoint Method Iterations
            origins.X = g.grid_mesh.X - dt/2*v_c_cen.X;
            origins.Y = g.grid_mesh.Y - dt/2*v_c_cen.Y;
            origins.Z = g.grid_mesh.Z - dt/2*v_c_cen.Z;

            v_c_cen.X = ...
                interp3(g.grid_mesh.Y, g.grid_mesh.X, g.grid_mesh.Z, ...
                g.v_c.X, ...
                origins.Y, origins.X, origins.Z,'linear');

            v_c_cen.Y = ...
                interp3(g.grid_mesh.Y, g.grid_mesh.X, g.grid_mesh.Z, ...
                g.v_c.Y, ...
                origins.Y, origins.X, origins.Z,'linear');

            v_c_cen.Z = ...
                interp3(g.grid_mesh.Y, g.grid_mesh.X, g.grid_mesh.Z, ...
                g.v_c.Z, ...
                origins.Y, origins.X, origins.Z,'linear');

            nanX = isnan(v_c_cen.X);%Attempting to interpolate outside
            nanZ = isnan(v_c_cen.Z);%the grid results in NaNs.
            nanY = isnan(v_c_cen.Y);
            v_c_cen.X(nanX) = g.v_c.X(nanX);%Keep original values.
            v_c_cen.Y(nanY) = g.v_c.Y(nanY);
            v_c_cen.Z(nanZ) = g.v_c.Z(nanZ);
        end
    end

    %% Get Centered Velocity Using Second Order Runge-Kutta Method
    v_c_cen = GetCenteredVelocity3D(g, dt);
    origins.X = g.grid_mesh.X - dt*v_c_cen.X;
    origins.Y = g.grid_mesh.Y - dt*v_c_cen.Y;
    origins.Z = g.grid_mesh.Z - dt*v_c_cen.Z;
    
    %% Advect Velocity field
    v_c_new.X = ...
        interp3(g.grid_mesh.Y, g.grid_mesh.X, g.grid_mesh.Z, ...
        g.v_c.X, ...
        origins.Y, origins.X, origins.Z, 'linear');
    
    v_c_new.Y = ...
        interp3(g.grid_mesh.Y, g.grid_mesh.X, g.grid_mesh.Z, ....
        g.v_c.Y, ...
        origins.Y, origins.X, origins.Z, 'linear');
    
    v_c_new.Z = ...
        interp3(g.grid_mesh.Y,g.grid_mesh.X, g.grid_mesh.Z, ...
        g.v_c.Z, ...
        origins.Y, origins.X, origins.Z, 'linear');
    
    %% Prevent nans
    nanX = isnan(v_c_new.X);
    nanY = isnan(v_c_new.Y);
    nanZ = isnan(v_c_new.Z);
    v_c_new.X(nanX) = g.v_c.X(nanX);
    v_c_new.Y(nanY) = g.v_c.Y(nanY);
    v_c_new.Z(nanZ) = g.v_c.Z(nanZ);
    
    %% Update
    g.v_c = v_c_new;
end

