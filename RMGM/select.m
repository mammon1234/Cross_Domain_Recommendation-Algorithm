function [Mtr,Mte]=select(M)
Size=size(M);
m1=Size(1);
n1=Size(2);
Mtr=zeros(m1,n1);
Mte=zeros(m1,n1);
K=5;
for p=1:m1
    num=sum(M(p,:)>0);
    P=zeros(num,2);
    S=randperm(num);
    g=1;
    for l=1:n1
        if M(p,l)~=0
            P(g,1)=l;
            P(g,2)=M(p,l);
            g=g+1;
        end
    end
    Pt=P(:,2);
    Pt(S(1:K))=0;
    P(:,2)=Pt;
    for x=1:num
        l=P(x,1);
        Mte(p,l)=P(x,2);
    end
end
Mtr=M-Mte;
        