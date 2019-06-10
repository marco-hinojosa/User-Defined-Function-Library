%% AA279A HW 2
% Marco Hinojosa
% 06181747
close all,clear all,clc

%% Problem 2
rp = 2;
e = [0.7 0.0 1.9 1.0];
x = [];
y = [];

for ii = 1:length(e)  
    if e(ii) < 1 % Circular or Elliptical Orbit
        nu = 0:1:360; % Define Valid True Anomaly
        a = rp/(1-e(ii)); % Semimajor Axis
        p = a*(1 - e(ii)^2); % Semilatus Rectum
        r = p./(1 + e(ii)*cosd(nu)); % Orbit with Polar Coordinates
        x = [x; r.*cosd(nu)]; % Convert to x-y Cartesian
        y = [y; r.*sind(nu)]; % Convert to x-y Cartesian
        rp_line = [linspace(0,rp,100); zeros(1,100)];
        a_line = [linspace(rp-2*a,rp,100); zeros(1,100)];
        p_line = [zeros(1,100); linspace(-p,0,50) linspace(0,p,50)];
        figure
        plot(x(ii,:),y(ii,:))
        hold on, plot(a_line(1,:),a_line(2,:),'k--','LineWidth',1.25)
        plot(p_line(1,:),p_line(2,:),'k--','LineWidth',1.25)
        plot(rp_line(1,:),rp_line(2,:),'r-','LineWidth',2)
        axis equal, title(['Orbit for e = ', num2str(e(ii))])
        xlabel('x [DU]'),ylabel('y [DU]')
    elseif e(ii) == 1 % Parabolic Orbit
        nu = 0:1:360; % Define Valid True Anomaly
        a = rp/(1-e(ii)); % Semimajor Axis
        p = rp*(1 + e(ii)*cos(0)); % Semilatus Rectum
        r = p./(1 + e(ii)*cosd(nu)); % Orbit with Polar Coordinates
        x = [x; r.*cosd(nu)]; % Convert to x-y Cartesian
        y = [y; r.*sind(nu)]; % Convert to x-y Cartesian
        rp_line = [linspace(0,rp,100); zeros(1,100)];
        a_line = [linspace(rp-2*a,rp,100); zeros(1,100)];
        p_line = [zeros(1,100); linspace(-p,0,50) linspace(0,p,50)];
        figure
        plot(x(ii,:),y(ii,:))
        hold on, plot(a_line(1,:),a_line(2,:),'k--','LineWidth',1.25)
        plot(p_line(1,:),p_line(2,:),'k--','LineWidth',1.25)
        plot(rp_line(1,:),rp_line(2,:),'r-','LineWidth',2)
        axis([-50 10 -30 30]), title(['Orbit for e = ', num2str(e(ii))])
        xlabel('x [DU]'),ylabel('y [DU]')
    elseif e(ii) > 1 % Hyperbolic Orbit
        a = rp/(1-e(ii)); % Semimajor Axis
        p = a*(1 - e(ii)^2); % Semilatus Rectum
        delta = 2*asind(1/e(ii)); % Define Turning Angle 
        nu_hyp = -floor(delta/2 + 90):1:floor(delta/2 + 90); % Define Valid True Anomaly
        r = p./(1 + e(ii)*cosd(nu_hyp)); % Orbit with Polar Coordinates
        x = [x; r.*cosd(nu_hyp) zeros(1,361-length(r))]; % Convert to x-y Cartesian
        y = [y; r.*sind(nu_hyp) zeros(1,361-length(r))]; % Convert to x-y Cartesian
        xs = linspace(-20,20,1000);
        asymptote1 = tand(delta/2 + 90)*(xs+2*a); % Generate Asymptotes
        asymptote2 = -tand(delta/2 + 90)*(xs+2*a); % Generate Asymptotes
        rp_line = [linspace(0,rp,100); zeros(1,100)];
        a_line = [linspace(rp-2*a,rp,100); zeros(1,100)];
        p_line = [zeros(1,100); linspace(-p,0,50) linspace(0,p,50)];
        figure
        plot(x(ii,1:length(r)),y(ii,1:length(r)))
        hold on, plot(xs,asymptote1,'m--',xs,asymptote2,'m--')
        plot(a_line(1,:),a_line(2,:),'k--','LineWidth',1.25)
        plot(p_line(1,:),p_line(2,:),'k--','LineWidth',1.25)
        plot(rp_line(1,:),rp_line(2,:),'r-','LineWidth',2)
        axis([-20 20 -30 30]), title(['Orbit for e = ', num2str(e(ii))])
        xlabel('x [DU]'),ylabel('y [DU]')
    end
end

figure, hold on
for jj = 1:length(e)
    if e(jj) > 1
        plot(x(jj,1:length(nu_hyp)),y(jj,1:length(nu_hyp)))
    else
        plot(x(jj,:),y(jj,:))
    end
end
axis([-15 10 -15 15])
title('All Orbits for Comparison')
xlabel('x [DU]'),ylabel('y [DU]')
legend('e = 0.7','e = 0.0','e = 1.9','e = 1.0')