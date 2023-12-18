function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
    
    [numberOfAnts, numberOfCities] = size(pathCollection);
    deltaPheromoneLevel = zeros(numberOfCities);
    
    for k = 1:numberOfAnts
       
        pathK = pathCollection(k,:);
        Dk = pathLengthCollection(k);
        
        for node = 1:numberOfCities-1
            departFrom = pathK(node);
            arriveTo = pathK(node+1);
            
            deltaPheromoneLevel(departFrom, arriveTo) = deltaPheromoneLevel(departFrom, arriveTo) + 1/Dk;
            
        end
        
    end
    
end

