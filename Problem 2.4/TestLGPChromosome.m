clear
close
clc

constantRegisters = [1, 2, -1];
numberOfConstantRegisters = length(constantRegisters);
numberOfVariableRegisters = 3;

functionData = LoadFunctionData;
xk = functionData(:,1);
yk = functionData(:,2);
numberOfDataPoints = length(functionData);


load('BestChromosome.mat', 'bestChromosome')

% in case the .mat file doesnt work, uncomment line below.
%bestChromosome = [1 3 6 1 3 2 3 5 4 3 3 5 2 3 6 5 4 1 6 5 1 2 1 2 1 2 2 5 3 1 2 5 3 3 1 3 1 2 2 5 1 3 6 3 1 3 6 3 1 1 4 3 4 1 1 2 1 3 1 2 4 3 1 3 3 1 2 2 1 1 1 3 4 3 1 3 4 1 2 1 2 2 1 6 1 3 6 2 4 1 3 2 1 1 3 1 4 3 6 3 ];
[yHat, error] = EvaluateChromosome(bestChromosome, numberOfDataPoints, numberOfVariableRegisters, numberOfConstantRegisters, constantRegisters, xk, yk);

plot(xk, yk, '--b')
hold on
plot(xk, yHat, 'r')
legend('Function', 'Function Estimate', 'location', 'best')
title('Function Fitting')
g = GetFunctionEstimate(bestChromosome, numberOfVariableRegisters, numberOfConstantRegisters, constantRegisters);
disp(g)
fprintf('Error of function estimate: %f \n', error)

