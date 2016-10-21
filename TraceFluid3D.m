function [ g ] = TraceFluid3D( g, particles, varargin )
%   TRACEFLUID3D Traces which Grid Cells contain particles and how many
%   g: Grid
%   particles: Particles to trace location of
%   varargin: optional index of emitter that spawned @particles. Used to 
%   locate cells covered by Emitter so to apply Emitters velocity to them.

    cells = ceil((particles - g.xmin_e) / g.dx);
    
    % all_e: indices of all fluid cells(Entire Grid)
    % all: indices of all fluid cells(Fluid Domain)
    % density: number of particles in cell.
    [indices, ~, labels] = unique(cells, 'rows', 'stable');
    fluid.all_e = sub2ind(g.shape, indices(:,1),indices(:,2),indices(:,3));
    fluid.all = sub2ind(g.shape-2, ...
        indices(:,1)-1, indices(:,2)-1, indices(:,3)-1);
    
    instances = histcounts(labels, max(labels));
    fluid.density = instances(:);
    
    g.fluid = fluid;

    % save indices in Emitter i
    if nargin == 3
        i = varargin{1};
        g.ems{i}.ind_e = fluid.all_e;
    end
end

