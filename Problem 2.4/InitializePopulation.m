function population = InitializePopulation(populationSize, minChromosomeLength, maxChromosomeLength, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators)

    population = [];
    for i = 1:populationSize
        chromosomeLength = minChromosomeLength + fix(rand*(maxChromosomeLength - minChromosomeLength + 1));
        tmpChromosome = zeros(1, chromosomeLength);

        for j = 1:4:chromosomeLength
            tmpChromosome(j) = randi(numberOfOperators);
            tmpChromosome(j+1) = randi(numberOfVariableRegisters);
            tmpChromosome(j+2) = randi(numberOfConstantRegisters + numberOfVariableRegisters);
            tmpChromosome(j+3) = randi(numberOfConstantRegisters + numberOfVariableRegisters);
        end

        tmpIndividual = struct('Chromosome', tmpChromosome);
        population = [population tmpIndividual];
    end

end
