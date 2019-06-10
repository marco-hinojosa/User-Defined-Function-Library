%% Calling Program for ISS Simulink File
% Marco Hinojosa
% 06181747

% Given Orbital Elements
mu = 3.986e5; % Standard Gravitational Parameter of the Earth
a = 6781.5; % Semimajor Axis
e = 0.0006483; % Eccentricity
i = 51.6422*(pi/180); % Inclination [rad]
RAAN = 81.0775*(pi/180); % Right Angle of Ascending Node [rad]
w = 39.2648*(pi/180); % Argument of Periapsis [rad]
eps = 10e-10; % Newton-Raphson Tolerance
dt = 10000; % User-Defined Time Increment
InitialDate = [2018, 4, 22];

% Computed Values
T = 2*pi*sqrt((a^3)/mu); % Orbital Period
n = sqrt(mu/(a^3)); % Mean Motion
M0 = 0.9101; % Initial Mean Anomaly (at Periapsis) [rad]

% Run Simulink
sim ISS

% Part (b): Plot Results
figure, hold on
plot3(r_pqw(:,1),r_pqw(:,2),r_pqw(:,3),'LineWidth',2)
title(sprintf("Orbit of ISS in Perifocal Coordinates"))
xlabel('x [km]'), ylabel('y [km]'), zlabel('z [km]')
grid on, axis equal

% Part (c): Plot Results
figure, hold on
plot3(r_eci(:,1),r_eci(:,2),r_eci(:,3),'LineWidth',2)
title(sprintf("Orbit of ISS in ECI Coordinates"))
xlabel('x [km]'), ylabel('y [km]'), zlabel('z [km]')
earthPlot(1), grid on, axis equal

% Part (d): Plot Results
figure, hold on
plot3(r_ecef(:,1),r_ecef(:,2),r_ecef(:,3),'LineWidth',2)
title(sprintf("Orbit of ISS in ECEF Coordinates"))
xlabel('x [km]'),ylabel('y [km]'), zlabel('z [km]')
earthPlot(1), grid on, axis equal