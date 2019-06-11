function f_D = dragAcceleration (rIJK, vIJK, constants)
% dragAcceleration Computes drag acceleration on a spacecraft
%
% Assumes an exponential atmospheric density model
%
% Inputs :
%   rIJK - ECI position vector of satellite [km]
%   vIJK - ECI velocity vector of satellite [km/s]
%   constants - Cell array of necessary constants :
%       {1} = Re - radius of Earth [km]
%       {2} = wE - rotation rate of Earth [ rad /s]
%       {3} = M - mass of satellite [kg]
%       {4} = CD - drag coefficient of satellite
%       {5} = A - cross-sectional area of satellite [m ^2]
%       {6} = h0 - reference altitude [km]
%       {7} = rho0 - reference density [kg/m ^3]
%       {8} = H - characteristic altitude [km]
%
% Outputs :
%   f_d - Acc. due to drag in ECI frame [km/s^2]

% Retrieve the general constants
rE = constants {1};
wE = constants {2};

% Retrieve satellite parameters
M = constants {3};
CD = constants {4};
A = constants {5};

% Retrieve density model parameters
h0 = constants {6};
rho0 = constants {7};
H = constants {8};

% Compute the satellite's ballistic coefficient
B = CD*A/M;

% Estimate the density at the local altitude
h = norm(rIJK) - rE;
expArg = -(h - h0)/H;
rho = rho0*exp(expArg);

% Determine the velocity vector relative to the atmosphere
v_rel = vIJK - cross([0; 0; wE], rIJK);

% Compute drag vector on spacecraft
f_D = -0.5*B*rho*norm(v_rel)*v_rel ;

end