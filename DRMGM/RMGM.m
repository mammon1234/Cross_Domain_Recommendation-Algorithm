function [Data,Core,U1,U2] = RMGM(Data,Size,K,L,T,M1,N1,PrrU,PrrI,CndR)
% D domains,取第一列的size 2
D = size(Size,1);
% M users and N items in all domains
M = sum(Size(:,1));
N = sum(Size(:,2));

% P observed ratings in all domains sum矩阵为sum各列的和,需要二次sum,data>0为boolean值
P = sum(sum(Data>0));
R = max(max(Data));
X = zeros(P,3);
i = 0;
for m = 1:M
    for n = 1:N
        if  Data(m,n)>0
            i = i+1;
            X(i,1) = m;
            X(i,2) = n;
            X(i,3) = Data(m,n);
        end
    end
end


% initialize the posteriors P(user_group,item_group|user,item,rating)3行3列122纵
Post = zeros(K,L,P);
% user probability conditioned on user group 18行3列	
CndU = rand(M,K);
% item probability conditioned on item group 18行3列
CndI = rand(N,L);
%Xt=Data(1:M1,1:N1);
%[PrrU,PrrI,CndR]=initial(Xt,K,L);
%% EM algorithm iterations 循环50次
for t = 1:T
    % E-step
    for p = 1:P
        m = X(p,1);
        n = X(p,2); 
        r = X(p,3);
        Prr = PrrU*PrrI';
        Cnd = CndU(m,:)'*CndI(n,:);
        Post(:,:,p) = Prr.*Cnd.*CndR(:,:,r);
        %归一化
        Post(:,:,p) = Post(:,:,p)/sum(sum(Post(:,:,p)));
    end
    % M-step3行1列和3列一行
    PrrU = sum(sum(Post,3),2)/P;
    PrrI = sum(sum(Post,3),1)'/P;
    for r = 1:R
	    % 判断第三列是否与r相同 idx为size是122的数组
        Idx = (X(:,3)==r);
		% Idx为决定是否该维是否相加的标志位
        CndR(:,:,r) = sum(Post(:,:,Idx),3)./(sum(Post,3)+0.00001);
    end
    for m = 1:M
        Idx = (X(:,1)==m);
        CndU(m,:) = sum(sum(Post(:,:,Idx),3),2)'./(P*PrrU'+0.00001);
    end
    for n = 1:N
        Idx = (X(:,2)==n);
        CndI(n,:) = sum(sum(Post(:,:,Idx),3),1)./(P*PrrI'+0.00001);
    end
end
%% Compute core matrix and memberships

% compute group-level (compressed) rating matrix三行三列
Core = zeros(K,L);
for r = 1:R
    Core = Core+r*CndR(:,:,r);
end
%disp('Shared group-level rating matrix across domains:')
%disp(Core);

% compute user and item memberships分别为18行三列
UserMem = zeros(M,K);
for m = 1:M
    total = CndU(m,:)*PrrU(:);
    UserMem(m,:) = CndU(m,:).*PrrU'/total;
end
ItemMem = zeros(N,L);
for n = 1:N
    total = CndI(n,:)*PrrI(:);
    ItemMem(n,:) = CndI(n,:).*PrrI'/total;
end 

%% Fill in the missing entries一行三列

StartU = ones(1,D+1);
StartI = ones(1,D+1);
for d = 2:D
    StartU(d) = StartU(d-1)+Size(d-1,1);
    StartI(d) = StartI(d-1)+Size(d-1,2);
end
StartU(D+1) = M+1;
StartI(D+1) = N+1;

for d = 1:D
    for m = StartU(d):StartU(d+1)-1
        for n = StartI(d):StartI(d+1)-1
            %if Data(m,n)==0
                Data(m,n) = UserMem(m,:)*Core*ItemMem(n,:)';
            %end
        end
    end
end
U1=Data(1:M1,1:N1);
U2=Data((M1+1):M,(N1+1):N);

