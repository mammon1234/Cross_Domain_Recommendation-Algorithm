function [V20,V21]=UPDATEV2(X2,S0,S2,U2,V20,V21,T,L2,W2)
%Tep31=[S0,S2]'*U2'*(W2.*X2);
Tep31=[S0,S2]'*U2'*(X2);
%Tep32=[S0,S2]'*U2'*(W2.*(U2*[S0,S2]*[V20,V21]'));
Tep32=[S0,S2]'*U2'*((U2*[S0,S2]*[V20,V21]'));

Tep32=Tep32+0.00001;
%k=(abs(Tep31./Tep32)+Tep31./Tep32)/2;

V2=[V20,V21]'.*sqrt(Tep31./Tep32);
v=V2';
[v]=regularize(v);
%[v]=regularize2(v);
V20=v(:,1:T);
V21=v(:,(T+1):L2);