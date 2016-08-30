function[]=Demo()
M=9,N=6;
N1=3,N2=3;
Ks=1,Kc=1;
P=2;
D1=[1 0 0;
    0 1 0;
    0 0 1;
    0 0 1;
    0 1 0;
    0 0 1;
    0 0 0;
    0 0 0;
    0 0 0];
D2=[0 1 0;
    1 0 0;
    1 0 0;
    0 0 0; 
    0 0 0;
    0 0 0;
    0 1 0;
    0 0 1;
    0 1 0];
[U0,U1,U2,V1,V2]=GRLSI(D1,D2,M,N,N1,N2,Ks,Kc,P);
D1new=[U0,U1]*V1;
D2new=[U0,U2]*V2;
disp(D1);
disp(D1new);
disp(D2);
disp(D2new);
%[U0,U1,U2,V1,V2]=GNMF(D1,D2,M,N,N1,N2,Ks,Kc,P);


