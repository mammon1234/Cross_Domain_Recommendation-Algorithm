function [V10,V11]=UPDATEV1(X1,S0,S1,U1,V10,V11,T,L1,W1)
%Tep11=[S0,S1]'*U1'*(W1.*X1);
Tep11=[S0,S1]'*U1'*(X1);
%Tep12=[S0,S1]'*U1'*(W1.*(U1*[S0,S1]*[V10,V11]'));
Tep12=[S0,S1]'*U1'*((U1*[S0,S1]*[V10,V11]'));

Tep12=Tep12+0.00001;
%k=(abs(Tep11./Tep12)+Tep11./Tep12)/2;
V1=[V10,V11]'.*sqrt(Tep11./Tep12);

v=V1';
[v]=regularize(v);
%[v]=regularize2(v);
V10=v(:,1:T);
V11=v(:,(T+1):L1);