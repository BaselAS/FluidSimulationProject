function [ g ] = CreateObstacle2D( xrng, zrng, g, idx )
%   CREATEOBSTACLE2D Create and Add obstacle to Grid
%   xrng, zrng: cell indices range on X,Z dimensions respectively
%   g: Grid
    
    if g.ob_cur > 4
        disp 'Maximum 4 Obstacles allowed!'
        return;
    end
    %% Indices
    xrng = xrng + 1;
    zrng = zrng + 1;
    [Z,X] = meshgrid(zrng, xrng);
    
    % Indices of cells covered by ob in Entire Grid
    ob.sub_e = [X(:) Z(:)];
    ob.ind_e = reshape(sub2ind(g.shape, ...
        ob.sub_e(:,1),ob.sub_e(:,2)), ...
        numel(xrng), numel(zrng));
    
    ob.sub = ob.sub_e-1;
    ob.ind = reshape(sub2ind(g.shape-2, ...
        ob.sub(:,1), ob.sub(:,2)), ...
        numel(xrng), numel(zrng));
    
    % Indices of ob's walls on X,Y,Z dimensions
    ob.wallsX_e = [col(ob.ind_e(1,:)) col(ob.ind_e(end,:))];
    ob.wallsZ_e = [col(ob.ind_e(:,1)) col(ob.ind_e(:,end))];
    
    ob.wallsX = [col(ob.ind(1,:)) col(ob.ind(end,:))];
    ob.wallsZ = [col(ob.ind(:,1)) col(ob.ind(:,end))];
    
    %% Is ob touching the farest wall on X,Y,Z dimensions
    ob.boundOnX = max(ob.sub(:,1)) == g.N;
    ob.boundOnZ = max(ob.sub(:,2)) == g.N;
    
    %% Location and Size
    % ob center and size(Absolute values)
    ob.loc_abs = 1/2*(g.grid_rng([xrng(1) zrng(1)]) + ...
        g.grid_rng([xrng(end) zrng(end)]));
    ob.sz_abs = (g.grid_rng([xrng(end) zrng(end)]) - ...
        g.grid_rng([xrng(1) zrng(1)]) + g.dx);
    
    % ob center and size(Normalised values)
    ob.loc_norm = ob.loc_abs/(g.xmax - g.xmin);
    ob.sz_norm = ob.sz_abs/(g.xmax - g.xmin);
    
    %% Bounds
    ob.xmin = g.grid_rng(xrng(1))-1/2*g.dx;
    ob.xmax = g.grid_rng(xrng(end))+1/2*g.dx;
    ob.zmin = g.grid_rng(zrng(1))-1/2*g.dx;
    ob.zmax = g.grid_rng(zrng(end))+1/2*g.dx;
    
    %% Vertices and Faces
    ob.v = ...
        [ob.xmin ob.zmin; %Bottom left
        ob.xmax ob.zmin; %Bottom right
        ob.xmin ob.zmax; %Top left
        ob.xmax ob.zmax]; % Top right
    ob.f = ...
        [3 4; %Top
        1 2; %Bottom
        1 3; %Left
        2 4]; %Right
    ob.normals = ...
        [0 1;
        0 -1;
        -1 0;
        1 0];
    
    %% Add Obstacle to Grid
    g.cTypes(ob.ind_e) = 'S';
    g.nonSolids_e = find(g.cTypes ~= 'S');
    [i,j] = ind2sub(g.shape, g.nonSolids_e);
    g.nonSolids = sub2ind(g.shape-2, i-1, j-1);
    g.obs{idx} = ob;
    g.ob_cur = g.ob_cur + 1;
end

