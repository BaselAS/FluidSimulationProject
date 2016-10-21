function [ df ] = ForwardDifference( f, DIM, d )
    df = 1/d * diff(f,1,DIM);
end

