function [v3,v4]=CLFM(D1,D2,Xt1,Xt2)
%由数据集生成矩阵
[X1]=matri(D1);
[X2]=matri(D2);
Size2=size(X2);
M2=Size2(1);N2=Size2(2);

%求权重
W1=im2bw(X1(:,:),0);
W2=im2bw(X2(:,:),0);

K1=30;K2=30;L1=80;L2=80;
[X1]=proinitial2(X1,W1,K1,L1,20);
[X2]=proinitial2(X2,W2,K2,L2,20);

%共享
T=40;
%初始化
XT=X1';
[Idx,F]=kmeans(XT,K1);
F=F+0.2;
[Idx,G]=kmeans(X1,L1);
G=G+0.2;

U1=F';[U1]=regularize(U1);
U2=rand(M2,K2);
V1=G';[V1]=regularize(V1);
V2=rand(N2,L2);
[V2]=regularize(V2);
V10=V1(:,1:T);V11=V1(:,(T+1):L1);
V20=V2(:,1:T);V21=V2(:,(T+1):L2);

S=U1'*X1*V1;
S0=S(:,1:T);
S1=S(:,(T+1):L1);
S2=rand(K2,(L2-T))*K2;

for k=1:50
    [S0]=UPDATES0(X1,X2,S0,S1,S2,U1,U2,V10,V11,V20,V21,W1,W2);
    [S1]=UPDATES1(X1,S0,S1,U1,V10,V11,W1);    [S2]=UPDATES2(X2,S0,S2,U2,V20,V21,W2);
    [U1]=UPDATEU1(X1,S0,S1,U1,V10,V11,W1);    [U2]=UPDATEU2(X2,S0,S2,U2,V20,V21,W2);
    [V10,V11]=UPDATEV1(X1,S0,S1,U1,V10,V11,T,L1,W1);    [V20,V21]=UPDATEV2(X2,S0,S2,U2,V20,V21,T,L2,W2);
end

R1=W1.*X1+(1-W1).*(U1*[S0,S1]*[V10,V11]');
R2=W2.*X2+(1-W2).*(U2*[S0,S2]*[V20,V21]');

[v3]=MAE(R1,Xt1);
disp(v3);
[v4]=MAE(R2,Xt2);
disp(v4);

