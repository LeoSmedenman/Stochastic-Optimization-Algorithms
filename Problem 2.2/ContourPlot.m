function ContourPlot(bestPositions)
    
    x1 = linspace(-5, 5);
    x2 = linspace(-5, 5);
    
    [x1, x2] = meshgrid(x1, x2);
    functionValue = (x1.^2+x2-11).^2+(x1+x2.^2-7).^2;
    a = 0.01;
    functionValueAdjusted = log(a + functionValue);
    
    contour(x1, x2, functionValueAdjusted, 50)
    hold on
    
    plot(bestPositions(:,1), bestPositions(:,2), 'xk', 'LineWidth', 2);

    title('Minimas to Objective Function')    
 
end