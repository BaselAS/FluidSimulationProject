function [ g ] = AddForce2D( g, F, dt )
%   ADDFORCE2D Apply Force on Fluid
%   g: Grid
%   F: Force 2x1 or 1x2
%   dt: Time step

    indices = g.fluid.all_e;
    g.v_c.X(indices) = g.v_c.X(indices) + F(1)*dt;
    g.v_c.Z(indices) = g.v_c.Z(indices) + F(2)*dt;
end

