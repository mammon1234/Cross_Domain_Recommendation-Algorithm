function[value]=MAE(D,T)
Size=size(T);
num=Size(1);
count=0;
for p=1:num
    u=T(p,1);
    v=T(p,2);
    rt=T(p,3);
    r=D(u,v);
    count=count+abs(r-rt);
end
value=count/num;
    
