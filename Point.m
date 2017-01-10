classdef Point < handle
    
    properties
    Number;
    CoordX = [];
    CoordY = [];
    Outline = [];
    Type;
    Given = false;
    GivenByKOR = false;
    ComputedMainMethod = false;
    CanBePartOfPolygon;
    ComputedX = [];
    ComputedY = [];
    ComputationMethod = {};
    CorrectionX;
    CorrectionY;
    CorrectionO;
    RMSX;
    RMSY;
    RMS;
    RMSO;
    EllipseAxisA;
    EllipseAxisB;
    EllipsePhi;
    end
    
    methods
        function obj = Point(number)
            obj.Number = number;
            
            if (obj.Number <= 999)
               obj.Type = 'New point';
            elseif(obj.Number > 999)
               obj.Type = 'Reference point';
               obj.Given = true;
               obj.GivenByKOR = true;
            end
     
        end
        
        function ComputeOutline(obj,network)
            
            if (obj.Given == false)
               return; 
            end            
            
            doubleSightConnections = network.FindConnection(obj.Number,true);
            oneSightConnections = network.FindConnection(obj.Number,false); 
            
            allConnections = [doubleSightConnections;oneSightConnections];
            outlines = [];
            j = 1;
            for i = 1:1:length(allConnections)
                if (allConnections(i).Point2.Given == true)
                    alpha = AlphaFromCoords(obj.CoordX,obj.CoordY, ...
                        allConnections(i).Point2.CoordX,allConnections(i).Point2.CoordY);
                    currentOutline = alpha - allConnections(i).Direction1;
                    
                    if (currentOutline < 0)
                        currentOutline = currentOutline + 400;
                    end
                    
                    outlines(j,1) = currentOutline;  
                end
            end
            
            if (isempty(outlines) == false)
                obj.Outline = mean(outlines);
            end

        end
        
        function AddComputedCoords(obj,x,y,network,string)
            
           if (isempty(obj.ComputedX) && isempty(obj.ComputedY))
               obj.ComputedX = x;
               obj.ComputedY = y;
               obj.ComputationMethod{1,1} = string;
           else
               obj.ComputedX(length(obj.ComputedX)+1,:) = x;
               obj.ComputedY(length(obj.ComputedY)+1,:) = y;
               obj.ComputationMethod{length(obj.ComputationMethod)+1,1} = string;
           end
           
           if (obj.GivenByKOR == false)
               obj.CoordX = mean(obj.ComputedX);
               obj.CoordY = mean(obj.ComputedY);
               ComputeOutline(obj,network);
               obj.Given = true;
           end
           
           if (isempty(obj.Outline))
               ComputeOutline(obj,network);
           end
 
        end
        
        function AddCorrectionIntoCoordinates(obj)
            if (obj.GivenByKOR == false)
                obj.CoordX = obj.CoordX + obj.CorrectionX;
                obj.CoordY = obj.CoordY + obj.CorrectionY;
            end
                
        end
        
        function AddOutlineCorrection(obj)
        	obj.Outline = obj.Outline + obj.CorrectionO;
            if (obj.Outline > 400)
                obj.Outline = obj.Outline - 400;
            elseif (obj.Outline < 0)
                obj.Outline = obj.Outline + 400;
            end
        end
        
    end
    
    
    
end

