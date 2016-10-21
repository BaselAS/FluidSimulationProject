function [ g ] = InitGrid2D( N, xmin, xmax, np_max, p_res, isSimple, ...
    isVelCheat, v_cen_it, bounceNum, ext_layers, particle_diffusion)
%  INITGRID2D Create and initialise Grid
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
    g.shape = repelem(g.N_e,2);
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
    [g.grid_mesh.Z, g.grid_mesh.X] = ...
        meshgrid(g.grid_rng,g.grid_rng); % Cell locations
    
    %% Location and size
    % Fluid Domain center and size(Absolute values)
    g.loc_abs = [0.5 0.5]*g.xmin + [0.5 0.5]*g.xmax;
    g.sz_abs = repelem(g.xmax - g.xmin,2);
    
    %% Cell Types
    g = GetcTypes2D(g); % Create Cell Types Grid
    
    %% Indices
    % Indices of Fluid Domain and non-solid cells in Entire Grid
    indices = reshape(1:g.N_e^2,g.N_e,g.N_e);
    g.interior_e = indices(2:g.N_e-1, 2:g.N_e-1);
    g.nonSolids_e = col(g.interior_e);
    [i,j] = ind2sub(g.shape, g.nonSolids_e);
    g.nonSolids = sub2ind(g.shape-2, i-1, j-1);
    
    %% Velocity fields on faces and cells
    % Create Velocity field on Cell Faces and Cell centers
    g.v_f.X = zeros(g.shape);
    g.v_f.Z = zeros(g.shape);
    
    g = FacesToCells2D(g);
    g.v_c.validCells = [];
    
    %% Particles
    % Particles container
    g.particles = zeros(g.np_max,2);
    
    %% Vertices, faces and normals.
    g.v = ...
        [xmin xmin; %Bottom left
        xmax xmin; %Bottom right
        xmin xmax; %Top left
        xmax xmax]; %Top right
    g.f = ...
        [3 4;  %Top
        1 2; %Bottom
        1 3; %Left
        2 4]; %Right
    
    g.normals = ...
        [0 -1;
        0 1;
        1 0;
        -1 0];
end

