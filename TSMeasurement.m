classdef TSMeasurement
    
    properties
        Number;
        SignalHeight;
        HorizontalDirection;
        ZenithAngle;
        SlopeDistance;
    end
    
    methods
        function obj = TSMeasurement(number,signalHeight, horizontalDirection, zenithAngle, slopeDistance)
            obj.Number = number;
            obj.SignalHeight = signalHeight;
            obj.HorizontalDirection = horizontalDirection;
            obj.ZenithAngle = zenithAngle;
            obj.SlopeDistance = slopeDistance;
       end
    end
    
end

