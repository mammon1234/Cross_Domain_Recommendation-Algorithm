function[Cover1]=MING(D1,D2,U0,U1,U2,V1,V2,M,N,N1,N2,Ks,Kc,P)
%加和缓存变量
sum1=0;
for p=1:P
    %求对于Dp（：，n）-【U0，Up】Vp（：，n）的矩阵2范数
    eval(['tep=N',num2str(p)]);
    for n=1:tep
        eval(['tep1=norm((D',num2str(p),'(:,n)-[U0,U',num2str(p),']*V',num2str(p),'(:,n)','),2);']);
        sum1=sum1+(tep1^2);
    end  
end
for ks=1:Ks
    %求U0的1范数
    tep1=norm(U0(:,ks),1);
    sum1=0.01*tep1+sum1;
end
for p=1:P
    for kc=1:Kc
        %求Up的1范数
        eval(['tep1=norm(U',num2str(p),'(:,',num2str(kc),'),1);']);
        sum1=0.01*tep1+sum1;
    end
end
for p=1:P
    eval(['tep=N',num2str(p)]);
    for n=1:tep
    %求Vp（：，n）的2范数
    eval(['tep1=norm(V',num2str(p),'(:,n),2);']);
    sum1=sum1+0.1*(tep1^2);
    end    
end
Cover1=sum1;