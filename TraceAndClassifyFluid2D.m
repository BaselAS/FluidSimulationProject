function [ g ] = TraceAndClassifyFluid2D( g )
%   TRACEANDCLASSIFYFLUID2D Trace which cells contain particles and
%   classify as Inner Cell(Surrounded by fluid) or Surface Cell(Has at
%   least one non-fluid cell.
%   g: Grid

    %% Find Fluid Cell indices
    g = TraceFluid2D(g, g.particles(1:g.np_cur,:));
    
    %% Temp Cell Types Grid for classification of cells
    cTypes = g.cTypes;
    cTypes(g.fluid.all_e) = 'F';
    
    %% Aux Function
    offsets = [1 -1 g.N_e -g.N_e]; %Linear Offsets
    function [ type ] = ClassifyFluidCell3D(idx)
        neighbors = idx + offsets;
        if all(cTypes(neighbors) == 'F')
            type = 'I';
        else
            type = 'S';
        end
    end
    
    %% Check every Cell and classify its type (Inner/Surface)
    g.fluid.types = col(arrayfun( @(idx) ClassifyFluidCell3D(idx), ...
        g.fluid.all_e));
    
    %% Sort
    % Purpose: Otherwise, the constructed system of equations matrix used
    % for pressure solving won't be tridiagonal and therefore more 
    % difficult to invert.
    [g.fluid.all_e, I] = sort(g.fluid.all_e, 'ascend');
    g.fluid.all = g.fluid.all(I);
    g.fluid.types = g.fluid.types(I);
    g.fluid.density = g.fluid.density(I);
    
    %% Cells with Valid Velocity(For Velocity Extrapolation)
    g.v_c.validCells = g.cTypes;
    g.v_c.validCells(g.fluid.all_e) = 'F'; %Valid cells marked with F
end