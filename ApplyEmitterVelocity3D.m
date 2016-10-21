function [ g ] = ApplyEmitterVelocity3D( g, i )
%   APPLYEMITTERVELOCITY3D Apply Emitter's velocity on cells covered by
%   Emitter.
%   g: Grid
%   i: Emitter index

    em = g.ems{i};
    g.v_c.X(em.ind_e) = em.vel(1);
    g.v_c.Y(em.ind_e) = em.vel(2);
    g.v_c.Z(em.ind_e) = em.vel(3);
end

