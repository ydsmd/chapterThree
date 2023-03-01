function TimeDominFeatures = getTimeDominFeatures(Signal)
example_data = Signal; %以第一轮在Sensor1上的信号为例
n = length(example_data);
%% 平均值 表征信号整体稳定性
Index_Avg = mean(example_data);
%% 均方根值 描述信号能量大小
Index_Rms = rms(example_data);
%% 标准差 表征信号偏离平均值的稳定程度
Index_std = std(example_data);
%% 歪度指标 对机械设备的碰撞和摩擦信号敏感
Index_Cw = sum((abs(example_data)-Index_Avg).^3)/(n-1)/(Index_std^3);
%% 峭度指标对信号冲击特征敏感
Index_Ki = sum((abs(example_data)-Index_Avg).^4)/(n-1)/(Index_std^4);
%% 方根幅值 
Index_Xr = mean(sqrt(abs(example_data)))^2;
%% 峰值指标 表示信号的最大振动幅值
Index_pk = max(abs(example_data));
%% 脉冲因子 表示异常信号的冲击特性
Index_If = Index_pk/Index_Rms;
%% 峰值因子 表示信号冲击特性
Index_Xi = Index_pk / Index_Rms;
%% 裕度因子
Index_L = Index_pk/Index_Xr;


TimeDominFeatures(1) = Index_Avg;
TimeDominFeatures(2) = Index_Rms;
TimeDominFeatures(3) = Index_Cw;
TimeDominFeatures(4) = Index_Ki;
TimeDominFeatures(5) = Index_If;
TimeDominFeatures(6) = Index_L;
TimeDominFeatures(7) = Index_Xi ;
TimeDominFeatures(8) = Index_std;
TimeDominFeatures(9)  = Index_Xr;
end