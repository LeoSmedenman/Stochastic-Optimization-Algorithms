function nextNode = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta)
    
    numberOfNodes = length(visibility);
    
    currentNode = tabuList(end);
    
    probabilities = zeros(1, numberOfNodes);
    unvisitedNodes = setdiff(1:numberOfNodes, tabuList);
    
    sumProbabilities = 0;  
    
    for i = unvisitedNodes
        probabilities(i) = (pheromoneLevel(currentNode, i)^(alpha) * visibility(currentNode, i)^(beta));
        sumProbabilities = sumProbabilities + probabilities(i);  % Update the sum of probabilities
    end
    
    probabilities(unvisitedNodes) = probabilities(unvisitedNodes) / sumProbabilities;
    
    %implementing simple RWS
    r = rand();
    
    cumulativeProbability = 0;
    for i = unvisitedNodes
        
        cumulativeProbability = cumulativeProbability + probabilities(i);
        if cumulativeProbability > r
            nextNode = i;
            return
        end
        
    end
        
end
        

