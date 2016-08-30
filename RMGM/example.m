%% An instance of RMRM_EM running result
% (You may need to run "example" multiple times to get the ideal result)
% -------------------------------------------------------------------------
% Two rating matrices of different domains:
%      0     3     0     1     3     1     2     0     2
%      1     2     2     3     2     3     1     0     1
%      3     0     1     2     0     2     3     2     3
%      3     1     1     2     0     2     3     2     0
%      1     2     2     3     2     3     1     3     1
%      0     0     1     2     1     0     3     2     3
%      0     3     0     1     3     1     2     1     2
%      1     0     2     3     2     3     1     3     0
%      2     3     3     1     3     0     2     1     2
% 
%      0     0     0     0     2     3     1     2     3
%      2     3     1     3     0     0     3     1     2
%      0     2     3     2     3     0     2     3     1
%      3     0     2     0     0     3     0     2     3
%      1     0     3     2     3     1     2     0     0
%      3     1     2     1     2     0     1     2     0
%      2     3     1     0     1     2     3     1     0
%      0     3     1     0     1     2     3     1     2
%      0     0     3     2     3     0     2     3     1
% 
% Shared group-level rating matrix across domains:
%      3     1     2
%      2     3     1
%      1     2     3
% 
% Co-clustering results and filled rating matrices:
%      3     3     3     1     1     1     2     2     2
%      3     3     3     1     1     1     2     2     2
%      3     3     3     1     1     1     2     2     2
%      2     2     2     3     3     3     1     1     1
%      2     2     2     3     3     3     1     1     1
%      2     2     2     3     3     3     1     1     1
%      1     1     1     2     2     2     3     3     3
%      1     1     1     2     2     2     3     3     3
%      1     1     1     2     2     2     3     3     3
% 
%      3     3     3     1     1     1     2     2     2
%      3     3     3     1     1     1     2     2     2
%      3     3     3     1     1     1     2     2     2
%      2     2     2     3     3     3     1     1     1
%      2     2     2     3     3     3     1     1     1
%      2     2     2     3     3     3     1     1     1
%      1     1     1     2     2     2     3     3     3
%      1     1     1     2     2     2     3     3     3
%      1     1     1     2     2     2     3     3     3
% -------------------------------------------------------------------------


%% Customize parameters

% number of iterations
T = 50;
% number of user/item groups
K = 3;
L = 3;
% ratio of missing entries in each domain
RATIO1 = 0.2;
RATIO2 = 0.3;

%% Construct test rating matrices

% 3x3 core matrix (compressed rating matrix)
Core = [3 2 1; 2 1 3; 1 3 2];

% user/item memberships for the 1st domain (9user*9item)
UserMem1 = [1 0 0; 0 1 0; 0 0 1;
            0 0 1; 0 1 0; 0 0 1;
            1 0 0; 0 1 0; 1 0 0];
ItemMem1 = [0 1 0; 1 0 0; 1 0 0;
            0 0 1; 1 0 0; 0 0 1;
            0 1 0; 0 0 1; 0 1 0];
% generate the 1st rating matrix
TestMat1 = UserMem1*Core*ItemMem1';
[M1,N1] = size(TestMat1);
% user/item memberships for the 2nd domain (9user*9item)
UserMem2 = [0 1 0; 0 0 1; 1 0 0; 
            0 1 0; 1 0 0; 0 1 0; 
            0 0 1; 0 0 1; 1 0 0;];
ItemMem2 = [0 0 1; 0 1 0; 1 0 0;
            0 1 0; 1 0 0; 0 0 1;
            0 1 0; 1 0 0; 0 0 1;];
% generate the 2nd rating matrix
TestMat2 = UserMem2*Core*ItemMem2';
[M2,N2] = size(TestMat2);

% random missing entries in the 1st rating matrix 1 到 M1*N1 的无重复随机排列
MissEntry1 = randperm(M1*N1);
% 无重复随机排列的前16个值所对应的矩阵数值赋予0,以列为划分
TestMat1(MissEntry1(1:round(M1*N1*RATIO1))) = 0;
% random missing entries in the 2nd rating matrix,那24个值所对应的矩阵数值赋予0
MissEntry2 = randperm(M2*N2);
TestMat2(MissEntry2(1:round(M2*N2*RATIO2))) = 0;

disp('Two rating matrices of different domains:')
disp(TestMat1);
disp(TestMat2);

Data = [[TestMat1 zeros(M1,N2)]; [zeros(M2,N1) TestMat2]];
Size = [M1 N1; M2 N2];

%% Run RMGM

tic
[Data,Core] = RMGM_EM(Data,Size,K,L,T);
toc


