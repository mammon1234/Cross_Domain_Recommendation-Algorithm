function[v1,v2,v3,v4,v5,v6,Core,Core2,Core3]=DRMGM(D1,D2,Tte1,Tte2)
[T1]=matri(D1);
[T2]=matri(D2);
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
[v2]=MAE(U2,Tte2);disp(v2);

disp('SRMGM');
[Data2,Core2] = SRMGM(T1,K,L,T,PrrU1,PrrI1,CndR1);
[v3]=MAE(Data2,Tte1);disp(v3);
[Data3,Core3] = SRMGM(T2,K,L,T,PrrU2,PrrI2,CndR2);
[v4]=MAE(Data3,Tte2);disp(v4);

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
disp(v5);disp(v6);
