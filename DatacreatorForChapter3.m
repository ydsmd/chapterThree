parameterSetting;
vkmh_set = [50 60 70 80 90 100];
N_set = [6 7 8 9 10];
A_set = [3e-4,2.75e-4,2.5e-4,2.25e-4,2e-4];
length_set = [20e-3 30e-3 40e-3 50e-3 60e-3];
num = 1;
%% 第一组数据
Savepath = 'D:\研究生\毕设\大论文\第三章\Code\dataset_210m_0.5L_A1_W1_Ra=1e-6\';
position = 0.5*L;
if ~exist(Savepath)
    mkdir(Savepath);
end
disp(['开始生成第',num2str(num),'组数据，地址：',Savepath])
tic
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(N_set)
        A = A_set(i);
        N1 = N_set(i);     
        N2 = 0;       
        simOut = sim('Poly_creator');
        ACC = simOut.acc_Der.Data;
        time = simOut.acc_Der.Time;
        eval(['save ',Savepath, 'Poly_',num2str(N1),'_spd_',num2str(vkmh_set(j)),'_onW1.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(length_set)
        Ln = length_set(i);
        Ln2 = 0;
        simOut = sim('Cruise_creator.slx');
        ACC = simOut.Cru_acc.Data;
        time = simOut.Cru_acc.Time;
        eval(['save ',Savepath, 'Crusie_',num2str(Ln),'_spd_',num2str(vkmh_set(j)),'_onW1.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    N1 = 0;     
    N2 = 0;       
    simOut = sim('Poly_creator');
    ACC = simOut.acc_Der.Data;
    time = simOut.acc_Der.Time;
    eval(['save ',Savepath, 'Good_spd_',num2str(vkmh_set(j)),'_onW1.mat ACC time;']);

end
time = toc;
disp(['第',num2str(num),'组数据生成完成，用时：',num2str(time)])
num=num+1;
%% 第二组数据
N_set = [6 7 8 9];
Savepath = 'D:\研究生\毕设\大论文\第三章\Code\dataset_210m_0.45L_A1_W1_Ra=1e-6\';
position = 0.45*L;
if ~exist(Savepath)
    mkdir(Savepath);
end
disp(['开始生成第',num2str(num),'组数据，地址：',Savepath])
tic
% N_set = [10];
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(N_set)
        A = A_set(i);
        N1 = N_set(i);     
        N2 = 0;       
        simOut = sim('Poly_creator');
        ACC = simOut.acc_Der.Data;
        time = simOut.acc_Der.Time;
        eval(['save ',Savepath, 'Poly_',num2str(N1),'_spd_',num2str(vkmh_set(j)),'_onW1.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(length_set)
        Ln = length_set(i);
        Ln2 = 0;
        simOut = sim('Cruise_creator.slx');
        ACC = simOut.Cru_acc.Data;
        time = simOut.Cru_acc.Time;
        eval(['save ',Savepath, 'Crusie_',num2str(Ln),'_spd_',num2str(vkmh_set(j)),'_onW1.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    N1 = 0;     
    N2 = 0;       
    simOut = sim('Poly_creator');
    ACC = simOut.acc_Der.Data;
    time = simOut.acc_Der.Time;
    eval(['save ',Savepath, 'Good_spd_',num2str(vkmh_set(j)),'_onW1.mat ACC time;']);

end
time = toc;
disp(['第',num2str(num),'组数据生成完成，用时：',num2str(time)])
num=num+1;

%% 第三组数据
Savepath = 'D:\研究生\毕设\大论文\第三章\Code\dataset_210m_0.55L_A1_W2_Ra=1e-6\';
position = 0.55*L;
if ~exist(Savepath)
    mkdir(Savepath);
end
disp(['开始生成第',num2str(num),'组数据，地址：',Savepath])
tic
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(N_set)
        A = A_set(i);
        N1 = 0;     
        N2 = N_set(i);   
        simOut = sim('Poly_creator');
        ACC = simOut.acc_Der.Data;
        time = simOut.acc_Der.Time;
        eval(['save ',Savepath, 'Poly_',num2str(N2),'_spd_',num2str(vkmh_set(j)),'_onW2.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(length_set)
        Ln = 0;
        Ln2 = length_set(i);
        simOut = sim('Cruise_creator.slx');
        ACC = simOut.Cru_acc.Data;
        time = simOut.Cru_acc.Time;
        eval(['save ',Savepath, 'Crusie_',num2str(Ln2),'_spd_',num2str(vkmh_set(j)),'_onW2.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    N1 = 0;     
    N2 = 0;       
    simOut = sim('Poly_creator');
    ACC = simOut.acc_Der.Data;
    time = simOut.acc_Der.Time;
    eval(['save ',Savepath, 'Good_spd_',num2str(vkmh_set(j)),'_onW2.mat ACC time;']);

end
time = toc;
disp(['第',num2str(num),'组数据生成完成，用时：',num2str(time)])
num=num+1;
%% 第四组数据
Savepath = 'D:\研究生\毕设\大论文\第三章\Code\dataset_210m_0.45L_A1_W2_Ra=1e-6\';
position = 0.45*L;
if ~exist(Savepath)
    mkdir(Savepath);
end
disp(['开始生成第',num2str(num),'组数据，地址：',Savepath])
tic
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(N_set)
        A = A_set(i);
        A = A_set(i);
        N1 = 0;     
        N2 = N_set(i);       
        simOut = sim('Poly_creator');
        ACC = simOut.acc_Der.Data;
        time = simOut.acc_Der.Time;
        eval(['save ',Savepath, 'Poly_',num2str(N2),'_spd_',num2str(vkmh_set(j)),'_onW2.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(length_set)
        Ln = 0;
        Ln2 = length_set(i);
        simOut = sim('Cruise_creator.slx');
        ACC = simOut.Cru_acc.Data;
        time = simOut.Cru_acc.Time;
        eval(['save ',Savepath, 'Crusie_',num2str(Ln2),'_spd_',num2str(vkmh_set(j)),'_onW2.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    N1 = 0;     
    N2 = 0;       
    simOut = sim('Poly_creator');
    ACC = simOut.acc_Der.Data;
    time = simOut.acc_Der.Time;
    eval(['save ',Savepath, 'Good_spd_',num2str(vkmh_set(j)),'_onW2.mat ACC time;']);

end
time = toc;
disp(['第',num2str(num),'组数据生成完成，用时：',num2str(time)])
num=num+1;

%% 第五组数据
Savepath = 'D:\研究生\毕设\大论文\第三章\Code\dataset_210m_0.5L_A1_W2_Ra=1e-6\';
position = 0.5*L;
if ~exist(Savepath)
    mkdir(Savepath);
end
disp(['开始生成第',num2str(num),'组数据，地址：',Savepath])
tic
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(N_set)
        N1 = 0;     
        N2 = N_set(i);       
        simOut = sim('Poly_creator');
        ACC = simOut.acc_Der.Data;
        time = simOut.acc_Der.Time;
        eval(['save ',Savepath, 'Poly_',num2str(N2),'_spd_',num2str(vkmh_set(j)),'_onW2.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(length_set)
        Ln = 0;
        Ln2 = length_set(i);
        simOut = sim('Cruise_creator.slx');
        ACC = simOut.Cru_acc.Data;
        time = simOut.Cru_acc.Time;
        eval(['save ',Savepath, 'Crusie_',num2str(Ln2),'_spd_',num2str(vkmh_set(j)),'_onW2.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    N1 = 0;     
    N2 = 0;       
    simOut = sim('Poly_creator');
    ACC = simOut.acc_Der.Data;
    time = simOut.acc_Der.Time;
    eval(['save ',Savepath, 'Good_spd_',num2str(vkmh_set(j)),'_onW2.mat ACC time;']);

end
time = toc;
disp(['第',num2str(num),'组数据生成完成，用时：',num2str(time)])
num=num+1;
%% 第六组数据
Savepath = 'D:\研究生\毕设\大论文\第三章\Code\dataset_210m_0.55L_A1_W1_Ra=1e-6\';
position = 0.55*L;
if ~exist(Savepath)
    mkdir(Savepath);
end
disp(['开始生成第',num2str(num),'组数据，地址：',Savepath])
tic
vkmh_set = [50];
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(N_set)
        A = A_set(i);
        N1 = N_set(i);     
        N2 = 0;       
        simOut = sim('Poly_creator');
        ACC = simOut.acc_Der.Data;
        time = simOut.acc_Der.Time;
        eval(['save ',Savepath, 'Poly_',num2str(N1),'_spd_',num2str(vkmh_set(j)),'_onW1.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    for i = 1:length(length_set)
        Ln = length_set(i);
        Ln2 = 0;
        simOut = sim('Cruise_creator.slx');
        ACC = simOut.Cru_acc.Data;
        time = simOut.Cru_acc.Time;
        eval(['save ',Savepath, 'Crusie_',num2str(Ln),'_spd_',num2str(vkmh_set(j)),'_onW1.mat ACC time;']);
    end
end
for j = 1:length(vkmh_set)
    v = vkmh_set(j)/3.6;
    N1 = 0;     
    N2 = 0;       
    simOut = sim('Poly_creator');
    ACC = simOut.acc_Der.Data;
    time = simOut.acc_Der.Time;
    eval(['save ',Savepath, 'Good_spd_',num2str(vkmh_set(j)),'_onW1.mat ACC time;']);

end
time = toc;
disp(['第',num2str(num),'组数据生成完成，用时：',num2str(time)])
num=num+1;