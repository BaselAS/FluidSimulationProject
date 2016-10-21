function [ g ] = GetcTypes3D( g )
%   GETCTYPES3D Initialise Cell Type Grid
%   g: Grid

    indices = reshape(1:g.N_e^3, g.N_e, g.N_e, g.N_e);
    
    top = indices(1,:,:);
    bottom = indices(g.N_e,:,:);
    left = indices(2:g.N_e-1,1,:);
    right = indices(2:g.N_e-1,g.N_e,:);
    near = indices(2:g.N_e-1,2:g.N_e-1,1);
    far  = indices(2:g.N_e-1,2:g.N_e-1,g.N_e);
    walls = ...
        [top(:);
        bottom(:);
        left(:);
        right(:);
        near(:);
        far(:)];
    
    g.cTypes = repmat('A', g.N_e, g.N_e, g.N_e);
    g.cTypes(walls) = 'S';
end

