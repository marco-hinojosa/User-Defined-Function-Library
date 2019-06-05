function E = keplerEq(M,e,eps)
% Kepler's Equation Solver: M = E - e*sin(E)
%
% Inputs:
%	M - Mean Anomaly [rad]
%	e - Eccentricity
%	eps - Error Tolerance
%
% Outputs:
%	E - Eccentric Anomaly [rad]

En = M;
Ens = En - (En-e*sin(En)- M)/(1 - e*cos(En));
while abs(Ens-En)>eps
	En = Ens;
	Ens = En - (En - e*sin(En) - M)/(1 - e*cos(En));
end
E = Ens;
