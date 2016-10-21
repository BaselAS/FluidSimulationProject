function [ g ] = ExtrapolateVelocity2D( g )
%   EXTRAPOLATEVELOCITY2D Extrapolate velocity to air cells
%   g: Grid

    %% Init variables
    surface = g.fluid.all_e(g.fluid.types == 'S');%Surface cells indices

    offsets = [-1; 1; -g.N_e; g.N_e];%Linear Offsets
    neighbors = repelem(surface, numel(offsets)) + ...
        repmat(offsets, numel(surface), 1);
    invalids = unique(neighbors(g.v_c.validCells(neighbors) == 'A'), ...
        'stable');
    
    %% Aux Function
    function [ ext_v ] = Extrapolate( idx )%Get extrapolated velocity for cell
        neighbors = idx + offsets;
        valids = neighbors(g.v_c.validCells(neighbors) == 'F');
        
        ext_v = 1/numel(valids)*sum([g.v_c.X(valids) g.v_c.Z(valids)], 1);
    end
    
    %% Extrapolate
    layer = 0;
    while layer < g.ext_layers && not(isempty(invalids)) %Loop until 
        %desired number of layers or no more invalid cells
        ext_v = arrayfun(@(idx) Extrapolate(idx), invalids, ...
            'UniformOutput', false);%Extrapolation velocities
        ext_v = cell2mat(ext_v);
        g.v_c.X(invalids) = ext_v(:,1);
        g.v_c.Z(invalids) = ext_v(:,2);
        
        g.v_c.validCells(invalids) = 'F';%Mard cells as Valid
        
        neighbors = repelem(invalids, numel(offsets), 1) + ...
            repmat(offsets, numel(invalids), 1);
        invalids = unique(neighbors(g.v_c.validCells(neighbors) == 'A'), ...
            'stable');
        
        layer = layer + 1;  
    end
end

