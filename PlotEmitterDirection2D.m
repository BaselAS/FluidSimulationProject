function PlotEmitterDirection2D( g, i, color )
%   PLOTEMITTERDIRECTION2D plot vector of Emitter's velocity
%   em: Emitter
%   color: Color of vector
    em = g.ems{i};
    loc = em.loc_abs;
    dir = em.vel/norm(em.vel);
    factor = 0.1*(g.xmax - g.xmin);
    quiver(loc(1),loc(2),dir(1),dir(2),factor,'color',color,...
        'linewidth', 1, 'MaxHeadSize', 1);
end