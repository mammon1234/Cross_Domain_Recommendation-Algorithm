function [U2]=UPDATEU2(X2,S0,S2,U2,V20,V21,W2)
%Tep21=(W2.*X2)*(S0*V20'+S2*V21')';
Tep21=(X2)*(S0*V20'+S2*V21')';
%Tep22=(W2.*(U2*(S0*V20'+S2*V21')))*(S0*V20'+S2*V21')';
Tep22=((U2*(S0*V20'+S2*V21')))*(S0*V20'+S2*V21')';

Tep22=Tep22+0.00001;
%k=(abs(Tep21./Tep22)+Tep21./Tep22)/2;
U2=U2.*sqrt(Tep21./Tep22);
[U2]=regularize(U2);
%[U2]=regularize2(U2);