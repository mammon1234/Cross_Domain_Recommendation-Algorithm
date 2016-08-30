function[E]=PCC(D1,Tte1)
[T1]=matri(D1);
W1=im2bw(T1(:,:),0);
Size1=size(T1);
M1=Size1(1);N1=Size1(2);
Raverage=sum(T1,2)./sum(W1,2);
Size2=size(Raverage);
R1=T1;
corr=zeros(M1,M1);
for u = 1:M1
    K=repmat(W1(u,:),M1,1);
    L=K.*W1;            
    for v=1:M1
        tep_numerator=sum((T1(u,:).*L(v,:)-Raverage(u,1)*L(v,:)).*(T1(v,:).*L(v,:)-Raverage(v,1)*L(v,:)),2);
        tep_denominator=(sum((T1(u,:).*L(v,:)-Raverage(u,1)*L(v,:)).^2,2)*sum((T1(v,:).*L(v,:)-Raverage(v,1)*L(v,:)).^2,2))^0.5;
        if tep_denominator~=0
            corr(v,u)=tep_numerator/tep_denominator;
        else
            corr(v,u)=0;
        end
    end
   Wcorr=im2bw(corr(:,:),0);
   tep_corr=corr.*Wcorr;
   %Wm=ones(1,N1)-W1(u,:);
   %L(u,:)=L(u,:)*0;
   %disp(sum(L(u,:),2));
    for n=1:N1
        if W1(u,n)==0
            %     if Wm(1,n)==1
            sum_numerator=0;
            sum_denominator=0;
            for m=1:M1
                if W1(m,n)~=0&&m~=u
                    sum_numerator=sum_numerator+(T1(m,n)-Raverage(m,1))*tep_corr(m,u);              
                    sum_denominator=sum_denominator+tep_corr(m,u);
                end
            end
            if sum_denominator~=0
                R1(u,n)=Raverage(u)+sum_numerator/sum_denominator;
            else
                R1(u,n)=Raverage(u);
            end
        end
    end         
end
[E]=MAE(R1,Tte1);
disp('PCC');
disp(E);