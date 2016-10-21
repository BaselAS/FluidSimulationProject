function PlotEmitterDirection3D( g, i, color )
%   PLOTEMITTERDIRECTION3D plot vector of Emitter's velocity
%   em: Emitter
%   color: Color of vector
    em = g.ems{i};
    loc = em.loc_abs;
    dir = em.vel/norm(em.vel);
    factor = 0.1*(g.xmax - g.xmin);
    quiver3(loc(1),loc(2),loc(3),dir(1),dir(2),dir(3),factor,'color',color,...
        'linewidth', 1, 'MaxHeadSize', 1);
end

