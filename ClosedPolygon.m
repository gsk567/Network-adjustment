classdef ClosedPolygon < handle

    properties
        Points;
        Fb;
        FbA;
        Fx;
        Fy;
        Fs;
        FsA;
        Computed = false;
    end
    
    methods
        function obj = ClosedPolygon(netPoints,points)
            for i = 1:1:length(points)-1
                currentPolygon(i,:) = findobj(netPoints,'Number',points(i));
            end
            
            obj.Points = currentPolygon;
        end
        
        function points = GetPolygonPoints(obj)
            for i = 1:1:length(obj.Points)
                points(i,1) = obj.Points(i).Number;
            end
        end
        
        function ProcessPolygon(obj,network)
        	testFixed = 0;
            for i = 1:1:length(obj.Points)
            	if (obj.Points(i).Given == true && isempty(obj.Points(i).Outline) == false)
                    testFixed = testFixed + 1;
            	end
            end

            if (testFixed == 0)
                return;
            end
            
            for i = 1:1:length(obj.Points)
               currentPointConnections = network.FindConnection(obj.Points(i).Number,true);
               if (i == 1)
                   neighbors(1) = obj.Points(length(obj.Points)).Number;
                   neighbors(2) = obj.Points(2).Number;
               elseif (i == length(obj.Points))
                   neighbors(1) = obj.Points(length(obj.Points)-1).Number;
                   neighbors(2) = obj.Points(1).Number;
               else
                   neighbors(1) = obj.Points(i-1).Number;
                   neighbors(2) = obj.Points(i+1).Number;
               end
              
               for j = 1:1:length(currentPointConnections)
                  if (currentPointConnections(j).Point2.Number == neighbors(1))
                      backsideConnection = currentPointConnections(j);
                  elseif (currentPointConnections(j).Point2.Number == neighbors(2))
                      frontsideConnection = currentPointConnections(j);
                  end
               end
               
               needData(i,1) = obj.Points(i).Number;
               needData(i,2) = neighbors(1);
               needData(i,3) = neighbors(2);
               needData(i,4) = backsideConnection.Direction1;
               needData(i,5) = frontsideConnection.Direction1;
               needData(i,6) = backsideConnection.Distance;
               needData(i,7) = frontsideConnection.Distance;
               if (isempty(obj.Points(i).Outline) == false)
                   needData(i,8) = obj.Points(i).Outline;
                   needData(i,9) = obj.Points(i).CoordX;
                   needData(i,10) = obj.Points(i).CoordY;
               else
                   needData(i,8) = -1;
                   needData(i,9) = -1;
                   needData(i,10) = -1;
               end
               
            end
            
            [numbers,coordsX,coordsY,obj.Fb,obj.FbA,obj.Fx,obj.Fy,obj.Fs,obj.FsA] = ...
                ComputeClosedPolygon(needData);
            
            pString = ['Closed Polygon'];
            for i = 1:1:length(numbers)
               pString = [pString,' ',num2str(numbers(i))]; 
            end
            
            for i = 1:1:length(obj.Points)
                currentPointNumber = obj.Points(i).Number;
                pIndex = find(numbers(:,1) == currentPointNumber);
                pX = coordsX(pIndex);
                pY = coordsY(pIndex);
                obj.Points(i).AddComputedCoords(pX, pY, network, pString);
            end
            
            obj.Computed = true;
            
        end
 
    end
    
end

