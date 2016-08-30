function [S0]=UPDATES0(X1,X2,S0,S1,S2,U1,U2,V10,V11,V20,V21,W1,W2)
ks=1;
%Tep11=U1'*(X1)*V10+U2'*(X2)*V20;
Tep11=U1'*(W1.*X1)*V10+ks*U2'*(W2.*X2)*V20;
%Tep12=U1'*((U1*S0*V10'))*V10+U1'*((U1*S1*V11'))*V10+U2'*((U2*S0*V20'))*V20+U2'*((U2*S2*V21'))*V20;
Tep12=U1'*(W1.*(U1*S0*V10'))*V10+U1'*(W1.*(U1*S1*V11'))*V10+U2'*(W2.*(U2*S0*V20'))*V20+U2'*(W2.*(U2*S2*V21'))*V20;

Tep12=Tep12+0.00001;

%k=(abs(Tep11./Tep12)+Tep11./Tep12)/2;
S0=S0.*sqrt(Tep11./Tep12);