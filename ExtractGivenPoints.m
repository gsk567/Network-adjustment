function givenPointsArray = ExtractGivenPoints(pointsArray, rawCoordinates)

    j = 1;
    for i = 1:1:length(pointsArray)
        if (~strcmp(pointsArray(i).Type,'Detail point'))
            givenPointsArray(j,:) = pointsArray(i);
            j = j + 1;
        end
    end
    
    for i = 1:1:length(givenPointsArray(:,1))
       givenPointNumber = givenPointsArray(i).Number;
       indexAtKOR = find(rawCoordinates(:,1) == givenPointNumber);
       
       if (isempty(indexAtKOR) == false)
           givenPointsArray(i).CoordX = rawCoordinates(indexAtKOR,2);
           givenPointsArray(i).CoordY = rawCoordinates(indexAtKOR,3);
       end
       
    end

end

