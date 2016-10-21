function [ g ] = InitGrid3D( N, xmin, xmax, np_max, p_res, isSimple, ...
    isVelCheat, v_cen_it, bounceNum, ext_layers, particle_diffusion)
%  INITGRID3D Create and initialise Grid
%   N: Fluid Grid Dimension
%   xmin, xmax: Fluid Grid range [xmin, xmax]
%   np_max: Maximum number of Particles
%   p_res: Number of emitted particles per grid cell: p_res^3
%   isSmoke: Is it a smoke simulation
%   v_cen_it: Number of Runge-Kutta method iterations
%   bounceNum: Number of particles bounces before respawn
%   ext_layers: Number of layers off surface to extrapolate
%   particle_diffusion: Particle Diffusion Coefficient
    
    %% Parameters
    g.N = N; % 
    g.N_e = N + 2; % Entire Grid Dimension(uncluding walls)
    g.shape = repelem(g.N_e,3);
    g.np_cur = 0; % Current Number of Particles
    g.np_max = np_max;
    g.p_res = p_res;
    g.isSimple = isSimple;
    g.isVelCheat = isVelCheat;
    g.v_cen_it = v_cen_it; 
    g.bounceNum = bounceNum; 
    g.ext_layers = ext_layers;
    g.particle_diffusion = particle_diffusion;
    
    
    %% Emitters and Obstacles
    g.obs = cell(4,1); % Obstacles container
    g.ob_cur = 1;
    g.ems = cell(4,1); % Emitters container
    g.em_cur = 1;
    
    %% Bounds
    g.xmin = xmin;
    g.xmax = xmax;
    l = g.xmax - g.xmin; % Fluid domain length
    
    g.xmin_e = xmin - l/N; % Entire Grid range [xmin_e, xmax_e]
    g.xmax_e = xmax + l/N;
    
    %% Range
    l_e = g.xmax_e - g.xmin_e;
    
    g.grid_rng = linspace( g.xmin_e+l_e/2/g.N_e, ...
                                g.xmax_e-l_e/2/g.N_e, ...
                                g.N_e); % Cell locations on range
    
    g.dx = g.grid_rng(2) - g.grid_rng(1); 
          
    %% Mesh
    [g.grid_mesh.Y, g.grid_mesh.X, g.grid_mesh.Z] = ...
        meshgrid(g.grid_rng,g.grid_rng,g.grid_rng); % Cell locations
    
    %% Location and size
    % Fluid Domain center and size(Absolute values)
    g.loc_abs = [0.5 0.5 0.5]*g.xmin + [0.5 0.5 0.5]*g.xmax;
    g.sz_abs = repelem(g.xmax - g.xmin,3);
    
    %% Cell Types
    g = GetcTypes3D(g); % Create Cell Types Grid
    
    %% Indices
    % Indices of Fluid Domain and non-solid cells in Entire Grid
    indices = reshape(1:g.N_e^3,g.N_e,g.N_e,g.N_e);
    g.interior_e = indices(2:g.N_e-1, 2:g.N_e-1, 2:g.N_e-1);
    g.nonSolids_e = col(g.interior_e);
    [i,j,k] = ind2sub(g.shape, g.nonSolids_e);
    g.nonSolids = sub2ind(g.shape-2, i-1, j-1, k-1);
    
    %% Velocity fields on faces and cells
    % Create Velocity field on Cell Faces and Cell centers
    g.v_f.X = zeros(g.shape);
    g.v_f.Y = zeros(g.shape);
    g.v_f.Z = zeros(g.shape);
    
    g = FacesToCells3D(g);
    g.v_c.validCells = [];
    
    %% Particles
    % Particles container
    g.particles = zeros(g.np_max,3);
    
    %% Vertices, faces and normals.
    g.v = ...
        [xmin xmin xmin;
        xmin xmin xmax;
        xmax xmin xmin;
        xmax xmin xmax;
        xmin xmax xmin;
        xmin xmax xmax;
        xmax xmax xmin;
        xmax xmax xmax];
    g.f = ...
        [2 6 8; 8 4 2;
        1 7 5; 7 1 3;
        5 6 2; 2 1 5;
        3 4 8; 8 7 3;
        1 2 4; 4 3 1;
        7 8 6; 6 5 7];
    
    g.normals = cross( g.v(g.f(:,2),:) - g.v(g.f(:,1),:), ...
        g.v(g.f(:,3),:) - g.v(g.f(:,1),:) );
    g.normals = g.normals ./ repmat(sqrt(sum(g.normals.^2,2)),1,3);
end

