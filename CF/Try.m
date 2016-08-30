function [V1,V2,k1,k2]=Try(U1,U2,Data2,Data3,Tte1,Tte2)
V1=1;
V2=1;
for k=0:10
    a=k/10;
    Data_1=a*U1+(1-a)*Data2;
    Data_2=a*U2+(1-a)*Data3;
    disp(k);
    [v1]=MAE(Data_1,Tte1);
    if V1>v1
        V1=v1;
        k1=a;
    end
    [v2]=MAE(Data_2,Tte2);
    if V2>v2
        V2=v2;
        k2=a;
    end
end