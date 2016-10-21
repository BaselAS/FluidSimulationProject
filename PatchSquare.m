function PatchSquare ( square, color )
%   PATCHSQUARE Draw Square
%   square: square to Draw
%   color: Color of Cube

    loc = square.loc_abs;
    sz = square.sz_abs;
    x=([0 1 1 0]-0.5)*sz(1)+loc(1);
    z=([0 0 1 1]-0.5)*sz(2)+loc(2);
    patch(x,z,color);
end