function[T]=DeleteC(list,T)
Size=size(list);
n=Size(2);
for p=1:n
    num=list(1,n+1-p);
    T(:,num)=[];
end