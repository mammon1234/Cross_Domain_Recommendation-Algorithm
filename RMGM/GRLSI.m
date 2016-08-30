function[U0,U1,U2,V1,V2]=GRLSI(D1,D2,M,N,N1,N2,Ks,Kc,P)
%group matrix for scalable topic modeling 
%��֪�����ʻ���M���ĵ���N������p����Ӧ����ĵ���Np������������Ks���ض�������Kc
%�ĵ���D=M*N,D=[D1,D2],�ĵ���1��D1=M*N1,�ĵ���2��D2=M*N2���ĵ�����N=N1+N2
%����topic��U0=M*Ks������topic��U1,U2=M*Kc��topic������k=Ks+p*Kc
%topic-doc����V1=(Ks+Kc)*N1,V2=(Ks+Kc)*N2
Cover=0;
Cover1=0;
Kv=Ks+Kc;
flag=1;
%��ʼ��U1~Up,V1~Vp
for p=1:P
    eval(['U',num2str(p),'=','zeros(',num2str(M),',',num2str(Kc),');']);
    eval(['V',num2str(p),'=','rand(',num2str(Kv),',N',num2str(p),');']);
end
while 0<1 
    %����U0
    [U0]=UPDATEU0(D1,D2,U1,U2,V1,V2,P,M,Ks);    
    for p=1:P
        %����Up
        eval(['[U',num2str(p),']=','UPDATEUp(D',num2str(p),',U0,V',num2str(p),',Kc,M);']);
        %����Vp
        eval(['[V',num2str(p),']=','UPDATEVp(D',num2str(p),',U0,U',num2str(p),',M',',N',num2str(p),',Ks,Kc);']);
    end
    %��������Լ�������ж�
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
%��ʾU0
disp('GRLSI');
disp(U0);
for p=1:P
    %��ʾUp��Vp
    eval(['disp(U',num2str(p),');']);
    eval(['disp(V',num2str(p),');']);
end