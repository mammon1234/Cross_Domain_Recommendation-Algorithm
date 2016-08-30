function[D,error]=SVD(Tr,Te)
factornum=20;
learnRate=0.01;
regularization=0.05;
T=matri(Tr);
W=im2bw(T(:,:),0);
Size=size(T);
Sizetr=size(Tr);
trnum=Sizetr(1);
count=sum(Tr,1);
average=count(1,3)/trnum;
usernum=Size(1);
itemnum=Size(2);
bu=zeros(1,usernum);
bi=zeros(1,itemnum);
temp=factornum^0.5;
pu=0.1*rand(usernum,factornum)/temp;
qi=0.1*rand(itemnum,factornum)/temp;
premae=100000;
for step=1:100
    for k=1:trnum
        uid=Tr(k,1);
        iid=Tr(k,2);
        score=Tr(k,3);
        pscore=average+bu(1,uid)+bi(1,iid)+pu(uid,:)*qi(iid,:)';
        if pscore<1
            pscore=1;
        end
        if pscore>5
            pscore=5;
        end
        err=score-pscore;
        bu(1,uid)=bu(1,uid)+learnRate*(err-regularization*bu(1,uid));
        bi(1,iid)=bi(1,iid)+learnRate*(err-regularization*bi(1,iid));
        for l=1:factornum
            temp=pu(uid,l);
            pu(uid,l)=pu(uid,l)+learnRate*(err*qi(iid,l)-regularization*pu(uid,l));
            qi(iid,l)=qi(iid,l)+learnRate*(err*temp-regularization*qi(iid,l));
        end