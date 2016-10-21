function [ normal, p_I ] = FindIntersectedFace3D( s, t, mesh, varargin )
    planeI_known = false;
    if nargin < 4
        f_check = 1:12;
    else
        side = varargin{1};
        planeI_known = true;
        if strcmp(side, 'Top')
            f_check = [1 2];
        elseif strcmp(side, 'Bottom')
            f_check = [3 4];
        elseif strcmp(side, 'Left')
            f_check = [5 6];
        elseif strcmp(side, 'Right')
            f_check = [7 8];
        elseif strcmp(side, 'Near')
            f_check = [9 10];
        else %Far
            f_check = [11 12];
        end
    end
    
    %% Aux Function
    dir = t - s;
    function [ r_I, flag ] = FaceIntersection(f, N, planeI_known )
        flag = true;
        % Check for plane intersection
        if not(planeI_known)
            denom = N*dir';
            if denom == 0
                flag = false;
                r_I = 0;
                return;
            end
            r_I = N*(f(1,:)-s)'/denom;
            if r_I < 0 || r_I > 1
                flag = false;
                r_I = 0;
                return;
            end
        else
            r_I = N*(f(1,:)-s)'/(N*dir');
        end

        % Check intersection point's inclusion in T
        p_I = (1-r_I)*s + r_I*t;
        w = p_I - f(1,:);
        u = f(2,:) - f(1,:);
        v = f(3,:) - f(1,:);

        denom = ((u*v')^2 - (u*u')*(v*v'));
        s_I = ((u*v')*(w*v')-(v*v')*(w*u'))/denom;
        t_I = ((u*v')*(w*u')-(u*u')*(w*v'))/denom;
        if s_I < 0 || t_I < 0 || s_I+t_I > 1
            flag = false;
            r_I = 0;
            return;
        end
    end

    %% Detect intersected faces
    [r_Is, flags] = arrayfun(@(ind) FaceIntersection( ...
        mesh.v(mesh.f(ind,:),:), mesh.normals(ind,:), planeI_known), ...
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

