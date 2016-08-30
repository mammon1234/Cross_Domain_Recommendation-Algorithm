function[U0,U1,U2,V1,V2]=GRLSI(D1,D2,M,N,N1,N2,Ks,Kc,P)
%group matrix for scalable topic modeling 
%已知条件词汇数M，文档数N，类数p，相应类的文档数Np，共有主题数Ks，特定主题数Kc
%文档集D=M*N,D=[D1,D2],文档集1：D1=M*N1,文档集2：D2=M*N2；文档总数N=N1+N2
%共享topic：U0=M*Ks；特有topic；U1,U2=M*Kc；topic总数：k=Ks+p*Kc
%topic-doc矩阵：V1=(Ks+Kc)*N1,V2=(Ks+Kc)*N2
Cover=0;
Cover1=0;
Kv=Ks+Kc;
flag=1;
%初始化U1~Up,V1~Vp
for p=1:P
    eval(['U',num2str(p),'=','zeros(',num2str(M),',',num2str(Kc),');']);
    eval(['V',num2str(p),'=','rand(',num2str(Kv),',N',num2str(p),');']);
end
while 0<1 
    %更新U0
    [U0]=UPDATEU0(D1,D2,U1,U2,V1,V2,P,M,Ks);    
    for p=1:P
        %更新Up
        eval(['[U',num2str(p),']=','UPDATEUp(D',num2str(p),',U0,V',num2str(p),',Kc,M);']);
        %更新Vp
        eval(['[V',num2str(p),']=','UPDATEVp(D',num2str(p),',U0,U',num2str(p),',M',',N',num2str(p),',Ks,Kc);']);
    end
    %对于收敛约束条件判断
    [Cover1]=MINGRLSI(D1,D2,U0,U1,U2,V1,V2,M,N,N1,N2,Ks,Kc,P)
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
%显示U0
disp('GRLSI');
disp(U0);
for p=1:P
    %显示Up，Vp
    eval(['disp(U',num2str(p),');']);
    eval(['disp(V',num2str(p),');']);
end