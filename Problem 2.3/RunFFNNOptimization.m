function [deltaGear, Pp] = RunFFNNOptimization(v, alpha, Tb, chromosome)
    vMax = 25;
    alphaMax = 10;
    TbMax = 750;
    nIn = 3;
    nHidden = 4;
    nOut = 2;
    wMax = 5;
    c = 3;

    inputs = [v/vMax, alpha/alphaMax, Tb/TbMax];

    [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);

   
    for row = 1:size(wIH, 1)
        bias = wIH(row, nIn + 1);
        s = 0;
        s = wIH(row, 1:nIn) .* inputs;
        sumSIH = sum(s) + bias;
        V(row) = 1 / (1 + exp(-c * sumSIH));
    end

    for row = 1:size(wHO, 1)
        bias = wHO(row, nHidden + 1);
        s = 0;
        s = wHO(row, 1:nHidden) .* V;
        sumSHO = sum(s) + bias;
        output(row) = 1 / (1 + exp(-c * sumSHO));
    end
    
    deltaGear = output(1);
    Pp = output(2);

    if deltaGear < 0.3
        deltaGear = -1;
    elseif deltaGear > 0.7
        deltaGear = 1;
    else 
        deltaGear = 0;
    end
end
