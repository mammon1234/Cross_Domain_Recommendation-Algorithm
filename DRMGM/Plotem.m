function[error,mae]=Plotem(T1,T2,U1,U2,Data2,Data3,W1,W2,Tte1,Tte2)
for alpha=0:1:100 error(1,alpha+1)=norm((T1-(alpha/100)*U1-((100-alpha)/100)*Data2).*W1,'fro');end
for alpha=0:1:100 mae(1,alpha+1)=MAE((alpha/100)*U1+((100-alpha)/100)*Data2,Tte1);end
alpha=0:0.01:1;
figure
plot(alpha,error,'gs-');title('bias');xlabel('a');ylabel('与训练集的误差');
figure
plot(alpha,mae,'rs-');title('MAE');xlabel('a');ylabel('MAE'); 
for alpha=0:1:100 error(1,alpha+1)=norm((T2-(alpha/100)*U2-((100-alpha)/100)*Data3).*W2,'fro');end
for alpha=0:1:100 mae(1,alpha+1)=MAE((alpha/100)*U2+((100-alpha)/100)*Data3,Tte2);end
alpha=0:0.01:1;
figure
plot(alpha,error,'gs-');title('bias');xlabel('a');ylabel('与训练集的误差');
figure
plot(alpha,mae,'rs-');title('MAE');xlabel('a');ylabel('MAE'); 