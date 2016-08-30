function[Up]=UPDATEUp(Dp,U0,Vp,Kc,M)
Sp=0;
Uptep=0;
Hp=Vp(1,:);
Wp=Vp(2,:);
%用Vp中与Up对应部分求Sp
Sp=Wp*Wp';
Rp=zeros(M,Kc);
%求Rp
Rp=Dp*Wp'-U0*Hp*Wp';
for m=1:M
    up=0;
    while 0<1
        for k=1:Kc
            %算式的中间变量Xmk
            Xmk=Rp(m,:);
            %计算出Up中单行的结果
            up=((abs(Xmk)-0.005)*sign(Xmk))/Sp;
        end
        %进行收敛判定
        if abs(up-Uptep)<0.01
            break;
        end
        Uptep=up;
    end
    %将结果赋予U0的每行
    Up(m,:)=up;
end