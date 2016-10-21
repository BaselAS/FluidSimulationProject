function [ g ] = GetcTypes2D( g )
%   GETCTYPES2D Initialise Cell Type Grid
%   g: Grid

    indices = reshape(1:g.N_e^2, g.N_e, g.N_e);
    
    top = indices(1,:);
    bottom = indices(g.N_e,:);
    left = indices(2:g.N_e-1,1);
    right = indices(2:g.N_e-1,g.N_e);
    walls = ...
        [top(:);
        bottom(:);
        left(:);
        right(:)];
    
    g.cTypes = repmat('A', g.N_e, g.N_e);
    g.cTypes(walls) = 'S';
end