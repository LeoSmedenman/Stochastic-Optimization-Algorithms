function newIndividuals = TwoPointCrossover(individual1, individual2)
    
    lengthIndividual1 = length(individual1);
    lengthIndividual2 = length(individual2);
    
    numberOfInstructionsIndividual1 = lengthIndividual1/4;
    numberOfInstructionsIndividual2 = lengthIndividual2/4;

    crossoverPointsIndividual1 = zeros(1, 2);
    crossoverPointsIndividual1(1) = 4 * randi([0, numberOfInstructionsIndividual1 - 1]);
    crossoverPointsIndividual1(2) = 4 * randi([0, numberOfInstructionsIndividual1 - 1]);

    crossoverPointsIndividual2 = zeros(1, 2);
    crossoverPointsIndividual2(1) = 4 * randi([0, numberOfInstructionsIndividual2 - 1]);
    crossoverPointsIndividual2(2) = 4 * randi([0, numberOfInstructionsIndividual2 - 1]);

    crossoverPointsIndividual1 = sort(crossoverPointsIndividual1);
    crossoverPointsIndividual2 = sort(crossoverPointsIndividual2);
    
    genesToBeCrossedIndividual1 = individual1(crossoverPointsIndividual1(1)+1:crossoverPointsIndividual1(2));
    genesToBeCrossedIndividual2 = individual2(crossoverPointsIndividual2(1)+1:crossoverPointsIndividual2(2));

    newIndividual1.genes = [individual1(1:crossoverPointsIndividual1(1)), genesToBeCrossedIndividual2, individual1(crossoverPointsIndividual2(2)+1:end)];
    newIndividual2.genes = [individual2(1:crossoverPointsIndividual2(1)), genesToBeCrossedIndividual1, individual2(crossoverPointsIndividual2(2)+1:end)];

    newIndividuals = [newIndividual1; newIndividual2];
end
