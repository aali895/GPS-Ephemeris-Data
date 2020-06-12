%                  col  2:    M0     ....... mean anomaly at reference time
%                  col  3:    delta_n  ..... mean motion difference
%                  col  4:    e      ....... eccentricity
%                  col  5:    sqrt(A)  ..... where A is semimajor axis
%                  col  6:    OMEGA  ....... LoAN at weekly epoch
%                  col  7:    i0     ....... inclination at reference time
%                  col  8:    omega  ....... argument of perigee
%                  col  9:    OMEGA_dot  ... rate of right ascension 
%                  col 10:    i_dot  ....... rate of inclination angle
% %                  col 11:    Cuc    ....... cosine term, arg. of latitude
%                  col 12:    Cus    ....... sine term, arg. of latitude
%                  col 13:    Crc    ....... cosine term, radius
%                  col 14:    Crs    ....... sine term, radius
%                  col 15:    Cic    ....... cosine term, inclination
%                  col 16:    Cis    ....... sine term, inclination
%                  col 17:    toe    ....... time of ephemeris
%                  col 18:    IODE   ....... Issue of Data Ephemeris
%                  col 19:    GPS_wk ....... GPS week
%                             toc=ephemeris(:,20);
%                             af0= ephemeris(:,21);
%                             af1= ephemeris(:,22);
%                             af2= ephemeris(:,23);
%                             TGD=ephemeris(:,24);
%% code execution
clc
clear all;
sat=2;            %% satellite number 
% epoch=1;
% for epoch=1:12
col_names=["mean_anomaly","mean_motion","eccentricity","semimajor_axis","OMEGA","inclination","perigee","right_ascension","inclination_angle","cuc","cus","crc","crs","cic","cis","IODE","af0","af1","af2","TGD"];
col_number=[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,21,22,23,24];
for iteration=1:20

col=col_number(iteration)        %% delta_n  ..... mean motion difference



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
load('data9.mat')
index=1;
for page=1:365
 for j=1:length(data9)
    if data9 (j,1,page)==sat
         val9(index)=data9 (j,col,page); % val9 stores data of 2019
         toe9(index)=data9 (j,17,page);
         index=index+1;
    end
end 
end

%% load 2020 data

index=1;
load ('data2.mat');
for page=1:134
 for j=1:length(data2)
    if data2 (j,1,page)==sat
         val2(index)=data2 (j,col,page); % val2 stores data of 2020
         toe2(index)=data2 (j,17,page);
         index=index+1;
    end
end 
end


%% error value removal
% [val81,toe81]=err_remove(val8,toe8);
% [val91,toe91]=err_remove(val9,toe9);
% [val21,toe21]=err_remove(val2,toe2);

% semi=[val81,val91,val21];
% toe_semi=[toe81,toe91,toe21];

  mean_anomaly92=[val9,val2];
% toe_semi=[toe91,toe21];

  val=mean_anomaly92;

% val=val2;


%% file saving 

% if epoch==1
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch1'
% elseif epoch==2
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch2'
% elseif epoch==3
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch3'
% elseif epoch==4
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch4'
% elseif epoch==5
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch5'
% elseif epoch==6
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch6'
% elseif epoch==7
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch7'
% elseif epoch==8
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch8'
% elseif epoch==9
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch9'
% elseif epoch==10
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch10'
% elseif epoch==11
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch11'
% elseif epoch==12
%     cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat1\epoch12'
% end


newName=col_names(iteration)
S.(newName)=val;
save(col_names(iteration),'-struct','S')

% filing
% fid=fopen('sat_epoch.txt','w+');
% fprintf(fid,'Satellite= ');
% fprintf(fid,'%d\r\n',sat);
% fprintf(fid,'Epoch= ');
% fprintf(fid,'%d\r\n',epoch);
% fclose(fid);

% length(val)
% length(toe)
% total=(365+103)*12


%% plot data
% figure
% plot(1:length(val81),val81)
% hold on
% plot((length(val81)+1):((length(val81)+length(val91))), val91)
% hold on
% plot((length(val91)+length(val81)+1):(length(val81)+length(val91)+length(val21)), val21)
% hold off
% title ('Semi Major Axis, Satellite 1')
% l=['Samples (total= ',num2str(length(val81)+length(val91)+length(val21)),')'];
% xlabel(l)
% ylabel('Semi Major Axis')
% legend ('Year 2018','Year 2019', 'Year 2020')

%% plot

%% plot data

% cd 'C:\Users\DELL-PC\Desktop\brdc\92 data_new\sat8'

% clearvars -except iteration sat
end
% epoch
% end

% fid=fopen('sat_epoch.txt','w+');
% fprintf(fid,'Satellite= ');
% fprintf(fid,'%d\r\n',sat);
% fprintf(fid,'Epoch= ');
% fprintf(fid,'%d\r\n',epoch);
% fclose(fid);