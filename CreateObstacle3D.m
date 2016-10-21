function [ g ] = CreateObstacle3D( xrng, yrng, zrng, g, idx )
%   CREATEOBSTACLE3D Create and Add obstacle to Grid
%   xrng, yrng, zrng: cell indices range on X,Y,Z dimensions respectively
%   g: Grid
    
    if g.ob_cur > 4
        disp 'Maximum 4 Obstacles allowed!'
        return;
    end
    %% Indices
    xrng = xrng + 1;
    yrng = yrng + 1;
    zrng = zrng + 1;
    [Y,X,Z] = meshgrid(yrng, xrng, zrng);
    
    % Indices of cells covered by ob in Entire Grid
    ob.sub_e = [X(:) Y(:) Z(:)];
    ob.ind_e = reshape(sub2ind(g.shape, ...
        ob.sub_e(:,1),ob.sub_e(:,2),ob.sub_e(:,3)), ...
        numel(xrng), numel(yrng), numel(zrng));
    
    ob.sub = ob.sub_e-1;
    ob.ind = reshape(sub2ind(g.shape-2, ...
        ob.sub(:,1), ob.sub(:,2), ob.sub(:,3)), ...
        numel(xrng), numel(yrng), numel(zrng));
    
    % Indices of ob's walls on X,Y,Z dimensions
    ob.wallsX_e = [col(ob.ind_e(1,:,:)) col(ob.ind_e(end,:,:))];
    ob.wallsY_e = [col(ob.ind_e(:,1,:)) col(ob.ind_e(:,end,:))];
    ob.wallsZ_e = [col(ob.ind_e(:,:,1)) col(ob.ind_e(:,:,end))];
    
    ob.wallsX = [col(ob.ind(1,:,:)) col(ob.ind(end,:,:))];
    ob.wallsY = [col(ob.ind(:,1,:)) col(ob.ind(:,end,:))];
    ob.wallsZ = [col(ob.ind(:,:,1)) col(ob.ind(:,:,end))];
    
    %% Is ob touching the farest wall on X,Y,Z dimensions
    ob.boundOnX = max(ob.sub(:,1)) == g.N;
    ob.boundOnY = max(ob.sub(:,2)) == g.N;
    ob.boundOnZ = max(ob.sub(:,3)) == g.N;
    
    %% Location and Size
    % ob center and size(Absolute values)
    ob.loc_abs = 1/2*(g.grid_rng([xrng(1) yrng(1) zrng(1)]) + ...
        g.grid_rng([xrng(end) yrng(end) zrng(end)]));
    ob.sz_abs = (g.grid_rng([xrng(end) yrng(end) zrng(end)]) - ...
        g.grid_rng([xrng(1) yrng(1) zrng(1)]) + g.dx);
    
    % ob center and size(Normalised values)
    ob.loc_norm = ob.loc_abs/(g.xmax - g.xmin);
    ob.sz_norm = ob.sz_abs/(g.xmax - g.xmin);
    
    %% Bounds
    ob.xmin = g.grid_rng(xrng(1))-1/2*g.dx;
    ob.xmax = g.grid_rng(xrng(end))+1/2*g.dx;
    ob.ymin = g.grid_rng(yrng(1))-1/2*g.dx;
    ob.ymax = g.grid_rng(yrng(end))+1/2*g.dx;
    ob.zmin = g.grid_rng(zrng(1))-1/2*g.dx;
    ob.zmax = g.grid_rng(zrng(end))+1/2*g.dx;
    
    %% Vertices and Faces
    ob.v = ...
        [ob.xmin ob.ymin ob.zmin;
        ob.xmin ob.ymin ob.zmax;
        ob.xmax ob.ymin ob.zmin;
        ob.xmax ob.ymin ob.zmax;
        ob.xmin ob.ymax ob.zmin;
        ob.xmin ob.ymax ob.zmax;
        ob.xmax ob.ymax ob.zmin;
        ob.xmax ob.ymax ob.zmax];
    ob.f = ...
        [2 8 6; 8 2 4;
        1 5 7; 1 7 3;
        5 2 6; 2 5 1;
        3 8 4; 8 3 7;
        1 4 2; 4 1 3;
        7 6 8; 6 7 5];
    ob.normals = cross( ob.v(ob.f(:,2),:) - ob.v(ob.f(:,1),:), ...
        ob.v(ob.f(:,3),:) - ob.v(ob.f(:,1),:) );
    ob.normals = ob.normals ./ repmat(sqrt(sum(ob.normals.^2,2)),1,3);
    
    %% Add Obstacle to Grid
    g.cTypes(ob.ind_e) = 'S';
    g.nonSolids_e = find(g.cTypes ~= 'S');
    [i,j,k] = ind2sub(g.shape, g.nonSolids_e);
    g.nonSolids = sub2ind(g.shape-2, i-1, j-1, k-1);
    g.obs{idx} = ob;
    g.ob_cur = g.ob_cur + 1;
end

