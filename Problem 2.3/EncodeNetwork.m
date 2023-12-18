function chromosome = EncodeNetwork(wIH, wHO, wMax)

    wIHScaled = (wIH + wMax) / (2 * wMax);
    wIH = wIHScaled(:); 

    wHOScaled = (wHO + wMax) / (2 * wMax); 
    wHO = wHOScaled(:); 

    chromosome = [wIH; wHO];
    
end