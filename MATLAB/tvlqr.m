function [K,S] = tvlqr(A,B,Q,R,S)
% Time-Varying Linear-Quadratic Regulator for Continuous Cost Function.
%
% Inputs:
%       A - State Matrix
%       B - Input Matrix
%       Q - State Cost
%       R - Control Cost
%       S - "Final" State Cost
%
% Outputs:
%       K - TVLQR Gains
%       S - Updated "Final" State Cost (Backwards Integration)

K = inv(R + B'*S*B)*B'*S*A;
S = Q + K'*R*K + (A - B*K)'*S*(A - B*K);
