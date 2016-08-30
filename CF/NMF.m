function [value]=NMF(Dtr,Dte)      
r=50;
[D]=matri(Dtr);
sizeD=size(D);

n=sizeD(1);
m=sizeD(2);
epsilon= 0.001;
W=abs(randn(n,r));

H=abs(randn(r,m));

for iterate=1:100   
    WD=W'*D;
    WWH=W'*W*H;
    for a = 1:r
        for u=1:m
            H(a,u)=H(a,u)*WD(a,u)/(WWH(a,u) + epsilon);
        end
    end  
    DH=D*H';
    WHH=W*H*H';
    for i = 1:n
        for a=1:r
            W(i,a)=W(i,a)*DH(i,a)/(WHH(i,a)+epsilon);
        end
    end
end
D1=W*H;
[value]=MAE(D1,Dte);
disp(value);