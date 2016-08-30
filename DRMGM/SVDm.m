function[Rating,value]=SVDm(Tr,Te)
Sizetr=size(Tr);
num=Sizetr(1);
u1train=matri(Tr);
Size=size(u1train);
usernum=Size(1);
itemnum=Size(2);

iterator=240;
Gama=0.001;%随机梯度下降的速率
R=20;%分解的矩阵秩
Namada=0.04;%系数
err=zeros(usernum,itemnum);
Q=0.1*rand(usernum,R)/sqrt(R);
P=0.1*rand(R,itemnum)/sqrt(R);
UBiase=zeros(usernum,itemnum);
IBiase=zeros(usernum,itemnum);
Uaverage=sum(sum(u1train))/num;

for i=1:iterator
    Rating=Q*P+UBiase+IBiase+Uaverage;
    for k=1:num
        raw=Tr(k,1);
        col=Tr(k,2);
        score=Tr(k,3);
        err(raw,col)=score-Rating(raw,col);%943*1682      
    end
    Temp=Q;
    Q=Q+Gama*(err*P'-Namada*Q);%943*20
    P=P+Gama*(Temp'*err-Namada*P);%20*1682
    UBiase=UBiase+Gama*(err-Namada*UBiase);
    IBiase=IBiase+Gama*(err-Namada*IBiase);
   for raw=1:size(Rating,1)
        for col=1:size(Rating,2)
            if Rating(raw,col)<0
               Rating(raw,col)=0;
            end
            if Rating(raw,col)>5
                Rating(raw,col)=5;
            end
        end
   end
 [value]=MAE(Rating,Te);
end;
 disp(value);
