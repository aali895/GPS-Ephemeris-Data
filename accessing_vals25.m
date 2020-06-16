%                  col  2:    M0     ....... mean anomaly at reference time
%                  col  3:    delta_n  ..... mean motion difference
%                  col  4:    e      ....... eccentricity
%                  col  5:    sqrt(A)  ..... where A is semimajor axis
%                  col  6:    OMEGA  ....... LoAN at weekly epoch
%                  col  7:    i0     ....... inclination at reference time
%                  col  8:    omega  ....... argument of perigee
%                  col  9:    OMEGA_dot  ... rate of right ascension 
%                  col 10:    i_dot  ....... rate of inclination angle
%                  col 11:    Cuc    ....... cosine term, arg. of latitude
%                  col 12:    Cus    ....... sine term, arg. of latitude
%                  col 13:    Crc    ....... cosine term, radius
%                  col 14:    Crs    ....... sine term, radius
%                  col 15:    Cic    ....... cosine term, inclination
%                  col 16:    Cis    ....... sine term, inclination
%                  col 17:    toe    ....... time of ephemeris
%                  col 18:    IODE   ....... Issue of Data Ephemeris
%                  col 19:    GPS_wk ....... GPS week
%% code execution
clc
clear all;

       %% delta_n  ..... mean motion difference
sat=2;            %% satellite number

col_names=["mean_anomaly","mean_motion","eccentricity","semimajor_axis","OMEGA","inclination","perigee","right_ascension","inclination_angle","cuc","cus","crc","crs","cic","cis","IODE","af0","af1","af2","TGD"];
col_number=[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,21,22,23,24];
for iteration=1:20

col=col_number(iteration) 
%% load 2018 data
% load('data8.mat');
% index=1;
% for page=1:365
%  for j=1:length(data8)
%     if data8 (j,1,page)==sat
%          val8(index)=data8 (j,col,page); % val9 stores data of 2019
%          toe8(index)=data8 (j,17,page);
%          index=index+1;
%     end
% end 
% end

%% load 2019 data
load('data9_25.mat')
index=1;
for page=1:365
 for j=1:length(DATA9)
    if DATA9 (j,1,page)==sat
         val9(index)=DATA9 (j,col,page); % val9 stores data of 2019
         time9(index)=DATA9 (j,25,page);
         index=index+1;
    end
end 
end


%% error removal 2019
epoch =0;
index=1;
for i=1:length(time9)-1
    if time9(i)==epoch
        pos9(index)=i;
        index=index+1;
        i=i+12;
    elseif time9(i)==23 && time9(i+1)~=epoch
        pos9(index)=i;
        index=index+1;
    else
        continue
    end
end

value9=val9(pos9);


%% load 2020 data
% 
index=1;
load ('data2_25.mat');
for page=1:134
 for j=1:length(DATA2)
    if DATA2 (j,1,page)==sat
         val2(index)=DATA2 (j,col,page); % val2 stores data of 2020
         time2(index)=DATA2 (j,25,page);
         index=index+1;
    end
end 
end

%% error removal 2020
pos=[];
epoch =0;
index=1;
for i=1:length(time2)-1
    if time2(i)==epoch
        pos(index)=i;
        index=index+1;
        i=i+12;
    elseif time2(i)==23 && time2(i+1)~=epoch
        pos(index)=i;
        index=index+1;
    else
        continue
    end
end

value2=val2(pos);

numel(pos9)
numel(pos)

mean_anomaly92=[value9,value2];
val=mean_anomaly92;



newName=col_names(iteration)
S.(newName)=val;
save(col_names(iteration),'-struct','S')


% %% error removal 2020
% epoch =22;
% index=1;
% for i=1:length(time9)-1
%     if time9(i)==epoch
%         pos(index)=i;
%         index=index+1;
%         i=i+12;
%     elseif time9(i)==21 && time9(i+1)~=epoch
%         pos(index)=i;
%         index=index+1;
%     else
%         continue
%     end
% end
end
