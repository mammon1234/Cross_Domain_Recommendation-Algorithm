function [D]=proinitial(D,W)
Sum=sum(sum(D,2));
Count=sum(sum(W,2));
average=Sum/Count;
D=D+(1-W)*average;
