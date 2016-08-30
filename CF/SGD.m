function[alpha,D]=SGD(R,R1,R2,I)
alphatep=0;
errortep=0;
for alpha=0:0.1:1
    error=norm((R-alpha*R1-(1-alpha)*R2).*I,'fro');
    if error-errortep<=0
        alphatep=alpha;
    end
    errortep=error;
end
alpha=alphatep;
tep=0.05
if alpha~=0&&alpha~=1
    alpha1=alpha-tep;
    errortep=norm((R-alpha1*R1-(1-alpha1)*R2).*I,'fro');
    alpha2=alpha+tep;   
    error=norm((R-alpha2*R1-(1-alpha2)*R2).*I,'fro');
    tep=tep/2;    
    alpha=alpha-sign(error-errortep)*tep;
    errortep=norm((R-alphatep*R1-(1-alphatep)*R2).*I,'fro');
    error=norm((R-alpha*R1-(1-alpha)*R2).*I,'fro');
    for p=1:10
        tep=tep/2;
        alpha=alpha-sign(error-errortep)*tep;
        errortep=error;
        error=norm((R-alpha*R1-(1-alpha)*R2).*I,'fro');
    end
end
D=alpha*R1+(1-alpha)*R2;

    