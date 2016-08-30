function[U0]=UPDATEU0(D1,D2,U1,U2,V1,V2,P,M,Ks)
%�������߲���coordinate descent with softthresholding ����
S0=0;
U0tep=0;
R0=zeros(M,Ks);
U0=zeros(M,Ks);
%��Vp����U0��Ӧ������S0
for p=1:P 
    eval(['Hp=V',num2str(p),'(1,:);']);
    tepS0=Hp*Hp';
    S0=tepS0+S0
end
%��R0
for p=1:P
    eval(['tepR0=','D',num2str(p),'*V',num2str(p),'(1,:)''','-U',num2str(p),'*V',num2str(p),'(2,:)','*V',num2str(p),'(1,:)'';']);
    R0=tepR0+R0;
end

for m=1:M
    u0=0;
    while 0<1
        for k=1:Ks
            %��ʽ���м����Xmk
            Xmk=R0(m,:);
            %�����U0�е��еĽ��
            u0=((abs(Xmk)-0.005)*sign(Xmk))/S0;
        end
        %���������ж�
        if abs(u0-U0tep)<0.01
            break;
        end
        U0tep=u0;
    end
    %���������U0��ÿ��
    U0(m,:)=u0;
end