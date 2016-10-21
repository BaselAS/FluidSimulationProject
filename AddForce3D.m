function [ g ] = AddForce3D( g, F, dt )
%   ADDFORCE3D Apply Force on Fluid
%   g: Grid
%   F: Force 3x1 or 1x3
%   dt: Time step

    indices = g.fluid.all_e;
    g.v_c.X(indices) = g.v_c.X(indices) + F(1)*dt;
    g.v_c.Y(indices) = g.v_c.Y(indices) + F(2)*dt;
    g.v_c.Z(indices) = g.v_c.Z(indices) + F(3)*dt;
end

