function r_enu = ecef2enu(lam_gs, phi_gs, r_ecef)
% ecef2enu Converts ECEF position to ENU position
%
% Note : This function assumes an elliptical Earth
%
% Inputs :
% lam_gs - Ground station Geodetic longitude [ rad ]
% phi_gs - Ground station Geodetic latitude [ rad ]
% r_ecef - Satellite ECEF position vector [km]
%
% Outputs :
% r_enu - Satellite ENU position vector [km]

% Earth parameters
r_E = 6378.1;
e_E = 0.0818;

% Compute the satellite position wrt the ground station in ECEF
N = r_E/sqrt(1 - e_E^2*(sin(phi_gs)^2));
r_GS_ecef = [N*cos(phi_gs)*cos(lam_gs);
            N*cos(phi_gs)*sin(lam_gs);
            N*(1 - e_E)*sin(phi_gs)];
r_sat_GS = r_ecef - r_GS_ecef;

% Develop the ECEF to ENU rotation matrix
E = [-sin(lam_gs);
    cos(lam_gs);
    0];
N = [-sin(phi_gs)*cos(lam_gs);
    -sin(phi_gs)*sin(lam_gs);
    cos(phi_gs)];
U = [cos(phi_gs)*cos(lam_gs);
    cos(phi_gs)*sin(lam_gs);
    sin(phi_gs)];

Recef2enu = [E, N, U].';

% Rotate the position vector into ENU coordinates
r_enu = Recef2enu*r_sat_GS;

end