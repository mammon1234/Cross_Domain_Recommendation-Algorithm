function[v1,v2,T1,U1,Data2,T2,U2,Data3,W1,W2]=DRMGM(D1,D2,Tte1,Tte2)
[T1]=matri(D1);
[T2]=matri(D2);
W1=im2bw(T1(:,:),0);
W2=im2bw(T2(:,:),0);
Size1=size(T1);
Size2=size(T2);
M1=Size1(1);N1=Size1(2);
M2=Size2(1);N2=Size2(2);
Data = [[T1 zeros(M1,N2)]; [zeros(M2,N1) T2]];
Size = [M1 N1; M2 N2];
K=20;L=20;T=50;
[PrrU1,PrrI1,CndR1]=initial(T1,K,L);
[PrrU2,PrrI2,CndR2]=initial(T2,K,L);
[Data,Core,U1,U2] = RMGM(Data,Size,K,L,T,M1,N1,PrrU1,PrrI1,CndR1);
disp('RMGM');
[v1]=MAE(U1,Tte1);disp(v1);
%[v1]=MAE(U1,D1);disp(v1);
[v2]=MAE(U2,Tte2);disp(v2);
%[v2]=MAE(U2,D2);disp(v2);

disp('SRMGM');
[Data2,Core2] = SRMGM(T1,K,L,T,PrrU1,PrrI1,CndR1);
[v3]=MAE(Data2,Tte1);disp(v3);
%[v3]=MAE(Data2,D1);disp(v3);
[Data3,Core3] = SRMGM(T2,K,L,T,PrrU2,PrrI2,CndR2);
[v4]=MAE(Data3,Tte2);disp(v4);
%[v4]=MAE(Data3,D2);disp(v4);

disp('DRMGM');
v5=5;v6=5;
for k=0:10
    a=k/10;
    Data_1=a*U1+(1-a)*Data2;
    Data_2=a*U2+(1-a)*Data3;
    [V1]=MAE(Data_1,Tte1);
    if v5>V1
        v5=V1;
        k1=a;
    end
    [V2]=MAE(Data_2,Tte2);
    if v6>V2
        v6=V2;
        k2=a;
    end
end
disp(v5);disp(k1);
disp(v6);disp(k2);

[p1,p2]=Squre(U1,Data2,D1);
disp('p1p2');

Data_1=p1*U1+p2*Data2;
[V1]=MAE(Data_1,Tte1);
disp(V1);
disp(p1);
[p1,p2]=Squre(U2,Data3,D2);
disp('p1p2');

Data_2=p1*U2+p2*Data3;
[V2]=MAE(Data_2,Tte2);
disp(V2);
disp(p1);

disp('SGD');
[alpha,D]=SGD(T1,U1,Data2,W1);

[V1]=MAE(D,Tte1);
disp(V1);
disp(alpha);

[alpha,D]=SGD(T2,U2,Data3,W2);

[V2]=MAE(D,Tte2);
disp(V2);
disp(alpha);




