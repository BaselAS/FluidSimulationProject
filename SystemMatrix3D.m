function [ L ] = SystemMatrix3D( g )
%   SYSTEMMATRIX3D Build System of Equations matrix for the Simple
%   Case of Pressure Solving.
%   g: Grid

    %% Init Indices Grid
    %Helps getting the index of the matrix rows corresponding to the
    %neighbors of a cell.
    indices_grid = zeros(g.shape);
    indices_grid(g.fluid.all_e) = 1:numel(g.fluid.all_e);
    
    %% Aux Functions
    function [ L ] = InnerEquations()%Construct Matrix Rows for Inner Cells
        inner = find(g.fluid.types == 'I');

        if isempty(inner)
            L = 0;
            return
        end

        r = repelem(inner, 7);
        offsets = repmat([0; -1; 1; -g.N_e; g.N_e; -g.N_e^2; g.N_e^2], ...
            numel(inner), 1);
        neighbors = g.fluid.all_e(r) + offsets;
        c = indices_grid(neighbors);

        v = repmat([6; -1; -1; -1; -1; -1; -1], numel(inner), 1);
        L = sparse(r, c, v, numel(g.fluid.all_e), numel(g.fluid.all_e));
    end

    function [ L ] = SurfaceEquations()%Construct Matrix Rows for Surface Cells
        % Aux Function
        offsets = [1; -1; g.N_e; -g.N_e; g.N_e^2; -g.N_e^2];
        function [ r, c, v ] = GetSurfaceRow( idx_grid )%Construct one Matrix Row
            neighbors = idx_grid + offsets;
            nonSolids = neighbors(g.cTypes(neighbors) ~= 'S');
            fluid = nonSolids(indices_grid(nonSolids) > 0);

            r = repelem(indices_grid(idx_grid), numel(fluid) + 1)';
            c = indices_grid([idx_grid; fluid]);
            v = [numel(nonSolids); -ones(numel(fluid),1)];
        end
        % Get Rows
        [R, C, V] = arrayfun(...
            @(idx_grid) ...
            GetSurfaceRow(idx_grid), ...
            g.fluid.all_e(g.fluid.types == 'S'), 'UniformOutput', false);
        r = cell2mat(R);
        c = cell2mat(C);
        v = cell2mat(V);

        L = sparse(r, c, v, numel(g.fluid.all_e), numel(g.fluid.all_e));
    end

    %% Build system
    inner_sys = InnerEquations();
    surface_sys = SurfaceEquations();
    L = inner_sys + surface_sys;
end