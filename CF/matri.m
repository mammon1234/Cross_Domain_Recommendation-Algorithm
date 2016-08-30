function[D]=matri(P)
Size=size(P);
m=Size(1);
t1=P(:,1);
t2=P(:,2);
u=norm(t1',inf);
v=norm(t2',inf);
D=zeros(u,v);
for k=1:m
    D(P(k,1),P(k,2))=P(k,3);
end