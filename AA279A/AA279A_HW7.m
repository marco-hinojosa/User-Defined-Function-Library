%% AA279A Homework 7
% Marco Hinojosa
% 06181747
clc,clear,close all

%% Problem 2
v = zeros(3,1000);
v(2,:) = linspace(1,20,1000);
r = [6578; 0; 0];

for ii = 1:length(v)
    D(:,ii) = drag(r,v(:,ii));
end

figure,
plot(v(2,:),vecnorm(D))

%% Problem 3
R_E = 6378.1; mu_E = 3.986e5;
r0 = linspace(R_E + 100, R_E + 50000,1000);

% Acceleration due to Earth
f_gE = mu_E./r0.^2;

% Acceleration due to Sun
mu_S = 1.327e11;
a_S = 149598023; % Semi-major axis of Earth's Heliocentric Orbit
f_gS = mu_S.*(1./((a_S - r0).^2) - 1/(a_S^2));

% Acceleration due to Moon
mu_M = 4902.799;
a_M = 384400; % Semi-major axis of Moon's Orbit about Earth
f_gM = mu_M.*(1./((a_M - r0).^2) - 1/(a_M^2));

% Acceleration due to Jupiter
mu_J = 1.268e8;
a_J = 778298361; % Semi-major axis of Jupiter's Heliocentric Orbit
f_gJ = mu_J.*(1./((abs(a_J - a_S) - r0).^2) - 1/(abs(a_J-a_S)^2));

% Acceleration due to J2
J2 = 1.0826e-3; u = 0;

f_J2 = 3*mu_E*J2*(R_E^2)./(2.*(r0.^4));

% Acceleration due to Drag
v0 = 7.7843; % [km/s]

for ii = 1:length(r0)
    f_D(ii) = norm(drag([r0(ii);0;0],[0;v0;0]));
end

% Acceleration due to SRP
C_SRP = 0.7;
p_SRP = 4.57; % [N/km^2]
M = 1500; % [kg]               
A = 20e-6; % [km^2]

f_SRP = (p_SRP*C_SRP*A/M)*ones(length(r0)); % [m/s^2]
f_SRP = f_SRP*1e-3; % [km/s^2]

% Plot Results
figure,
loglog(r0,f_gE,'r-',r0,f_gS,'y-',r0,f_gM,'g-',r0,f_gJ,'b-',r0,f_J2,'m-',r0,f_D,'k-',r0,f_SRP,'c-','Linewidth',1.5)
title('Perturbing Force Accelerations vs. Orbital Radius')
xlabel('Orbit Radius (km)'),ylabel('Acceleration (km/s^2)')
legend('Earth','Sun','Moon','Jupiter','J_2','Drag','SRP','Location','SouthEast')
axis([5000 75000 1e-25 1e-1]), grid on
