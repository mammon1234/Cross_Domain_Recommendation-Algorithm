function [S2]=UPDATES2(X2,S0,S2,U2,V20,V21,W2)
ks=1;
Tep31=U2'*(W2.*X2)*V21;
%Tep31=U2'*(X2)*V21;
Tep32=U2'*(W2.*(U2*S0*V20'))*V21+U2'*(W2.*(U2*S2*V21'))*V21;
%Tep32=U2'*((U2*S0*V20'))*V21+U2'*((U2*S2*V21'))*V21;

Tep32=Tep32+0.00001;
%k=(abs(Tep31./Tep32)+Tep31./Tep32)/2;
S2=ks*S2.*sqrt(Tep31./Tep32);