%% RunPSO
% Leonard Smedenman
clear
close
clc

numberOfParticles = 40;
numberOfDimensions = 2;

xMin = -5;
xMax = 5;

alpha = 1;
deltaT = 1;

vMax = xMax/deltaT;

c1 = 2;
c2 = 2;

inertiaWeight = 1.4;
inertiaMinimum = 0.35;
beta = 0.999;

particleBestValues = inf * ones(numberOfParticles, 1);
particleBestPositions = zeros(numberOfParticles, 2);

swarmBestValue = inf;
swarmBestPosition = zeros(1, 2);

numberOfRuns = 10000;

positions = InitializePositions(xMin, xMax, numberOfParticles, numberOfDimensions);
velocities = InitializeVelocities(xMin, xMax, alpha, deltaT, numberOfParticles, numberOfDimensions);

for run = 1:numberOfRuns

    evaluationValue = zeros(numberOfParticles, 1);

    for i = 1:numberOfParticles
        x1 = positions(i, 1);
        x2 = positions(i, 2);
        evaluationValue(i) = EvaluationFunction(x1, x2);

        if evaluationValue(i) < particleBestValues(i)
            particleBestValues(i) = evaluationValue(i);
            particleBestPositions(i, :) = positions(i);
        end

        if evaluationValue(i) < swarmBestValue
            swarmBestValue = evaluationValue(i);
            swarmBestPosition = positions(i, :);
        end
        
    end

    velocities = UpdateVelocities(positions, particleBestPositions, swarmBestPosition, velocities, c1, c2, deltaT, vMax, inertiaWeight, numberOfParticles, numberOfDimensions);
    positions = UpdatePositions(positions, velocities, deltaT, numberOfParticles, numberOfDimensions);

    if inertiaWeight > inertiaMinimum
        inertiaWeight = inertiaWeight * beta;
    end
    
end   

load('BestPositions.mat')
ContourPlot(BestPositions)

