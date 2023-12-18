clear
close
clc

%% LGP parameters
populationSize = 40;
numberOfGenerations = 1000000;
maxGenerationsWithoutImprovement = 0.1*numberOfGenerations;

tournamentProbability = 0.8;
tournamentSize = 3;

crossoverProbability = 0.75;

operators = ['+', '-', '*', '/'];
numberOfOperators = length(operators);

constantRegisters = [1, 2, -1];
numberOfConstantRegisters = length(constantRegisters);

numberOfVariableRegisters = 3;

functionData = LoadFunctionData;
xk = functionData(:,1);
yk = functionData(:,2);
numberOfDataPoints = length(functionData);

minChromosomeLength = 4;
maxChromosomeLength = 100;

%% RunLGP
population = InitializePopulation(populationSize, minChromosomeLength, maxChromosomeLength, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators);
bestFitness = 0;  
bestIndividual = [];
generationsWithoutImprovement = 0; 

for generation = 1:numberOfGenerations

    if isempty(bestIndividual)
    
    else
        population(1).Chromosome = bestIndividual;
    end
    
    fitnessList = EvaluatePopulation(population, constantRegisters, numberOfConstantRegisters, numberOfVariableRegisters, xk, yk, maxChromosomeLength);    
    [maxFitness, maxIndividualIndex] = max(fitnessList);
    
    if maxFitness > bestFitness 
        bestFitness = maxFitness;
        bestIndividual = population(maxIndividualIndex).Chromosome;
        generationsWithoutImprovement = 0; 
    end
    
    populationAfterCrossover = population;
    
    tournamentContenders = zeros(1, tournamentSize);
    for i=1:tournamentSize:populationSize
        i1 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
        i2 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
        
        individual1 = population(i1).Chromosome;
        individual2 = population(i2).Chromosome;
        newIndividuals = TwoPointCrossover(individual1, individual2);
        
        populationAfterCrossover(i1).Chromosome = newIndividuals(1).genes;
        populationAfterCrossover(i2).Chromosome = newIndividuals(2).genes;
    end
         
    fitnessListAfterCrossover = EvaluatePopulation(populationAfterCrossover, constantRegisters, numberOfConstantRegisters, numberOfVariableRegisters, xk, yk, maxChromosomeLength);
    [maxFitnessAfterCrossover, idxAfterCrossover] = max(fitnessListAfterCrossover);
    
    if maxFitnessAfterCrossover > bestFitness 
        bestFitness = maxFitnessAfterCrossover;
        bestIndividual = populationAfterCrossover(idxAfterCrossover).Chromosome;
        generationsWithoutImprovement = 0; 
    end
    
    populationAfterMutation = populationAfterCrossover;
    
    for i = 1:populationSize
        chromosome = populationAfterMutation(i).Chromosome;
        mutationProbability = 1/(length(chromosome))- 1/(4*length(chromosome))*generation/numberOfGenerations;
        mutatedIndividual = Mutate(chromosome, mutationProbability, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators);
        populationAfterMutation(i).Chromosome = mutatedIndividual;
    end
    
    fitnessListAfterMutation = EvaluatePopulation(populationAfterMutation, constantRegisters, numberOfConstantRegisters, numberOfVariableRegisters, xk, yk, maxChromosomeLength);
    [maxFitnessAfterMutation, idxAfterMutation] = max(fitnessListAfterMutation);
    
    if maxFitnessAfterMutation > bestFitness
        bestFitness = maxFitnessAfterMutation;
        bestIndividual = populationAfterMutation(idxAfterMutation).Chromosome;
        generationsWithoutImprovement = 0; 
    else
        generationsWithoutImprovement = generationsWithoutImprovement + 1;
    end
    
    if generationsWithoutImprovement > maxGenerationsWithoutImprovement
        disp('Resetting Population')
        
        bestThreeIndividualsLastGeneration = struct('Chromosome', cell(1, 4));
        [~, sortedIndividuals] = sort(fitnessList, 'descend');
        for j = 1:3
            bestThreeIndividualsLastGeneration(j).Chromosome = population(sortedIndividuals(j)).Chromosome;
        end
        
        population = InitializePopulation(populationSize, minChromosomeLength, maxChromosomeLength, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators);
        population(1).Chromosome = bestIndividual;
        
        for j = 1:3
            population(j + 1).Chromosome = bestThreeIndividualsLastGeneration(j).Chromosome;
        end
        
        generationsWithoutImprovement = 0;
    end
    
    if mod(generation, 1000) == 0
        disp(['Generation: ' num2str(generation) ', Best Fitness: ' num2str(bestFitness)]);
    end
    
end

StoreBestChromosome(bestIndividual, numberOfDataPoints, numberOfVariableRegisters, numberOfConstantRegisters, constantRegisters, xk, yk)
 

