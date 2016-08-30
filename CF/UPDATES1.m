function [S1]=UPDATES1(X1,S0,S1,U1,V10,V11,W1)
Tep21=U1'*(W1.*X1)*V11;
%Tep21=U1'*(X1)*V11;
Tep22=U1'*(W1.*(U1*S0*V10'))*V11+U1'*(W1.*(U1*S1*V11'))*V11;
%Tep22=U1'*((U1*S0*V10'))*V11+U1'*((U1*S1*V11'))*V11;
Tep22=Tep22+0.00001;
%k=(abs(Tep21./Tep22)+Tep21./Tep22)/2;
S1=S1.*sqrt(Tep21./Tep22);