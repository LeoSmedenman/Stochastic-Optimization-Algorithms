function g = GetFunctionEstimate(chromosome, numberOfVariableRegisters, numberOfConstantRegisters, constantRegisters)
    
    numberOfRegisters = numberOfVariableRegisters + numberOfConstantRegisters;
    syms x;
    registers = sym('r', [1 numberOfRegisters]);
    registers(1) = x;
    registers(2) = 0;
    registers(3) = 0;
     
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
    end
    r1 = registers(1);
    g = simplifyFraction(r1,'Expand',true); 
end