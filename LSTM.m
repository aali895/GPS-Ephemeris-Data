close all;
clc;
clear all;

load ('mean_anomaly.mat');
data = mean_anomaly;
% data=data(1:12:end);
% data=data.*10e9;
% data=data(1:180);
% data = [data{:}];

% figure
% plot(data)
% xlabel("Sample")
% ylabel("SemiMajor Axis")
% title("SemiMajor Axis")

% steps_train = floor(0.9*length(data));

steps_train=length(data);

data_train = data(1:steps_train);
% data_test = data(steps_train+1:end);

mu = mean(data_train);
sig = std(data_train);

dataTrainStandardized = (data_train - mu) / sig;

XTrain = dataTrainStandardized(1:end-1);
YTrain = dataTrainStandardized(2:end);


% XTrain=1:length(dataTrain);
% YTrain=dataTrainStandardized(1:end);

numFeatures = 1;
numResponses = 1;


numHiddenUnits = 250;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];

options = trainingOptions('adam', ...
    'MaxEpochs',300, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.005, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',125, ...
    'LearnRateDropFactor',0.2, ...
    'Verbose',1, ...
    'Plots','training-progress');

net = trainNetwork(XTrain,YTrain,layers,options);

% dataTestStandardized = (data_test - mu) / sig;
% XTest = dataTestStandardized(1:end-1);

net = predictAndUpdateState(net,XTrain);
[net,YPred] = predictAndUpdateState(net,YTrain(end));
% 
% numTimeStepsTest = numel(XTest);
% for i = 2:numTimeStepsTest
%     [net,YPred(:,i)] = predictAndUpdateState(net,YPred(:,i-1),'ExecutionEnvironment','cpu');
% end
% 

[net,YPred(:,2)] = predictAndUpdateState(net,YPred(:,1),'ExecutionEnvironment','cpu');
YPred = sig*YPred + mu;
% 
% YTest = data_test(2:end);
% rmse = sqrt(mean((YPred-YTest).^2))
% 
% figure
% plot(dataTrain(1:end-1))
% hold on
% idx = numTimeStepsTrain:(numTimeStepsTrain+numTimeStepsTest);
% plot(idx,[data(numTimeStepsTrain) YPred],'.-')
% hold off
% xlabel("Samples")
% % ylabel("Cases")
% title("Forecast")
% legend(["Observed" "Forecast"])
% 
% figure
% subplot(2,1,1)
% plot(YTest)
% hold on
% plot(YPred,'.-')
% hold off
% legend(["Observed" "Forecast"])
% % ylabel("Cases")
% xlabel('Sample')
% title("Semi-major Axis")
% % 
% subplot(2,1,2)
% stem(YPred - YTest)
% xlabel("Sample")
% ylabel("Error")
% title("RMSE = " + rmse)


%% TEST RMSE 

% figure
% subplot(2,1,1)
% plot(YTrain)
% hold on
% plot(YPred,'.-')
% hold off
% legend(["Observed" "Forecast"])
% % ylabel("Cases")
% xlabel('Sample')
% title("Semi-major Axis")
% % 
% subplot(2,1,2)
% stem(YPred - YTest)
% xlabel("Sample")
% ylabel("Error")
% title("RMSE = " + rmse)

%% update state

% net = resetState(net);
% net = predictAndUpdateState(net,XTrain);
% % 
% YPred = [];
% numTimeStepsTest = numel(XTest);
% for i = 1:numTimeStepsTest
%     [net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),'ExecutionEnvironment','cpu');
% end
% 
% YPred = sig*YPred + mu;
% 
% rmse = sqrt(mean((YPred-YTest).^2))
% 
% figure
% subplot(2,1,1)
% plot(YTest)
% hold on
% plot(YPred,'.-')
% hold off
% legend(["Observed" "Predicted"])
% title("Forecast with Updates")
% 
% subplot(2,1,2)
% stem(YPred - YTest)
% xlabel("Sample")
% ylabel("Error")
% title("RMSE = " + rmse)


%% filing
% fid=fopen('adam.txt','a+')
% fprintf(fid,'%d,%f\n',numHiddenUnits,rmse);
% fclose(fid);