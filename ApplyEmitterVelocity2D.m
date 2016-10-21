function [ g ] = ApplyEmitterVelocity2D( g, i )
%   APPLYEMITTERVELOCITY2D Apply Emitter's velocity on cells covered by
%   Emitter.
%   g: Grid
%   i: Emitter index

    em = g.ems{i};
    g.v_c.X(em.ind_e) = em.vel(1);
    g.v_c.Z(em.ind_e) = em.vel(2);
end

