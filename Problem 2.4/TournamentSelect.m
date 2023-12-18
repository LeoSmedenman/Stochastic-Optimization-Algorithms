function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)
    
    populationSize = length(fitnessList);
    tournamentContenders = randi(populationSize, 1, tournamentSize);
    contenderFitness = fitnessList(tournamentContenders);
    
    [~, sortedIndices] = sort(contenderFitness, 'descend');

    for j = 1:tournamentSize-1
        r = rand;
        if r < tournamentProbability
            selectedIndividualIndex = tournamentContenders(sortedIndices(j));
            return
        end
    end
    
    selectedIndividualIndex = tournamentContenders(sortedIndices(end));
end




