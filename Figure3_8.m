%%%%%%%%%%%%%%%%%%%%%%%%% Figure3_8.m%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          本文件绘制论文图3.8                                                %
%          在运行前需要先加载数据集文件夹dataset_210m_0.55L_A1_W1             %
%          作者：余道洪                                                       %
%          修改日期：2023.5.4                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%在运行前需要先加载数据集文件夹dataset_210m_0.55L_A1_W1

clc;clear;
Crusie_set=[20e-3 30e-3 40e-3 50e-3 60e-3];
vkmh_set = [50 60 70 80 90 100];
N_set = [6 7 8 9 10];
Featureset = zeros(66,9);
Labelset = zeros(66,1);
Labelset(1:30)= 1;
Labelset(31:60)= 2;
Labelset(61:66)= 0;
num = 1;
k= 1;
position = 210*0.55;
Wavelet_Families = 'dmey';
for i = 1 : length(vkmh_set)
    v = vkmh_set(i)/3.6;
    mid = position/(v);
    mid2 = (position+2.6)/(v);
    period = pi*0.42/(v);
    part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
    for j = 1:length(Crusie_set)
        eval(['load Crusie_',num2str(Crusie_set(j)),'_spd_',num2str(vkmh_set(i)),'_onW1.mat']);
        xp1 = ACC(part1);
        tp1 = time(part1);
        X = xp1;
        tmpres = DWTandSamp(X,Wavelet_Families,2,0.25);
        Featureset(num,:) = [tmpres,vkmh_set(i)];
        num = num+1;
    end

end

for i = 1 : length(vkmh_set)
    v = vkmh_set(i)/3.6;
    mid = position/(v);
    mid2 = (position+2.6)/(v);
    period = pi*0.42/(v);
    part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
    for j = 1:length(N_set)
        eval(['load Poly_',num2str(N_set(j)),'_spd_',num2str(vkmh_set(i)),'_onW1.mat']);
        xp1 = ACC(part1);
        tp1 = time(part1);

        X = xp1;
%         tmpres = DWTandApp(X,Wavelet_Families,2,0.25);
        tmpres = DWTandSamp(X,Wavelet_Families,2,0.25);
        Featureset(num,:) = [tmpres,vkmh_set(i)];
        num = num+1;
    end

end

for i = 1 : length(vkmh_set)
    v = vkmh_set(i)/3.6;
    mid = position/(v);
    mid2 = (position+2.6)/(v);
    period = pi*0.42/(v);
    part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
    eval(['load Good_spd_',num2str(vkmh_set(i)),'_onW1.mat']);
    xp1 = ACC(part1);
    tp1 = time(part1);
    X = xp1;
    tmpres = DWTandSamp(X,Wavelet_Families,2,0.25);
    Featureset(num,:) = [tmpres,vkmh_set(i)];
    num = num+1;
end

% 
v = 50;
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
dwtindex = {'\itcD','\itcA','{\itcA}_{1}','{\itcA}_{2}','{\itcA}_{3}','{\itcA}_{4}','{\itcA}_{5}','{\itcA}_{6}'};
for index = 1:8
Z = zeros(5,3);
Z(:,1) = tmpdataset(1:5,index);
Z(:,2) = tmpdataset(6:10,index);
Z(:,3) = tmpdataset(11,index) * ones(5,1);
h = figure(index);
b = bar3(Z);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
% colorbar
view(-60,20);
ylabel('损伤程度','Fontname','宋体','FontSize',18);
xlabel('损伤类型','Fontname','宋体','FontSize',18);
zlabel(dwtindex{index},'Fontname','宋体','FontSize',18);
set(gca,'yticklabel',{'20mm/6阶','30mm/7阶','40mm/8阶','50mm/9阶','60mm/10阶'},'FontSize',18);
set(gca,'xticklabel',{'擦伤','多边形','健康'},'FontSize',18);
set(h,'position',[150,100,850,650]);
end
