function[Up]=UPDATENMFUp(Dp,U0,Up,Vp,Kc)
    Hp=Vp(1:Kc,:);
    Wp=Vp((Kc+1):(2*Kc),:);
    tepUp1=Dp*Wp';
    tepUp2=Up*Wp*Wp';
    tepUp3=U0*Hp*Wp';   
Up=Up*(tepUp1\(tepUp2+tepUp3));
