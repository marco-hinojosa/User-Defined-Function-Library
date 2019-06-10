%% Calling Program for Iridium18 Simulink File
% Marco Hinojosa
% 06181747
close all

% Given Orbital Elements
r_E = 6378.1; % Earth Equatorial Orbit
mu = 3.986e5; % Standard Gravitational Parameter of the Earth
a = 7155.81; % Semimajor Axis [km]
e = 0.0001971; % Eccentricity
i = 86.394*(pi/180); % Inclination [rad]
RAAN = 230.875*(pi/180); % Right Angle of Ascending Node [rad]
w = 89.913*(pi/180); % Argument of Periapsis [rad]
M0 = 27.230*(pi/180); % Initial Mean Anomaly [rad]
InitialDate = 57421.51059303; % Epoch (MJD)

% Ground Station Geocentric Coordinates
lambda_GS = -122.173355*(pi/180); % [rad]
phi_GS = 37.426622*(pi/180); % [rad]

% Simulation Parameters
eps = 10e-10; % Newton-Raphson Tolerance
dt = 1; % User-Defined Time Increment

% Computed Values
T = 2*pi*sqrt((a^3)/mu); % Orbital Period
n = sqrt(mu/(a^3)); % Mean Motion

% Run Simulink
sim Iridium18

% PQW Orbit
figure, hold on
plot3(r_pqw(:,1),r_pqw(:,2),r_pqw(:,3),'LineWidth',2)
title(sprintf("Orbit of Iridium-18 in Perifocal Coordinates"))
xlabel('x [km]'), ylabel('y [km]'), zlabel('z [km]')
grid on, axis equal

% ECI Orbit
figure, hold on
plot3(r_eci(:,1),r_eci(:,2),r_eci(:,3),'LineWidth',2)
title(sprintf("Orbit of Iridium-18 in ECI Coordinates"))
xlabel('x [km]'), ylabel('y [km]'), zlabel('z [km]')
earthPlot(1), grid on, axis equal

% ECEF Orbit
figure, hold on
plot3(r_ecef(:,1),r_ecef(:,2),r_ecef(:,3),'LineWidth',2)
title(sprintf("Orbit of Iridium-18 in ECEF Coordinates"))
xlabel('x [km]'), ylabel('y [km]'), zlabel('z [km]')
earthPlot(1), grid on, axis equal

% Ground Track Plot
figure, hold on
load('topo.mat', 'topo'); % Load and plot MATLAB built-in Earth topography data
topoplot = [topo(:, 181:360), topo(:, 1:180)];
contour(-180:179, -90:89, topoplot, [0, 0], 'black');
lambda1 = lambda(1:2566); phi1 = phi(1:2566); % Remove Jump Discontinuity
lambda2 = lambda(2567:end); phi2 = phi(2567:end); % Remove Jump Discontinuity
plot(lambda1,phi1,'b-',lambda2,phi2,'b-')
title('Iridium-18 Groundtrack')
grid on, axis equal
xlim([-180, 180]);
ylim([-90, 90]);
xlabel('Longitude [\circ]'), ylabel('Latitude [\circ]');

% Part(b): Compute Time History of Satellite Motion
range = zeros(length(r_enu),1);
vel = zeros(length(r_enu)-1,1);
for ii = 1:length(r_enu)
    range(ii,1) = norm(r_enu(ii,:)); % Relative Range
    A(ii,1) = atan2d(r_enu(ii,1), r_enu(ii,2)); % Azimuth
    E(ii,1) = atan2d(r_enu(ii,3), sqrt(r_enu(ii,1)^2 + r_enu(ii,2)^2)); % Elevation
    if ii > 1
        vel(ii-1,1) = (range(ii,1)-range(ii-1,1))/dt; % Finite-Difference
        Avel(ii-1,1) = (A(ii,1)-A(ii-1,1))/dt; % Finite-Difference
        Evel(ii-1,1) = (E(ii,1)-E(ii-1,1))/dt; % Finite-Difference
    end
end
tspan1 = linspace(0, 2*3600, length(r_enu));

% Parse for Positive Elevation (Line of Sight) and Plot
range_LOS = range(4278:5147);
figure,
subplot(2,2,1), plot(tspan1(4278:5147)/60,range(4278:5147))
title('Range (Line of Sight)')
xlabel('Time [min]'), ylabel('Range [km]'), grid on
subplot(2,2,2), plot(tspan1(4278:5147)/60,vel(4278:5147))
title('Velocity (Line of Sight)')
xlabel('Time [min]'), ylabel('Velocity [km/s]'), grid on
subplot(2,2,3), plot(tspan1(4278:5147)/60,A(4278:5147))
title('Azimuth (Line of Sight)')
xlabel('Time [min]'), ylabel('A [deg]'), grid on
subplot(2,2,4), plot(tspan1(4278:5147)/60,E(4278:5147))
title('Elevation (Line of Sight)')
xlabel('Time [min]'), ylabel('E [deg]'), grid on
