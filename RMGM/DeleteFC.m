function[List]=DeleteFC(T)
Size=size(T);
m=Size(1);
n=Size(2);
List=[];
%D=T
%for p=1:m
for p=1:n
    %H=T(p,:);
    H=T(:,p);
    tep=sum(H>0);
    if tep==0
        %D(p,:)=[];
        List=[List,p];
    end
end