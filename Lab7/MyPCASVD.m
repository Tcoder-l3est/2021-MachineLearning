%% ================PCA2��ά================
function [newtrainData,newtestData,K] = MyPCASVD(Datas,K,train_percent,class_num)
fprintf(' =======Do PCA Dimensionality Reduction(Based on SVD)...=======\n');
Datas = Datas';
t0 = tic;
[NN,Train_NUM]=size(Datas);
% Step 1: ���Ļ�
    mean_val = mean(Datas,2);
    newData1 = Datas - mean_val*ones(1,Train_NUM);
% Step 2: ��Э�������  ��������ˣ�
    C = newData1'*newData1 / Train_NUM;
% Step 3: ������������������ֵ
    %[V,D] = eig(A) ��������ֵ�ĶԽǾ��� D �;��� V
    %�����Ƕ�Ӧ��������������ʹ�� A*V = V*D��
    %[V,D] = eig(C);
    
    % ʹ��SVD�ֽ�
    %[V,D,U] = svd(C,'econ');
    [V,S]=Find_K_Max_Eigen(C,K);
    %Vector: 400*K value:1*K
    % ���������� �Լ� ����ֵ M*K
    disc_value=S;% 
    disc_set=zeros(NN,K);
    
    qiyizhi = ones(K,K);
    for i = 1:K
        qiyizhi(i,i) = disc_value(i);
    end
    
    newData1=newData1/sqrt(Train_NUM-1);
    
    %disc_set = 10000 * 8  data 10000 * 400
    for k=1:K
        % ӳ���feature N*M   *  M*K  ->  N * K
        disc_set(:,k)=(1/sqrt(disc_value(k)))*newData1*V(:,k);
    end
    
% Step 5: ȡǰK�У���ɾ���U Ȼ�����
    % ԭ�����൱����112*92=10304������
    fprintf(' =============This Turn K = %d.==============\n',K);
    newData = newData1'*disc_set;
    newtrainData = newData(1:train_percent*class_num,:);
    newtestData = newData(train_percent*class_num+1:400,:);
    fprintf(' ==========Dimension From 10304 Lower To %d==========\n',K);
    fprintf(' =============== Done PCA ===============\n');
    toc(t0);
end