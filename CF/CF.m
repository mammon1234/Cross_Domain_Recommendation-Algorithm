function[v1,v2,v3,v4,v5,v6]=CF(D1,D2,Tte1,Tte2)

[T1]=matri(D1);
[T2]=matri(D2);
Size1=size(T1);
Size2=size(T2);
M1=Size1(1);N1=Size1(2);
M2=Size2(1);N2=Size2(2);
Data = [[T1 zeros(M1,N2)]; [zeros(M2,N1) T2]];
Size = [M1 N1; M2 N2];
K=20;L=20;T=50;
[Data,Core,U1,U2] = RMGM(Data,Size,K,L,T,M1,N1);
disp('RMGM');
[v1]=MAE(U1,Tte1);disp(v1);
[v2]=MAE(U2,Tte2);disp(v2);

[v3,v4]=CLFM(D1,D2,Tte1,Tte2);
disp('CLFM');
disp(v3);disp(v4);
[v3,v4]=CLFM(D2,D1,Tte2,Tte1);
disp(v3);disp(v4);

%disp('CBT');
%[v6]=CBT(D2,D1,Tte1);
%disp(v6);
%[v5]=CBT(D1,D2,Tte2);
%disp(v5);
