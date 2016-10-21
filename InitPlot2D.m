function [ particle_plot, quiver_plot ] = InitPlot2D( g, colors )
% INITPLOT2D Initialise Plot Window. Plot Grid, Emitters and Obstacles.
% Returns handles to Particle Plot and Quiver Plot.
% g: Grid
% colors: Matlab colors to color Emitters and Obstacles

    hold on;
    grid on;
    particle_plot = ...
        scatter(g.particles(1:g.np_cur,1),g.particles(1:g.np_cur,2),'.k');
    quiver_plot = [];
    
    PlotSquareOutline(g, 'k');
    for i=1:4
        if isempty(g.ems{i})
            continue;
        end
        PlotSquareOutline(g.ems{i}, colors(i));
        PlotEmitterDirection2D(g, i, colors(i));
    end
    for i=1:4
        if isempty(g.obs{i})
            continue;
        end
        PatchSquare(g.obs{i}, colors(i));
    end
    xlabel('X');
    zlabel('Z');
    axis equal
    l_e = g.xmax_e - g.xmin_e;
    xlim([g.xmin_e-0.01*l_e g.xmax_e+0.01*l_e]);
    ylim([g.xmin_e-0.01*l_e g.xmax_e+0.01*l_e]);
end

