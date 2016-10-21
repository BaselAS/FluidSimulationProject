function [ particle_plot, quiver_plot ] = InitPlot3D( g, colors )
% INITPLOT3D Initialise Plot Window. Plot Grid, Emitters and Obstacles.
% Returns handles to Particle Plot and Quiver Plot.
% g: Grid
% colors: Matlab colors to color Emitters and Obstacles

    hold on;
    grid on;
    particle_plot = ...
        scatter3(g.particles(1:g.np_cur,1), g.particles(1:g.np_cur,2), ... 
        g.particles(1:g.np_cur,3), '.k');
    quiver_plot = [];
    
    PlotCubeWireframe(g, 'k');
    for i=1:4
        if isempty(g.ems{i})
            continue;
        end
        PlotCubeWireframe(g.ems{i}, colors(i));
        PlotEmitterDirection3D(g, i, colors(i));
    end
    for i=1:4
        if isempty(g.obs{i})
            continue;
        end
        PatchCube(g.obs{i}, colors(i));
    end
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    axis equal
    l_e = g.xmax_e - g.xmin_e;
    xlim([g.xmin_e-0.01*l_e g.xmax_e+0.01*l_e]);
    ylim([g.xmin_e-0.01*l_e g.xmax_e+0.01*l_e]);
    zlim([g.xmin_e-0.01*l_e g.xmax_e+0.01*l_e]);
end

