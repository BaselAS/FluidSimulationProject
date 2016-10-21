function [ g ] = CellsToFaces3D( g )
%   CELLSTOFACES3D Average velocities from Cell centres back to Faces
%   g: Grid

    g.v_f.X(g.interior_e(2:end,:,:)) = ... 
        1/2*(g.v_c.X(g.interior_e(1:end-1,:,:)) + ...
        g.v_c.X(g.interior_e(2:end,:,:)));
    
    g.v_f.Y(g.interior_e(:,2:end,:)) = ...
        1/2*(g.v_c.Y(g.interior_e(:,1:end-1,:)) + ...
        g.v_c.Y(g.interior_e(:,2:end,:)));
    
    g.v_f.Z(g.interior_e(:,:,2:end)) = ... 
        1/2*(g.v_c.Z(g.interior_e(:,:,1:end-1)) + ...
        g.v_c.Z(g.interior_e(:,:,2:end)));
end
