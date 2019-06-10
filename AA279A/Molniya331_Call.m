%% Calling Program for Molniya331 Simulink File
% Marco Hinojosa
% 06181747
close all

% Given ECI State Vectors
r_eci = [-2827.4, -8916.9, -2340.8]; % Position [km]
v_eci = [4.6567, 3.2251, -5.9629]; % Velocity [km/s]

% Convert ECI to Orbital Elements
mu = 3.986004e5; % Standard Gravitational Parameter of the Earth
[a,e,i,RAAN,w,anom,ang] = ECI2OE(r_eci, v_eci, mu); % Angles in Degrees
i = deg2rad(i); % Inclination [rad]
RAAN = deg2rad(RAAN); % Right Angle of Ascending Node [rad]
w = deg2rad(w); % Argument of Periapsis [rad]
anom = deg2rad(anom); % True Anomaly [rad]

% Simulation Parameters
eps = 10e-10; % Newton-Raphson Tolerance
dt = 10; % User-Defined Time Increment
InitialDate = [2018, 2, 1]; % February 1, 2018 0:00h

% Computed Values
dUT1 = 196.5014e-3; % Bias between UT1 and UTC time standards [sec]
T = 2*pi*sqrt((a^3)/mu); % Orbital Period
n = sqrt(mu/(a^3)); % Mean Motion
E = mod(nu2E(anom, e), 2*pi); % Eccentric Anomaly [rad]
M0 = E - e*sin(E); % Initial Mean Anomaly [rad]

% Run Simulink
sim Molniya331

% PQW Orbit
figure, hold on
plot3(r_pqw(:,1),r_pqw(:,2),r_pqw(:,3),'LineWidth',2)
title(sprintf("Orbit of Molniya 3-31 in Perifocal Coordinates"))
xlabel('x [km]'), ylabel('y [km]'), zlabel('z [km]')
grid on, axis equal

% ECI Orbit
figure, hold on
plot3(r_eci(:,1),r_eci(:,2),r_eci(:,3),'LineWidth',2)
title(sprintf("Orbit of Molniya 3-31 in ECI Coordinates"))
xlabel('x [km]'), ylabel('y [km]'), zlabel('z [km]')
earthPlot(1), grid on, axis equal

% Part(b): ECEF Orbit
figure, hold on
plot3(r_ecef(:,1),r_ecef(:,2),r_ecef(:,3),'LineWidth',2)
title(sprintf("Orbit of Molniya 3-31 in ECEF Coordinates"))
xlabel('x [km]'), ylabel('y [km]'), zlabel('z [km]')
earthPlot(1), grid on, axis equal

% Obtain Hourly Tick Marks
for ii = 1:24
    lambdaTick(ii,:) = r_ecef(ii*360,:);
end
plot3(lambdaTick(:,1),lambdaTick(:,2),lambdaTick(:,3),'ro','MarkerFaceColor','r')

% Part(c): Ground Track Plot
figure, hold on
load('topo.mat', 'topo'); % Load and plot MATLAB built-in Earth topography data
topoplot = [topo(:, 181:360), topo(:, 1:180)];
contour(-180:179, -90:89, topoplot, [0, 0], 'black');
lambda1 = lambda(1:113); phi1 = phi(1:113); % Remove Jump Discontinuity
lambda2 = lambda(114:end); phi2 = phi(114:end); % Remove Jump Discontinuity
plot(lambda1,phi1,'b-',lambda2,phi2,'b-')
title('Molniya 3-31 Groundtrack')
grid on, axis equal
xlim([-180, 180]);
ylim([-90, 90]);
xlabel('Longitude [\circ]'), ylabel('Latitude [\circ]');

% Obtain Hourly Tick Marks
for ii = 1:24
    lambdaTick(ii) = lambda(ii*360);
    phiTick(ii) = phi(ii*360);
end
plot(lambdaTick,phiTick,'ro','MarkerFaceColor','r')