function [ p_x, p_y, p_z ] = FixPressureDerivative3D( g, p_x, p_y, p_z)
%   FIXPRESSUREDERIVATIVE3D Enforce boundary conditions on pressure
%   derivative.
%   g: Grid
%   p_x, p_y, p_z: Pressure Derivative in X,Y,Z dimensions
    for i = 1:4
        if isempty(g.obs{i})
            continue;
        end
        p_x(g.obs{i}.wallsX(:,1)) = 0;
        p_y(g.obs{i}.wallsY(:,1)) = 0;
        p_z(g.obs{i}.wallsZ(:,1)) = 0;
        
        if not(g.obs{i}.boundOnX)
            p_x(g.obs{i}.wallsX(:,2)+1) = 0;
        end
        
        if not(g.obs{i}.boundOnY)
            p_y(g.obs{i}.wallsY(:,2)+g.N) = 0;
        end
        
        if not(g.obs{i}.boundOnZ)
            p_z(g.obs{i}.wallsZ(:,2)+g.N^2) = 0;
        end
    end
end

