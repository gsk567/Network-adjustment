function stationArray = MeasurementsPreProccessing(rawStationArray)


    for i = 1:1:length(rawStationArray)
        array = zeros(length(rawStationArray(i).Measurements),6);
        
        for j = 1:1:length(rawStationArray(i).Measurements)
            array(j,1) = rawStationArray(i).Number;
            array(j,2) = rawStationArray(i).Measurements(j).Number;
            array(j,3) = rawStationArray(i).Measurements(j).SignalHeight;
            array(j,4) = rawStationArray(i).Measurements(j).HorizontalDirection;
            array(j,5) = rawStationArray(i).Measurements(j).ZenithAngle;
            array(j,6) = rawStationArray(i).Measurements(j).SlopeDistance;
        end
        
        uniqueALines = unique(array(:,1:3),'rows');
        
        for j = 1:1:length(uniqueALines(:,1))
            currentIndexes = find((array(:,1) == uniqueALines(j,1)) & ...
                (array(:,2) == uniqueALines(j,2)) & ...
                (array(:,3) == uniqueALines(j,3)));
          
            currentA = array(currentIndexes,:);

            currentStationMeasurements(j,:) = Measurement(currentA(1,1), currentA(1,2), ...
            currentA(:,4), currentA(:,5), ...
            currentA(:,6), currentA(1,3));
        end
        
        stationArray(i,:) = TSStation(rawStationArray(i).Number, rawStationArray(i).InstrumentHeight);
        stationArray(i,:).Measurements = currentStationMeasurements;
        clear currentStationMeasurements;
        
    end

end

