function velocities = InitializeVelocities(xMin, xMax, alpha, deltaT, numberOfParticles, numberOfDimensions)
    
    velocities = zeros(numberOfParticles, numberOfDimensions);
    
    for i = 1:numberOfParticles
        for j = 1:numberOfDimensions
            r = rand;
            velocities(i,j) = alpha/deltaT*(-(xMax-xMin)/2 + r*(xMax-xMin));
        end
    end
end

