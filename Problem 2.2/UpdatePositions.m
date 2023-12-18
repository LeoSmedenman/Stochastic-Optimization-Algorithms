function updatedPositions = UpdatePositions(positions, velocities, deltaT, numberOfParticles, numberOfDimensions)

    updatedPositions = zeros(numberOfParticles, numberOfDimensions);
    
    for i  = 1:numberOfParticles
        for j = 1:numberOfDimensions
            updatedPositions(i,j) = positions(i,j) + velocities(i,j)*deltaT;
        end
    end
    
end

