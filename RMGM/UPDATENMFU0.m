function[U0]=UPDATENMFU0(D1,D2,U0,U1,U2,V1,V2,P,M,Ks)
tepU01=zeros(M,Ks);
tepU02=zeros(M,Ks);
tepU03=zeros(M,Ks);
for p=1:P
    eval(['Hp=V',num2str(p),'(1:Ks,:);']);
    eval(['Wp=V',num2str(p),'((Ks+1):(2*Ks),:);']);
    eval(['tep=D',num2str(p),'*Hp'';']);
    tepU01=tep+tepU01;
    tep2=U0*Hp*Hp';
    tepU02=tep2+tepU02;
    eval(['tep3=U',num2str(p),'*Wp*Hp'';']);
    tepU03=tep3+tepU03;
end
U0=U0*(tepU01\(tepU02+tepU03));