function[U0]=UPDATEU0(D1,D2,U1,U2,V1,V2,P,M,Ks)
%这里作者采用coordinate descent with softthresholding 方法
S0=0;
U0tep=0;
R0=zeros(M,Ks);
U0=zeros(M,Ks);
%用Vp中与U0对应部分求S0
for p=1:P 
    eval(['Hp=V',num2str(p),'(1,:);']);
    tepS0=Hp*Hp';
    S0=tepS0+S0
end
%求R0
for p=1:P
    eval(['tepR0=','D',num2str(p),'*V',num2str(p),'(1,:)''','-U',num2str(p),'*V',num2str(p),'(2,:)','*V',num2str(p),'(1,:)'';']);
    R0=tepR0+R0;
end

for m=1:M
    u0=0;
    while 0<1
        for k=1:Ks
            %算式的中间变量Xmk
            Xmk=R0(m,:);
            %计算出U0中单行的结果
            u0=((abs(Xmk)-0.005)*sign(Xmk))/S0;
        end
        %进行收敛判定
        if abs(u0-U0tep)<0.01
            break;
        end
        U0tep=u0;
    end
    %将结果赋予U0的每行
    U0(m,:)=u0;
end