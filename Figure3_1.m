%%%%%%%%%%%%%%%%%%%%%%%%% Figure3_1.m%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          本文件绘制论文图3.1                                                %
%          在运行前需要先加载数据集文件夹                                     %
%          作者：余道洪                                                       %
%          修改日期：2023.5.4                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;clear;
Crusie_set=[20e-3 30e-3 40e-3 50e-3 60e-3];
vkmh_set = [50 60 70 80 90 100];
N_set = [6 7 8 9 10];
L = 210;
positon = L*0.45;
Featureset = zeros(66,10);
Labelset = zeros(66,1);
Labelset(1:30)= 1;
Labelset(31:60)= 2;
Labelset(61:66)= 0;
num = 1;
for i = 1 : length(vkmh_set)
    v = vkmh_set(i)/3.6;
    mid = positon/(v);
    mid2 = (positon+2.6)/(v);
    period = pi*0.42/(v);
    part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
    for j = 1:length(Crusie_set)
        eval(['load Crusie_',num2str(Crusie_set(j)),'_spd_',num2str(vkmh_set(i)),'_onW1.mat']);
        xp1 = ACC(part1);
        tp1 = time(part1);
        X = xp1;
        tmpFeature = getTimeDominFeatures(X);
        Featureset(num,:) = [tmpFeature,vkmh_set(i)];
        num = num+1;
    end

end

for i = 1 : length(vkmh_set)
    v = vkmh_set(i)/3.6;
    mid = positon/(v);
    mid2 = (positon+2.6)/(v);
    period = pi*0.42/(v);
    part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
    for j = 1:length(N_set)
        eval(['load Poly_',num2str(N_set(j)),'_spd_',num2str(vkmh_set(i)),'_onW1.mat']);
        xp1 = ACC(part1);
        tp1 = time(part1);
        X = xp1;
        tmpFeature = getTimeDominFeatures(X);
         Featureset(num,:) = [tmpFeature,vkmh_set(i)];
        num = num+1;
    end

end

for i = 1 : length(vkmh_set)
    v = vkmh_set(i)/3.6;
    mid = positon/(v);
    mid2 = (positon+2.6)/(v);
    period = pi*0.42/(v);
    part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
    eval(['load Good_spd_',num2str(vkmh_set(i)),'_onW1.mat']);
    xp1 = ACC(part1);
    tp1 = time(part1);
    X = xp1;
%     figure()
%     plot(tp1,xp1)
    tmpFeature = getTimeDominFeatures(X);
     Featureset(num,:) = [tmpFeature,vkmh_set(i)];
    num = num+1;
end


tmpdataset = Featureset(Featureset(:,10)==50,:);
tmplabel = Labelset(Featureset(:,10)==50,:);
timeDominName =  {'平均值';'均方根值';'歪度值';'峭度值';'脉冲因子';'裕度因子';'峰值因子';'标准差值';'方根幅值'};

for index = 2:9

Z = zeros(5,3);
Z(:,1) = log(tmpdataset(1:5,index));
Z(:,2) = log(tmpdataset(6:10,index));
Z(:,3) = log(tmpdataset(11,index) * ones(5,1));

h = figure(index);
b = bar3(Z);

for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
% colorbar
view(60,20);
ylabel('损伤程度','Fontname','宋体','FontSize',18);
xlabel('损伤类型','Fontname','宋体','FontSize',18);
zlabel(['log(',timeDominName{index},')'],'Fontname','宋体','FontSize',18);set(gca,'yticklabel',{'20mm/6阶','30mm/7阶','40mm/8阶','50mm/9阶','60mm/10阶'},'FontSize',18);
set(gca,'xticklabel',{'擦伤','多边形','健康'},'FontSize',18);
set(h,'position',[150,100,850,650]);

end
index = 1;
Z = zeros(5,3);
Z(:,1) = tmpdataset(1:5,index);
Z(:,2) = tmpdataset(6:10,index);
Z(:,3) = tmpdataset(11,index) * ones(5,1);

h = figure(1);
b = bar3(Z);
view(60,20);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
% colorbar
view(60,20);
ylabel('损伤程度','Fontname','宋体','FontSize',18);
xlabel('损伤类型','Fontname','宋体','FontSize',18);
zlabel(timeDominName{index},'Fontname','宋体','FontSize',18);
set(gca,'yticklabel',{'20mm/7阶','30mm/8阶','40mm/9阶','50mm/10阶','60mm/6阶',},'FontSize',18);
set(gca,'xticklabel',{'擦伤','多边形','健康'},'FontSize',18);
set(h,'position',[150,100,850,650]);
            