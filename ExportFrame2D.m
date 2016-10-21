function ExportFrame2D( g, frameNo, pathData )
%   EXPORTFRAME2D Export Frame's Particle Data
%   g: Grid
%   frameNo: Number of Frame

    %% Normalise
    p_norm = (g.particles(1:g.np_cur,:) - g.xmin) / (g.xmax - g.xmin);
    
    %% Write
    dlmwrite([pathData '/data' num2str(frameNo+1) '.txt'], ...
        [p_norm(:,1) ...
        zeros(g.np_cur,1) ... %2D, Y coordinate = 0
        p_norm(:,2)], ' ');
end