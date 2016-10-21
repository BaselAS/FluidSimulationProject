function [ flag ] = isEmitterEmpty( g, i )
    flag = isempty(g.ems{i});
end

