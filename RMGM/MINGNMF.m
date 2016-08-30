function[Cover1]=MINGNMF(D1,D2,U0,U1,U2,V1,V2,N1,N2,P)
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
Cover1=sum1;