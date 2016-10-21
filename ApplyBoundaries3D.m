function [ g ] = ApplyBoundaries3D(g)
%   APPLYBOUNDARIES3D Enforces boundary conditions on walls and obstacles
%   g: Grid

    %% Walls
    g.v_f.X([1 2],:,:) = 0;%It helps to draw an illustration of the grid
    g.v_f.Y(:,[1 2],:) = 0;
    g.v_f.Z(:,:,[1 2]) = 0;
    
    %% Obstacles
    for i=1:4
        if isempty(g.obs{i})
            continue;
        end
        %walls?_e has two columns both containing indices of cell(not 
        %faces!) indices covered by the obstacle. First column is the 
        %near wall of the obstacle. The second column is the far wall 
        %of the obstacle.
        g.v_f.X(g.obs{i}.wallsX_e(:,1)) = 0;
        g.v_f.Y(g.obs{i}.wallsY_e(:,1)) = 0;
        g.v_f.Z(g.obs{i}.wallsZ_e(:,1)) = 0;
        
        g.v_f.X(g.obs{i}.wallsX_e(:,2)+1) = 0;
        g.v_f.Y(g.obs{i}.wallsY_e(:,2)+g.N_e) = 0;
        g.v_f.Z(g.obs{i}.wallsZ_e(:,2)+g.N_e^2) = 0;
    end
end

