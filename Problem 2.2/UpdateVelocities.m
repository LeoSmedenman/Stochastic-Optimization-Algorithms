function updatedVelocities = UpdateVelocities(positions, particleBestPositions, swarmBestPosition, velocities, c1, c2, deltaT, vMax, inertia, numberOfParticles, numberOfDimensions)
    
    updatedVelocities = zeros(numberOfParticles, numberOfDimensions);
    
    for i = 1:numberOfParticles
        r = rand();
        q = rand();
        
        for j = 1:numberOfDimensions
            cognitiveComponent = c1*q*(particleBestPositions(i,j)- positions(i,j))/deltaT;
            socialComponent = c2*r*(swarmBestPosition(j)-positions(i,j))/deltaT;
            
            updatedVelocities(i,j) = inertia*velocities(i,j) + cognitiveComponent + socialComponent;
            
            if updatedVelocities(i,j) > vMax
                updatedVelocities(i,j) = vMax;
            elseif updatedVelocities(i,j) < -vMax
                updatedVelocities(i,j) = -vMax;
            end
            
        end
        
    end
    
end

