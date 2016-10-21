function [ divU ] = GetDiv3D( field, dx )
%   GETDIV3D Calculate Divergence of field
%   field: Field to calculate Divergence of
%   dx: distance between two values

    u_x = ForwardDifference(field.X,1,dx);
    v_y = ForwardDifference(field.Y,2,dx);
    w_z = ForwardDifference(field.Z,3,dx);
    divU =  u_x(2:end,2:end-1,2:end-1) + ...
            v_y(2:end-1,2:end,2:end-1) + ...
            w_z(2:end-1,2:end-1,2:end);
end
