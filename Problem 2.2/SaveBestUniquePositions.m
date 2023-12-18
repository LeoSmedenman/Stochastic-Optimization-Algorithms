function SaveBestUniquePositions(swarmBestPosition, swarmBestValue)
    
    if isfile('BestPositions.mat')
        load('BestPositions.mat', 'BestPositions');
    else
        BestPositions = [];
    end

    tolerance = 1e-2;
    isDuplicate = any(max(abs(BestPositions(:, 1:2) - swarmBestPosition), [], 2) < tolerance);

    if ~isDuplicate
        BestPositions = [BestPositions; [swarmBestPosition, swarmBestValue]];
    end

    save('BestPositions.mat', 'BestPositions');

end

