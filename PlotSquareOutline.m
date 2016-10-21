function PlotSquareOutline( square, color )
%   PLOTSQUAREOUTLINE Plots square outline
%   cube: square to Plot
%   color: Color of outline

    loc = square.loc_abs;
    sz = square.sz_abs;
    
    xmin = loc(1) - sz(1)/2;
    xmax = loc(1) + sz(1)/2;
    
    zmin = loc(2) - sz(2)/2;
    zmax = loc(2) + sz(2)/2;
    
    v1 = [xmin zmin]; % Bottom left
    v2 = [xmax zmin]; % Bottom right
    v3 = [xmin zmax]; % Top left
    v4 = [xmax zmax]; % Top right
    
    top = [v3; v4];
    bottom = [v1; v2];
    left = [v1; v3];
    right = [v2; v4];
    
    plot(top(:,1), top(:,2), color);
    plot(bottom(:,1), bottom(:,2), color);
    plot(left(:,1), left(:,2), color);
    plot(right(:,1), right(:,2), color);
end

