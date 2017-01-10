classdef Connection < handle
    
    properties
        Point1;
        Point2;
        Distance;
        Direction1;
        Direction2;
        DoubleSight; 
    end
    
    methods
        function obj = Connection(point1, point2, points, measurements)
           obj.Point1 = findobj(points,'Number',point1);
           obj.Point2 = findobj(points,'Number',point2);
           currentStation = findobj(measurements,'Number',point1);
           currentMeasurement = findobj(currentStation.Measurements,'EndPoint',point2);

           reverseTest = false; 
           reverseStation = findobj(measurements,'Number',point2);
           if (~isempty(reverseStation))
               reverseMeasurement = findobj(reverseStation.Measurements,'EndPoint',point1);
               reverseTest = ~isempty(reverseMeasurement);
           end
           
           if (reverseTest == true)
               obj.DoubleSight = true;
               obj.Direction1 = currentMeasurement.Direction;
               obj.Direction2 = reverseMeasurement.Direction;
               obj.Distance = mean([currentMeasurement.HorizontalDistance, ...
                   reverseMeasurement.HorizontalDistance]);
           else
               obj.DoubleSight = false;
               obj.Direction1 = currentMeasurement.Direction;
               obj.Direction2 = [];
               obj.Distance = currentMeasurement.HorizontalDistance;                   
           end
           
        end
        

    end
    
end

