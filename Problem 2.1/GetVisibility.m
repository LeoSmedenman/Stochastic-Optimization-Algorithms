function visibility = GetVisibility(cityLocation)
    
    numberOfNodes = length(cityLocation);
    
    visibility = zeros(length(cityLocation));
    for i=1:numberOfNodes
        for j = 1:numberOfNodes
            if i ~= j
                x_i = cityLocation(i,1);
                y_i = cityLocation(i,2);

                x_j = cityLocation(j,1);
                y_j = cityLocation(j,2);

                distance = sqrt((x_j-x_i)^2+(y_j-y_i)^2);
                visibility(i,j) = 1/distance;
            end
        end 
        
    end
    
end

