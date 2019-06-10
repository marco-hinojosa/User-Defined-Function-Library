function E = KeplerEq(M,e,eps)
% Function solves Kepler's equation M = E-e*sin(E)
% Input - Mean Anomaly M [rad], Eccentricity e, and Epsilon 
% Output - Eccentric anomaly E [rad] 
En  = M;
Ens = En - (En-e*sin(En)- M)/(1 - e*cos(En));
while ( abs(Ens-En) > eps )
	En = Ens;
	Ens = En - (En - e*sin(En) - M)/(1 - e*cos(En));
end
E = Ens;