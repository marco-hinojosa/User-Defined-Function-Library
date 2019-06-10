%% Calling Program for Halleys_Comet Simulink File
% Marco Hinojosa
% 06181747

% Given Values
mu = 1.327e11; % Standard Gravitational Parameter of the Sun
a = 2667966400; % Semimajor Axis
e = 0.967; % Eccentricity
eps = 10e-10; % Newton-Raphson Tolerance
dt = 10000; % User-Defined Time Increment

% Computed Values
T = 2*pi*sqrt((a^3)/mu); % Orbital Period
n = sqrt(mu/(a^3)); % Mean Motion
M0 = 0; % Initial Mean Anomaly (at Periapsis)

% Run Simulink
sim Halleys_Comet

% Plot Results with Tick Marks
N = round(0.04*T/dt);
xtick = r_pqw(1:N:end,1); ytick = r_pqw(1:N:end,2);
plot(r_pqw(:,1),r_pqw(:,2)), hold on
plot(xtick,ytick,'ko','MarkerFaceColor','k')
title(sprintf("Orbit of Halley's Comet in Perifocal Coordinates"))
xlabel('x [km]'),ylabel('y [km]')

