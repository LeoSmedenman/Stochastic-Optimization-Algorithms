function [yHat, error] = EvaluateChromosome(chromosome, numberOfDataPoints, numberOfVariableRegisters, numberOfConstantRegisters, constantRegisters, xk, yk)
    
    registers = zeros(1, numberOfVariableRegisters + numberOfConstantRegisters);
    yHat = zeros(size(yk));

    for k = 1:numberOfDataPoints
        registers(1) = xk(k);  
        registers(numberOfVariableRegisters+1) = constantRegisters(1);
        registers(numberOfVariableRegisters+2) = constantRegisters(2);
        registers(numberOfVariableRegisters+3) = constantRegisters(3);
        
        for j = 1:4:length(chromosome)
            operator = chromosome(j); 
            destination = chromosome(j+1);
            operand1 = registers(chromosome(j+2));
            operand2 = registers(chromosome(j+3));

            switch operator
            case 1  % '+'
                result = operand1 + operand2;
                
            case 2  % '-'
                result = operand1 - operand2;
                
            case 3  % '*'
                result = operand1 * operand2;

            case 4  % '/'
                if operand2 == 0
                    result = 10^12;  
                else
                    result = operand1 / operand2;
                end
            end

            registers(destination) = result;

            yHat(k) = registers(1);
        end
    end
    error = sqrt(1/numberOfDataPoints*sum((yHat - yk).^2));

end