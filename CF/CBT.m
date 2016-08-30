function [V]=CBT(D1,D2,D2te)

[X1]=matri(D1);[X2]=matri(D2);
W1=im2bw(X1(:,:),0);
[X1]=proinitial(X1,W1);

Size1=size(X1);
m1=Size1(1);n1=Size1(2);

Size2=size(X2);
m2=Size2(1);n2=Size2(2);
k=30;l=80;
X1T=X1';
[Idx,Ft]=kmeans(X1T,k);
Ft=Ft+0.2;
[Idx,Gt]=kmeans(X1,l);
Gt=Gt+0.2;
U1=Ft';V1=Gt';
S1=U1'*X1*V1;
T=50;
eclip=0.01;

for t=1:T
    tep11=U1'*X1*V1;
    tep12=U1'*U1*S1*V1'*V1;
    S1=S1.*(tep11./(tep12+eclip));
    
    tep21=X1*V1*S1';
    tep22=U1*U1'*X1*V1*S1';
    U1=U1.*(tep21./(tep22+eclip));
    
    tep31=X1'*U1*S1;
    tep32=V1*V1'*X1'*U1*S1;
    V1=V1.*(tep31./(tep32+eclip));
end

for m=1:m1
    id=find(U1(m,:)==max(U1(m,:)));
    U1(m,:)=zeros(1,k);
    U1(m,id)=1;
end

for n=1:n1
    id=find(V1(n,:)==max(V1(n,:)));
    V1(n,:)=zeros(1,l);
    V1(n,id)=1;
end

T1=ones(m1,1);T2=ones(n1,1);
B=(U1'*X1*V1)./(U1'*T1*T2'*V1+eclip);
W=im2bw(X2(:,:),0);
U2=zeros(m2,k);V2=zeros(n2,l);

for n=1:n2
    Tep=randperm(l);
    V2(n,Tep(1))=1;
end
for t=1:10
    id=1;
    count=0;
    for m=1:m2
        T=B*V2';
        x1=X2(m,:)-T(1,:);
        [count]=Wdiag(x1,W(m,:));
        for p=2:k
            T=B*V2';
            x1=X2(m,:)-T(p,:);
            [var]=Wdiag(x1,W(m,:));
            if var<=count
                count=var;
                id=p;
            end
        end
        U2(m,:)=zeros(1,k);
        U2(m,id)=1;
    end
    
    id=1;
    count=0;
    for n=1:n2
        T=U2*B;
        x2=X2(:,n)-T(:,1);
        [count]=Wdiag(x2',W(:,n));
        for q=2:l
            T=U2*B;
            x2=X2(:,n)-T(:,q);
            [var]=Wdiag(x2',W(:,n));
            if var<=count
                count=var;
                id=p;
            end
        end
        V2(n,:)=zeros(1,l);
        V2(n,id)=1;
    end
end

R=W.*X2+(1-W).*(U2*B*V2');
V=MAE(R,D2te);
disp(V);


