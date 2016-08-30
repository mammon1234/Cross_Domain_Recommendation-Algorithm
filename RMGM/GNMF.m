function[U0,U1,U2,V1,V2]=GNMF(D1,D2,M,N,N1,N2,Ks,Kc,P)
Cover=0;
Cover1=0;
Kv=Ks+Kc;
flag=1;
U0=rand(M,Kc);
for p=1:P
    eval(['U',num2str(p),'=','rand(',num2str(M),',',num2str(Kc),');']);
    eval(['V',num2str(p),'=','rand(',num2str(Kv),',N',num2str(p),');']);
end
while 0<1
     %更新U0
    [U0]=UPDATENMFU0(D1,D2,U0,U1,U2,V1,V2,P,M,Ks);
    disp(U0);  
    for p=1:P
        %更新Up
        eval(['[U',num2str(p),']=','UPDATENMFUp(D',num2str(p),',U0,U',num2str(p),',V',num2str(p),',Kc);']);
        %更新Vp
        eval(['[V',num2str(p),']=','UPDATENMFVp(D',num2str(p),',U0,U',num2str(p),',V',num2str(p),');']);
    end
    %对于收敛约束条件判断
    [Cover1]=MINGNMF(D1,D2,U0,U1,U2,V1,V2,N1,N2,P)
    if (flag>=2)&&((Cover-Cover1)<0)
        break;
    end
    flag=flag+1;
    U0tep=U0;
    U1tep=U1;
    U2tep=U2;
    V1tep=V1;
    V2tep=V2;
    Cover=Cover1;
end
U0=U0tep;
U1=U1tep;
U2=U2tep;
V1=V1tep;
V2=V2tep;
disp('GNMF');
disp(U0);
for p=1:P
    %显示Up，Vp
    eval(['disp(U',num2str(p),');']);
    eval(['disp(V',num2str(p),');']);
end
    