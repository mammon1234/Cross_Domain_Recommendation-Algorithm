function [Data,Core] = SRMGM(Data,K,L,T,PrrU,PrrI,CndR)
Size=size(Data);
% M users and N items in all domains
M = Size(:,1);
N = Size(:,2);

% P observed ratings in all domains sum����Ϊsum���еĺ�,��Ҫ����sum,data>0Ϊbooleanֵ
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


% initialize the posteriors P(user_group,item_group|user,item,rating)3��3��122��
Post = zeros(K,L,P);
% user probability conditioned on user group 18��3��	
CndU = rand(M,K);
% item probability conditioned on item group 18��3��
CndI = rand(N,L);
%Xt=Data(:,:);
%[PrrU,PrrI,CndR]=initial(Xt,K,L);
%% EM algorithm iterations ѭ��50��
for t = 1:T
    % E-step
    for p = 1:P
        m = X(p,1);
        n = X(p,2); 
        r = X(p,3);
        Prr = PrrU*PrrI';
        Cnd = CndU(m,:)'*CndI(n,:);
        Post(:,:,p) = Prr.*Cnd.*CndR(:,:,r);
        Post(:,:,p) = Post(:,:,p)/sum(sum(Post(:,:,p)));
    end
    % M-step3��1�к�3��һ��
    PrrU = sum(sum(Post,3),2)/P;
    PrrI = sum(sum(Post,3),1)'/P;
    for r = 1:R
	    % �жϵ������Ƿ���r��ͬ idxΪsize��122������
        Idx = (X(:,3)==r);
		% IdxΪ�����Ƿ��ά�Ƿ���ӵı�־λ
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

% compute group-level (compressed) rating matrix��������
Core = zeros(K,L);
for r = 1:R
    Core = Core+r*CndR(:,:,r);
end
%disp('Shared group-level rating matrix across domains:')
%disp(Core);

% compute user and item memberships�ֱ�Ϊ18������
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

%% Fill in the missing entriesһ������

for m = 1:M
    for n = 1:N
        %if Data(m,n)==0
            Data(m,n) = UserMem(m,:)*Core*ItemMem(n,:)';
        %end
    end
end


