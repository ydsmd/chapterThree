clc;clear;

%% 基本设置
vkmh_set = [50 60 70 80 90 100];
N_set = [6 7 8 9 10];
length_set = [20e-3 30e-3 40e-3 50e-3 60e-3 ];
cD_Energy_entropy = zeros(length(N_set),1);
cA_Energy_entropy = zeros(length(N_set),1);
Wavelet_Families = 'dmey';
timeDomin = zeros(5,4);
DWTAPP = zeros(5,5);
Data = [];
Label = [];

%% 文件检索
fileName = pwd;
files = dir(fullfile(fileName));
fileName_folder=[];
size_row = size(files);
folder_num = size_row(1);
for i=3:folder_num
    if(files(i).isdir)     
         fileName_folder = [fileName_folder;string(files(i).name)];
    end
end
n = length(fileName_folder(:,1));
j = 1;
for i = 1: n
    if contains(fileName_folder(i,:),'dataset_')
        Dataset(j) = fileName_folder(i,:);
        j = j + 1;
    end
end
Dataset = Dataset';
for i = 1:length(Dataset)
    strbegin = strfind(Dataset(i),'210m_');
    strend = strfind(Dataset(i),'L_A');
    tmp = strsplit(Dataset(i),'210m_');
    tmp = strsplit(tmp{2},'L_A');
    beamLength(i) = str2num(tmp{1});
    wheel = strsplit(Dataset(i),'_W');
    W(i) = str2num(wheel{2});
end
%% 生成数据集
for k = 1:length(Dataset)
    L = beamLength(k)*210;
    savepath = strcat(pwd,'\',Dataset(k,:));
    for j = 1:length(vkmh_set)
        vkmh = vkmh_set(j);
        v = vkmh/3.6;
        mid = L/(v);
        mid2 = (L+2.6)/(v);
        period = pi*0.42/(v);
        part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
        part2 = round((mid2-period)/(1e-3)):round((mid2+period)/(1e-3));
        for i = 1 : length(length_set)
            eval(['load ',savepath{1},'\Crusie_',num2str(length_set(i)),'_spd_',num2str(vkmh),'_onW',num2str(W(k)),'.mat;'])
            eval(['xp1 = ACC(part',num2str(W(k)),');'])
            eval(['tp1 = time(part',num2str(W(k)),');'])
            timeDomin(i,:) = FourTimeDominFeatures(xp1);
            tmp = DWTandApp(xp1,Wavelet_Families,2,0.25);
            DWTAPP(i,:) = tmp([1,2,3,7,8]);
            
        end
        tempDATA = [timeDomin,DWTAPP,ones(5,1)*vkmh];
        Data = [Data;tempDATA];
        tmpLabel = [zeros(5,1),length_set'];
        Label = [Label;tmpLabel];
     end

%% 多边形数据集
for j = 1:length(vkmh_set)
    vkmh = vkmh_set(j);
    v = vkmh/3.6;
    mid = L/(v);
    mid2 = (L+2.6)/(v);
    period = pi*0.42/(v);
    part1 = round((mid-period)/(1e-3)):round((mid2+period)/(1e-3));
        for i = 1 : length(N_set)
            eval(['load ',savepath{1},'\Poly_',num2str(N_set(i)),'_spd_',num2str(vkmh),'_onW',num2str(W(k)),'.mat;'])
                       eval(['xp1 = ACC(part',num2str(W(k)),');'])
            eval(['tp1 = time(part',num2str(W(k)),');'])
            timeDomin(i,:) = FourTimeDominFeatures(xp1);
            tmp = DWTandApp(xp1,Wavelet_Families,2,0.25);
            DWTAPP(i,:) = tmp([1,2,3,7,8]);
        end
        tempDATA = [timeDomin,DWTAPP,ones(5,1)*vkmh];
        Data = [Data;tempDATA];
        tmpLabel = [ones(5,1),N_set'];
        Label = [Label;tmpLabel];
end

%% 健康数据集
for j = 1:length(vkmh_set)
    vkmh = vkmh_set(j);
    v = vkmh/3.6;
    mid = L/(v);
    mid2 = (L+2.6)/(v);
    period = pi*0.42/(v);
    part1 = round((mid-period)/(1e-3)):round((mid2+period)/(1e-3));

    eval(['load ',savepath{1},'\Good_spd_',num2str(vkmh),'_onW',num2str(W(k)),'.mat;'])
    eval(['xp1 = ACC(part',num2str(W(k)),');'])
    eval(['tp1 = time(part',num2str(W(k)),');'])
    timeDomin = FourTimeDominFeatures(xp1);
    tmp = DWTandApp(xp1,Wavelet_Families,2,0.25);
    DWTAPP = tmp([1,2,3,7,8]);
    tempDATA = [timeDomin,DWTAPP,vkmh];

    Data = [Data;tempDATA];
    tmpLabel = [2,0];
    Label = [Label;tmpLabel];
end

end


save TrainData.mat Data Label
