function [station, res] = FindStation(stationArray,stationNumber)

    for i = 1:1:length(stationArray)
        if (stationArray(i).Number == stationNumber)
            station = stationArray(i);
            res = 1;
            break;
        else
            station = [];
            res = -1;
        end
    end

end
