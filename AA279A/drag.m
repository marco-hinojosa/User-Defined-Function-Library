function D = drag(r, v)
% Initialize Constants and Density Parameters
M = 1500;               % Satellite Mass
C_D = 2.3;              % Drag Coefficient
A = 20e-6;              % Cross-Sectional Satellite Area
h0 = 0;                 % Reference Altitude (Sea Level)
rho0 = 1.225e9;         % Reference Density (Sea Level)
H = 10;                 % Characteristic Altitude
r_E = 6378;             % Earth's Radius
om_E = 7.2722e-5;       % Earth's Angular Velocity

% Compute Density at Desired Altitude
h = norm(r) - r_E;
rho = rho0*exp(-(h - h0)/H);

% Compute Relative Velocity
om_vec = [0; 0; om_E];
Vrel = v - cross(om_vec, r);

% Satellite Ballistic Coefficient
B = A*C_D/M;

% Compute Drag
D = -(0.5)*B*rho*Vrel*norm(Vrel);

end