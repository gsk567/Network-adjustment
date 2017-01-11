classdef TSStation < handle

    properties
        Number;
        InstrumentHeight;
        GivenByKOR = false;
        Measurements;
    end
    
    methods
        function obj = TSStation(number, instrumentHeight)
            obj.Number = number;
            obj.InstrumentHeight = instrumentHeight;
            if (obj.Number > 999)
            	obj.GivenByKOR = true;
            end
  
        end
       
        function meas = FindMeasurement(obj, number)
            
           for i = 1:1:length(obj.Measurements)
              if (obj.Measurements(i).EndPoint == number)
                 meas = obj.Measurements(i);
                 break;
              else
                 meas = [];
              end
              
           end
        end
    end
    
end

