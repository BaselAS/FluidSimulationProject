function ExportFrame3D( g, frameNo, pathData )
%   EXPORTFRAME3D Export Frame's Particle Data
%   g: Grid
%   frameNo: Number of Frame
    
    %% Normalise
    p_norm = (g.particles(1:g.np_cur,:) - g.xmin) / (g.xmax - g.xmin);
    
    %% Write
    dlmwrite([pathData '/data' num2str(frameNo+1) '.txt'], ...
        p_norm, ' ');
end

