function [U1]=UPDATEU1(X1,S0,S1,U1,V10,V11,W1)
%Tep11=(W1.*X1)*(S0*V10'+S1*V11')';
Tep11=(X1)*(S0*V10'+S1*V11')';
%Tep12=(W1.*(U1*(S0*V10'+S1*V11')))*(S0*V10'+S1*V11')';
Tep12=((U1*(S0*V10'+S1*V11')))*(S0*V10'+S1*V11')';

Tep12=Tep12+0.00001;
%k=(abs(Tep11./Tep12)+Tep11./Tep12)/2;
U1=U1.*sqrt(Tep11./Tep12);
[U1]=regularize(U1);
%[U1]=regularize2(U1);