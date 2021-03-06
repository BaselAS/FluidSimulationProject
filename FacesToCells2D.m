function [ g ] = FacesToCells2D( g )
%   FACESTOCELLS2D Average velocities from Faces back to Cells
%   g: Grid

    %% Average
    g.v_c.X = 1/2*(g.v_f.X(g.interior_e) + g.v_f.X(3:end,2:end-1));
    g.v_c.Z = 1/2*(g.v_f.Z(g.interior_e) + g.v_f.Z(2:end-1,3:end));
    
    %% Pad
    g.v_c.X = padarray(g.v_c.X, [1 1], 0, 'both');
    g.v_c.Z = padarray(g.v_c.Z, [1 1], 0, 'both');
end

