function pointsArray = ExtractPointsFromMeasurements(stationArray,rawCoordinates)

    k = 1;
    for i = 1:1:length(stationArray)
       for j = 1:1:length(stationArray(i).Measurements)
          array(k,1) = stationArray(i).Measurements(j).StartPoint;
          array(k,2) = stationArray(i).Measurements(j).EndPoint;
          k = k + 1;
       end
    end
    array = array(:);
    uniquePoints = unique(array);

    for i = 1:1:length(uniquePoints)
        pointsArray(i,:) = Point(uniquePoints(i));
    end
    
    for i = 1:1:length(pointsArray(:,1))
       pointNumber = pointsArray(i).Number;
       indexAtKOR = find(rawCoordinates(:,1) == pointNumber);
       
       if (isempty(indexAtKOR) == false)
           pointsArray(i).CoordX = rawCoordinates(indexAtKOR,2);
           pointsArray(i).CoordY = rawCoordinates(indexAtKOR,3);
       end
       
    end

end

