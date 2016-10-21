function [ L ] = SystemMatrixSimple2D( g )
%   SIMPLECOEFFMATRIX2D Build System of Equations matrix for the Simple
%   Case of Pressure Solving.
%   g: Grid

    %% Init Indices Grid
    %Helps getting the index of the matrix rows corresponding to the
    %neighbors of a cell.
    indices_grid = zeros(g.shape);
    indices_grid(g.nonSolids_e) = 1:numel(g.nonSolids_e);
    
    %% Aux Function
    offsets = [-1; 1; -g.N_e; g.N_e]; %Linear Offsets
    function [r, c, v] = GetRow(idx)%Construct one Matrix Row
        neighbors = idx + offsets;
        nonSolids = neighbors(g.cTypes(neighbors) ~= 'S');
        r = repmat(indices_grid(idx), numel(nonSolids)+1, 1);
        c = [indices_grid(idx); indices_grid(nonSolids)];
        v = [numel(nonSolids); -ones(numel(nonSolids),1)];
    end

    %% Get Rows
    [R, C, V] = arrayfun( @(idx) GetRow(idx), g.nonSolids_e, ...
        'UniformOutput', false);
    r = cell2mat(R);
    c = cell2mat(C);
    v = cell2mat(V);
    
    %% Build Matrix
    L = sparse(r, c, v, numel(g.nonSolids_e), numel(g.nonSolids_e));
end