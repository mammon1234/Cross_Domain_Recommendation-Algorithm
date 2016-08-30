function[Vp]=UPDATENMFVp(Dp,U0,Up,Vp)
Upsum=[U0,Up];
tepVp1=Upsum'*Dp;
tepVp2=Upsum'*Upsum*Vp;
Vp=Vp*(tepVp1\tepVp2);