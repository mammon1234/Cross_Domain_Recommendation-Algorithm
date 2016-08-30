function[alpha,D]=SGD(R,R1,R2,I)
tep=0.5;
alpha=0;
errorpre=norm((R-alpha*R1-(1-alpha)*R2).*I,'fro');
alpha=0.5;
errornow=norm((R-alpha*R1-(1-alpha)*R2).*I,'fro');
for p=1:10
    tep=tep/2;
    alpha=alpha-sign(errornow-errorpre)*tep;
    errorpre=errornow;
    errornow=norm((R-alpha*R1-(1-alpha)*R2).*I,'fro');
end
D=alpha*R1+(1-alpha)*R2;

    