function StoreBestChromosome(bestIndividual, numberOfDataPoints, numberOfVariableRegisters, numberOfConstantRegisters, constantRegisters, xk, yk)
    
    if exist('BestChromosome.mat', 'file')
        load('BestChromosome.mat', 'bestChromosome');
        
        [~, errorStoredChromosome] = EvaluateChromosome(bestChromosome, numberOfDataPoints, numberOfVariableRegisters, numberOfConstantRegisters, constantRegisters, xk, yk);
        [~, errorNewChromosome] = EvaluateChromosome(bestIndividual, numberOfDataPoints, numberOfVariableRegisters, numberOfConstantRegisters, constantRegisters, xk, yk);
        
        if errorNewChromosome < errorStoredChromosome
            bestChromosome = bestIndividual;
            save('BestChromosome.mat', 'bestChromosome');
        end
    else
        bestChromosome = bestIndividual;
        save('BestChromosome.mat', 'bestChromosome');
    end

    fid = fopen('BestChromosome.m', 'w');
    fprintf(fid, 'bestChromosome = [');
    fprintf(fid, '%d ', bestChromosome);
    fprintf(fid, '];\n');
    fclose(fid);
end
