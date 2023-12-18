function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)

    numberOfCities = length(visibility);
    startNode = randi(numberOfCities); 
    
    tabuList = startNode; 
    path = startNode; 
    while length(tabuList) < numberOfCities
        nextNode = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta);
        tabuList = [tabuList, nextNode]; 
        path = [path, nextNode];
    end
    
end

