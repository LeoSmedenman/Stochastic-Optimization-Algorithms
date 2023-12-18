function mutatedIndividual = Mutate(chromosome, mutationProbability, numberOfVariableRegisters, numberOfConstantRegisters, numberOfOperators)
    
    mutatedIndividual = chromosome;
    numberOfInstructions = length(mutatedIndividual)/4;

    for i = 1:4:numberOfInstructions
        r = rand;
        if (r < mutationProbability)
            mutatedIndividual(i) = randi(numberOfOperators);
        end
        
        r = rand;
        if (r < mutationProbability)
            mutatedIndividual(i+1) = randi(numberOfVariableRegisters);
        end
        
        r = rand;
        if (r < mutationProbability)
            mutatedIndividual(i+2) = randi(numberOfConstantRegisters + numberOfVariableRegisters);
        end
        
        r = rand;
        if (r < mutationProbability)
            mutatedIndividual(i+3) = randi(numberOfConstantRegisters + numberOfVariableRegisters);
        end
    end
end