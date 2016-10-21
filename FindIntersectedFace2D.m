function [ normal, p_I ] = FindIntersectedFace2D( s, t, mesh, varargin )
    if nargin < 4
        f_check = 1:4;
    else
        side = varargin{1};
        if strcmp(side, 'Top')
            f_check = 1;
        elseif strcmp(side, 'Bottom')
            f_check = 2;
        elseif strcmp(side, 'Left')
            f_check = 3;
        else %Right
            f_check = 4;
        end
    end
    
    %% Aux Function
    A1 = t(2) - s(2);
    B1 = s(1) - t(1);
    C1 = A1*s(1) + B1*s(2);
    function [ r_I, flag ] = FaceIntersection( f )
        flag = true;
        A2 = f(2,2) - f(1,2);
        B2 = f(1,1) - f(2,1);
        C2 = A2*f(1,1) + B2*f(1,2);
        
        det = A1*B2 - A2*B1;
        if det == 0
            flag = false;
            p_I = s;
        end
        
        p_I(1) = (B2*C1 - B1*C2)/det;
        p_I(2) = (A1*C2 - A2*C1)/det;
        
        r_I = (p_I(1) - s(1)) / (t(1) - s(1));
        
        if r_I < 0 || r_I > 1
            flag = false;
            r_I = 0;
        end
    end

    %% Detect intersected faces
    [r_Is, flags] = arrayfun(@(ind) FaceIntersection( ...
        mesh.v(mesh.f(ind,:),:)), ...
        f_check);
    
    %% Detect first intersection
    if all(flags == false)
        disp (['ERROR - Intersection-Face inclusion test failed, ' ...
        'Attempting workaround'])
        r_I = r_Is(1);
        flags(1) = 1;
        ind = 1;
    else
        [r_I, ind] = min(r_Is(flags));
    end
    
    %% Calculate first intersection point
    p_I = (1-r_I)*s + r_I*t;
    
    %% Get first intersected face normal
    f_Is = f_check(flags);
    normal = mesh.normals(f_Is(ind),:);
end

