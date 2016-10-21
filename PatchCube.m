function PatchCube ( cube, color )
%   PATCHCUBE Draw Cube
%   cube: Cube to Draw
%   color: Color of Cube

    loc = cube.loc_abs;
    sz = cube.sz_abs;
    x=([0 1 1 0 0 0;1 1 0 0 1 1;1 1 0 0 1 1;0 1 1 0 0 0]-0.5)*sz(1)+loc(1);
    y=([0 0 1 1 0 0;0 1 1 0 0 0;0 1 1 0 1 1;0 0 1 1 1 1]-0.5)*sz(2)+loc(2);
    z=([0 0 0 0 0 1;0 0 0 0 0 1;1 1 1 1 0 1;1 1 1 1 0 1]-0.5)*sz(3)+loc(3);
    for i=1:6
        h=patch(x(:,i),y(:,i),z(:,i),color);
        set(h,'edgecolor','k')
    end
end