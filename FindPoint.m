function [point, res] = FindPoint(pointsArray,pointNumber)

    for i = 1:1:length(pointsArray)
        if (pointsArray(i).Number == pointNumber)
            point = pointsArray(i);
            res = 1;
            break;
        else
            point = [];
            res = -1;
        end
    end

end

