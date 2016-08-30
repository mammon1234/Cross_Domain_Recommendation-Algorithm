function[p1,p2]=Squre(D1,D2,T1)
Size1=size(T1);
num1=Size1(1);
count=0;
for p=1:num1
    u=T1(p,1);
    v=T1(p,2);
    rt=T1(p,3);
    r=D1(u,v);
    count=count+abs(r-rt)^2;
end
value1=count;
count=0;
for p=1:num1
    u=T1(p,1);
    v=T1(p,2);
    rt=T1(p,3);
    r=D2(u,v);
    count=count+abs(r-rt)^2;
end
value2=count;
p2=value1/(value1+value2);
p1=1-p2;
    
