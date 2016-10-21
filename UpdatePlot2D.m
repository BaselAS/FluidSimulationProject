function [ particle_plot, quiver_plot ] = UpdatePlot2D( g, ...
    particle_plot, isQuiver, quiver_plot, isScreenshot, frameNo, pathSC )
%   UPDATEPLOT2D Updates the Plot window, plots Particles and Quiver.
%   returns handles to the new plots.
%   g: Grid
%   particle_plot: Handle to the current Particle Plot
%   isQuiver: Plot Quiver
%   quiver_plot: Handle to the current Quiver Plot
%   isScreenshot: Take Screenshot
%   frameNo: Number of current Frame

    pause(0.001);
    delete(particle_plot);
    delete(quiver_plot);
    colors = [  zeros(g.np_cur,2), ...
                g.particle_vel_abs/max(g.particle_vel_abs) ];
    particle_plot = ...
        scatter(g.particles(1:g.np_cur,1), g.particles(1:g.np_cur,2), ... 
        ones(g.np_cur,1), colors, '.');
    if isQuiver
        delete(quiver_plot);
        valids = g.v_c.validCells == 'F';
        quiver_plot = quiver(g.grid_mesh.X(valids), ...
            g.grid_mesh.Z(valids), ...
            g.v_c.X(valids), g.v_c.Z(valids), ...
            'color','r', 'AutoScale', 'on');
    end
    axis equal
    l_e = g.xmax_e - g.xmin_e;
    xlim([g.xmin_e-0.01*l_e g.xmax_e+0.01*l_e]);
    ylim([g.xmin_e-0.01*l_e g.xmax_e+0.01*l_e]);
    
    if isScreenshot
        F=getframe(gca);
        imwrite(F.cdata,[pathSC '/sim' num2str(frameNo+1) '.png'])
    end
end

