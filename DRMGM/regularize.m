function [R]=regularize(R)
Size=size(R);
m=Size(1);
n=Size(2);
count=0;
for i=1:m
    for j=1:n
        count=count+R(i,j);
    end
    for j=1:n
        R(i,j)=R(i,j)/count;
    end
    count=0;
end
