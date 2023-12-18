function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax)
    
    wIHLength = nHidden * (nIn + 1);
    wHOLength = nOut * (nHidden + 1);
    
    wIHPortion = chromosome(1:wIHLength);
    wHOPortion = chromosome(wIHLength+1:wIHLength+wHOLength);
    
    wIH = reshape(wIHPortion, nHidden, nIn + 1);
    wHO = reshape(wHOPortion, nOut, nHidden + 1);
    
    wIH = 2 * wMax * wIH - wMax;
    wHO = 2 * wMax * wHO - wMax;
end
