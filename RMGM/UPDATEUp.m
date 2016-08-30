function[Up]=UPDATEUp(Dp,U0,Vp,Kc,M)
Sp=0;
Uptep=0;
Hp=Vp(1,:);
Wp=Vp(2,:);
%��Vp����Up��Ӧ������Sp
Sp=Wp*Wp';
Rp=zeros(M,Kc);
%��Rp
Rp=Dp*Wp'-U0*Hp*Wp';
for m=1:M
    up=0;
    while 0<1
        for k=1:Kc
            %��ʽ���м����Xmk
            Xmk=Rp(m,:);
            %�����Up�е��еĽ��
            up=((abs(Xmk)-0.005)*sign(Xmk))/Sp;
        end
        %���������ж�
        if abs(up-Uptep)<0.01
            break;
        end
        Uptep=up;
    end
    %���������U0��ÿ��
    Up(m,:)=up;
end