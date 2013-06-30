%% Machine Learning Online Class - Exercise 3 | Part 1: One-vs-all

%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear exercise. You will need to complete the following functions 
%  in this exericse:
%
%     lrCostFunction.m (logistic regression cost function)
%     oneVsAll.m
%     predictOneVsAll.m
%     predict.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% Setup the parameters you will use for this part of the exercise
input_layer_size  = 400;  % 20x20 Input Images of Digits
num_labels = 10;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset. 
%  You will be working with a dataset that contains handwritten digits.
%

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

%load('ex3data1.mat'); % training data stored in arrays X, y

data = csvread('train.csv');
%data = csvread('train-small.csv');

m = size(data, 1) - 1;
n = size(data, 2) - 1;
y = data(2:m+1,1);
X = data(2:m+1,2:1+n);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataTest = csvread('test.csv');
mTest = size(dataTest, 1);
nTest = size(dataTest, 2);
XTest = dataTest(2:mTest,:);

for i=1:length(y)
	if y(i) == 0
		y(i) = 10;
	end
end

fprintf('Loaded:  m: %i - n: %i\n', m, n);

% Randomly select 100 data points to display
rand_indices = randperm(m);

maxSize = m;
if maxSize > 15
	maxSize = 16;
end
fprintf('maxSize: %i\n', maxSize)
displayData(X(rand_indices(1:maxSize), :));
%displayData(X);

fprintf('Program paused. Press enter to continue.\n');
%pause;

%% ============ Part 2: Vectorize Logistic Regression ============
%  In this part of the exercise, you will reuse your logistic regression
%  code from the last exercise. You task here is to make sure that your
%  regularized logistic regression implementation is vectorized. After
%  that, you will implement one-vs-all classification for the handwritten
%  digit dataset.
%

fprintf('\nTraining One-vs-All Logistic Regression...\n')

lambda = 0.1;
[all_theta] = oneVsAll(X, y, num_labels, lambda);

fprintf('all_theta size: .\n');
size(all_theta)
%pause;


%% ================ Part 3: Predict for One-Vs-All ================
%  After ...
pred = predictOneVsAll(all_theta, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

size(all_theta)
size(X)
size(XTest)

predTest = predictOneVsAll(all_theta, XTest);


for i=1:length(predTest)
	if predTest(i) == 10
		predTest(i) = 0;
	end
end
csvwrite('test-results.csv',predTest);


p = predTest;
x = XTest;
for i=1:length(p)
	if p(i) == 10
		p(i) = 0;
	end
	fprintf('Predicted value: %i\n', p(i))
	displayData(x(i,:));
	pause;
end
