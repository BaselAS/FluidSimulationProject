function ExportObs3D( g, pathData )
%   EXPORTOBS3D Export Obstacles' Location and Size
%   g: Grid

    f = fopen([pathData '/obs.txt'], 'w');
    for i = 1:4
        if isempty(g.obs{i})
            continue;
        end
        fprintf(f, '%f %f %f %f %f %f\n', ...
            g.obs{i}.loc_norm, g.obs{i}.sz_norm);
    end
    fclose(f);
end

