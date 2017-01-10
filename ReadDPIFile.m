function stationArray = ReadDPIFile(fileDirectory)

    fid = fopen(fileDirectory);
    i = 1;
    dpiLine = fgets(fid);
    while ischar(dpiLine)
        A{i,:} = dpiLine;
        i = i + 1;
        dpiLine = fgets(fid); 
    end
    fclose(fid);

    i = 4;
    j = 1;
    k = 1;
    while (i < length(A))
        while (isempty(strfind(A{i},'*')))
            if (j == 1)
                currentLine = textscan(A{i},'%f %f');
                stationArray(k,:) = TSStation(currentLine{1},currentLine{2});
            else
                currentLine = textscan(A{i},'%f %f %f %f %f');
                currentMeasurementArray(j-1,:) = ...
                    TSMeasurement(currentLine{1},currentLine{2}, ... 
                    currentLine{3}, currentLine{4}, currentLine{5}); 
            end
            j = j + 1;
           i = i + 1;
        end
        currentLine = textscan(A{i},'%d %f %f %f %f');
        currentMeasurementArray(j-1,:) = ...
            TSMeasurement(currentLine{1},currentLine{2}, ... 
            currentLine{3}, currentLine{4}, currentLine{5}); 
            
        stationArray(k).Measurements = currentMeasurementArray;
        i = i + 1; 
        k = k + 1;
        j = 1;
        clear currentMeasurementArray;
    end

end
