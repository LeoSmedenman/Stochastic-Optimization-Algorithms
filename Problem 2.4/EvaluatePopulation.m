function fitnessList = EvaluatePopulation(population, constantRegisters, numberOfConstantRegisters, numberOfVariableRegisters, xk, yk, maxChromosomeLength)
  
    numberOfDataPoints = length(xk);
    
    fitnessList = zeros(1, length(population));
    
    for i = 1:length(population)
        chromosome = population(i).Chromosome;
        if isempty(chromosome)
           
        else
            [~, error] = EvaluateChromosome(chromosome, numberOfDataPoints, numberOfVariableRegisters, numberOfConstantRegisters, constantRegisters, xk, yk);
            fitnessList(i) = 1/error;
            if length(chromosome) > maxChromosomeLength
                fitnessList(i) = 0.01;
            end
        end
    end

end