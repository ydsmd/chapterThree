% 求近似熵的函数
function appEn = ApproximateEntropy(dim, r, data, tau)
%   近似熵算法的提出者：Pincus S M . Approximate entropy as a measure of system complexity[J]. Proceedings of the National Academy of Sciences ,1991,88(6):2297—2301.
%   Input:
%       dim：嵌入维数(一般取1或者2)
%       r：相似容限( 通常取0.1*Std(data)~0.25*Std(data) )
%       data：时间序列数据，data须为1xN的矩阵
%       tau：下采样延迟时间（在默认值为1的情况下，用户可以忽略此项）
%   Output:
%       appEn：所求数据的近似熵
if nargin < 4
    tau = 1;
end
if tau > 1
    data = downsample(data, tau);
end

N = length(data);
result = zeros(1,2);

for m = dim:dim+1
    Bi = zeros(N-m+1,1);
    dataMat = zeros(N-m+1,m);
    
    % 设置数据矩阵，构造成m维的矢量
    for i = 1:N-m+1
        dataMat(i,:) = data(1,i:i+m-1);
    end
    
    % 利用距离计算相似模式数
    for j = 1:N-m+1
        % 计算切比雪夫距离，包括自匹配情况
        dist = max(abs(dataMat - repmat(dataMat(j,:),N-m+1,1)),[],2);
        % 统计dist小于等于r的数目
        D = (dist <= r);
        % 包括自匹配情况
        Bi(j,1) = sum(D)/(N-m+1);
    end
 
    % 求所有Bi的均值
    result(m-dim+1) = sum(log(Bi))/(N-m+1);
	
end
% 计算得到的近似熵值
appEn = result(1)-result(2);

end
