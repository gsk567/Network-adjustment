classdef Measurement < handle

    properties
        StartPoint;
        EndPoint;
        Direction;
        ZenithAngle;
        SlopeDistance;
        SignalHeight;
        HorizontalDistance;
        CollimationError;
        IndexError;
        DistanceDifference;
    end
    
    methods
        function obj = Measurement(startPoint, endPoint, directions, zenithAngles, slopeDistances, signalHeight)
            if (length(directions) > 1)
            obj.StartPoint = startPoint;
            obj.EndPoint = endPoint;
            obj.SignalHeight = signalHeight;
            obj.IndexError = IndexError(zenithAngles(1),zenithAngles(2));
            obj.SlopeDistance = mean(slopeDistances);
            
            if (zenithAngles(1) < zenithAngles(2)) 
                obj.CollimationError = CollimationError(directions(1),directions(2));
                obj.Direction = directions(1) - obj.CollimationError;
                obj.ZenithAngle = zenithAngles(1) - obj.IndexError;
                obj.DistanceDifference = slopeDistances(1) - slopeDistances(2); 
            else                
                obj.CollimationError = CollimationError(directions(2),directions(1));
                obj.Direction = directions(2) - obj.CollimationError;
                obj.ZenithAngle = zenithAngles(2) - obj.IndexError;
                obj.DistanceDifference = slopeDistances(2) - slopeDistances(1); 
            end            
            obj.HorizontalDistance = obj.SlopeDistance*sin(obj.ZenithAngle/(200/pi)); 

            else
                obj.StartPoint = startPoint;
                obj.EndPoint = endPoint;
                obj.SignalHeight = signalHeight;
                obj.SlopeDistance = slopeDistances;
                obj.Direction = directions;
                obj.ZenithAngle = zenithAngles;
                obj.HorizontalDistance = obj.SlopeDistance*sin(obj.ZenithAngle/(200/pi)); 
            end
            
            if (obj.Direction < 0)
                obj.Direction = obj.Direction + 400;
            end
            
            if (obj.ZenithAngle < 0)
                obj.ZenithAngle = obj.ZenithAngle + 400;
            end
            
        end
    
    end

end