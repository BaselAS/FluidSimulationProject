function [ divU ] = GetDiv2D( field, dx )
%   GETDIV2D Calculate Divergence of field
%   field: Field to calculate Divergence of
%   dx: distance between two values

    u_x = ForwardDifference(field.X,1,dx);
    v_z = ForwardDifference(field.Z,2,dx);
    divU =  u_x(2:end,2:end-1) + v_z(2:end-1,2:end);
end

