function PlotCubeWireframe( cube, color )
%   PLOTCUBEWIREFRAME Plots cube's Wireframe
%   cube: Cube to Plot
%   color: Color of Wireframe

    loc = cube.loc_abs;
    sz = cube.sz_abs;
    
    xmin = loc(1) - sz(1)/2;
    xmax = loc(1) + sz(1)/2;
    
    ymin = loc(2) - sz(2)/2;
    ymax = loc(2) + sz(2)/2;
    
    zmin = loc(3) - sz(3)/2;
    zmax = loc(3) + sz(3)/2;
    
    v1 = [xmin ymin zmin];
    v2 = [xmin ymax zmin];
    v3 = [xmax ymin zmin];
    v4 = [xmax ymax zmin];
    
    v5 = [xmin ymin zmax];
    v6 = [xmin ymax zmax];
    v7 = [xmax ymin zmax];
    v8 = [xmax ymax zmax];
    
    l1 = [v1; v2];
    l2 = [v2; v4];
    l3 = [v4; v3];
    l4 = [v3; v1];
    
    l5 = [v5; v6];
    l6 = [v6; v8];
    l7 = [v8; v7];
    l8 = [v7; v5];
    
    l9 = [v1; v5];
    l10 = [v2; v6];
    l11 = [v3; v7];
    l12 = [v4; v8];
    
    plot3(l1(:,1), l1(:,2), l1(:,3), color);
    plot3(l2(:,1), l2(:,2), l2(:,3), color);
    plot3(l3(:,1), l3(:,2), l3(:,3), color);
    plot3(l4(:,1), l4(:,2), l4(:,3), color);
    plot3(l5(:,1), l5(:,2), l5(:,3), color);
    plot3(l6(:,1), l6(:,2), l6(:,3), color);
    plot3(l7(:,1), l7(:,2), l7(:,3), color);
    plot3(l8(:,1), l8(:,2), l8(:,3), color);
    plot3(l9(:,1), l9(:,2), l9(:,3), color);
    plot3(l10(:,1), l10(:,2), l10(:,3), color);
    plot3(l11(:,1), l11(:,2), l11(:,3), color);
    plot3(l12(:,1), l12(:,2), l12(:,3), color);
end

