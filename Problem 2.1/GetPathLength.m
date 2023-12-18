function pathLength = GetPathLength(path,cityLocation)
    
    pathLength = 0;
    for i = 1:(length(path)-1)
        currentNode = path(i);
        nextNode = path(i+1);
        xCurrent = cityLocation(currentNode, 1);
        xNext = cityLocation(nextNode, 1);
        
        yCurrent = cityLocation(currentNode, 2);
        yNext = cityLocation(nextNode, 2);
        
        distanceBetweenNodes = sqrt((xNext-xCurrent)^2+(yNext-yCurrent)^2);
        pathLength = pathLength + distanceBetweenNodes;
    end
    
    originNode = path(1);
    lastNode = path(end);
    
    xOrigin = cityLocation(originNode, 1);
    xLast = cityLocation(lastNode, 1);
    
    yOrigin = cityLocation(originNode, 2);
    yLast = cityLocation(lastNode, 2);
    
    distanceLastToOrigin = sqrt((xLast-xOrigin)^2+(yLast-yOrigin)^2);
    pathLength = pathLength + distanceLastToOrigin;
    
end

