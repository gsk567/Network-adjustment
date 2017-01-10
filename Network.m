classdef Network < handle

    properties
        Points;
        CPPoints;
        Connections;
        ClosedPolygons;
        ComputationValidation;
        %LinkedPolygons;
        MaxCPPoints = 8;
        %MaxLPPoints = 8;
    end
    
    methods
        function obj = Network(points, measurements)
            
            obj.Points = points;
            k = 1;
            for i = 1:1:length(measurements)
               for j = 1:1:length(points)

                   currentStation = findobj(measurements,'Number',measurements(i).Number);
                   currentMeasurement = findobj(currentStation.Measurements,'EndPoint',points(j).Number);
                   if (~isempty(currentMeasurement))
                        connections(k,:) = Connection(measurements(i).Number, points(j).Number, points, measurements);
                        k = k + 1;
                   end 
               end
            end
            obj.Connections = connections;

            end

        function connections = FindConnection(obj, point, doubleSight)
            j = 1;
            for i = 1:1:length(obj.Connections)
                if (obj.Connections(i).Point1.Number == point && obj.Connections(i).DoubleSight == doubleSight)
                    connections(j,:) = obj.Connections(i);
                    j = j + 1;
                end
            end
            if (j == 1)
               connections = []; 
            end
        end
        
        function connections = FindAllConnections(obj, point)
            j = 1;
            for i = 1:1:length(obj.Connections)
                if (obj.Connections(i).Point1.Number == point)
                    connections(j,:) = obj.Connections(i);
                    j = j + 1;
                end
            end
            if (j == 1)
               connections = []; 
            end
        end
        
        function connections = ConnectedWith(obj, point, doubleSight)
            j = 1;
            for i = 1:1:length(obj.Connections)
                if (obj.Connections(i).Point2.Number == point && obj.Connections(i).DoubleSight == doubleSight)
                    connections(j,:) = obj.Connections(i);
                    j = j + 1;
                end
            end
            if (j == 1)
               connections = []; 
            end
        end
        
        function neighbors = FindNeighbors(obj, point)
            connections = FindConnection(obj, point, true);
            if (isempty(connections))
                neighbors = [];
                return; 
            end
            
            for i = 1:1:length(connections)
               neighbors(i,:) = connections(i).Point2; 
            end
            
        end
%%%%%%%%       
        function FindClosedPolygons(obj, startPoint, pPath)
            
            pPath = [pPath,startPoint];
            neighbors = FindNeighbors(obj, startPoint);
            if (isempty(neighbors))
                return; 
            end
            for i = 1:1:length(neighbors)
                endPoint = neighbors(i).Number;
                if (length(pPath) == 1)
                    FindClosedPolygons(obj,endPoint,pPath)
                elseif (endPoint == pPath(1) && length(pPath) > 2)
                    pPath = [pPath,endPoint];
                    CreateClosedPolygon(obj,pPath);
                    return;
                elseif (endPoint ~= pPath(length(pPath)-1) && isempty(find(pPath == endPoint)) && length(pPath) < obj.MaxCPPoints)
                    FindClosedPolygons(obj,endPoint,pPath)
                end   
            end
            
        end

        function CreateAllClosedPolygons(obj)
            for i = 1:1:length(obj.CPPoints)
                FindClosedPolygons(obj,obj.CPPoints(i).Number,[]);
            end
        end
        
        function CreateClosedPolygon(obj,polygonPath)
            currentPolygon = ClosedPolygon(obj.Points,polygonPath);
            if (isempty(obj.ClosedPolygons) == true)
            	obj.ClosedPolygons = currentPolygon;
            elseif(PolygonsContainPolygon(obj.ClosedPolygons,currentPolygon) == false)
            	obj.ClosedPolygons(length(obj.ClosedPolygons)+1,:) = ClosedPolygon(obj.Points,polygonPath);
            end 
        end
        
        function AddAttributePartOfPolygon(obj)
            
            for i = 1:1:length(obj.Points)
                
                pointConnections = FindConnection(obj,obj.Points(i).Number,true);
                if (length(pointConnections) < 2)
                    obj.Points(i).CanBePartOfPolygon = false;
                else
                	obj.Points(i).CanBePartOfPolygon = true;
                end
                obj.Points(i).ComputeOutline(obj);
                obj.CPPoints = findobj(obj.Points,'CanBePartOfPolygon',true);
            end
            
        end
        

%%%%      function FindLinkedPolygons(obj, startPoint, pPath)
   %         pPath = [pPath,startPoint];
   %         neighbors = FindNeighbors(obj, startPoint);
   %         if (isempty(neighbors))
   %             return; 
   %         end
   %         for i = 1:1:length(neighbors)
   %             endPoint = neighbors(i).Number;
   %             isGiven = neighbors(i).GivenByKOR;
   %             if (length(pPath) == 1 && isGiven == false)
   %                return; 
   %             end
   %             
   %             if (length(pPath) == 1)
   %                 FindLinkedPolygons(obj,endPoint,pPath);
   %             elseif (isGiven == true && length(pPath) > 2 && isempty(find(pPath == endPoint)))
   %                 pPath = [pPath,endPoint];
   %                 CreateLinkedPolygon(obj,pPath);
   %                 return;
   %             elseif (endPoint ~= pPath(length(pPath)-1) && isempty(find(pPath == endPoint)) && length(pPath) < obj.MaxLPPoints)
   %                 FindLinkedPolygons(obj,endPoint,pPath);
   %             end   
   %         end    
   % end
   %     
   %     function CreateLinkedPolygon(obj,polygonPath)
   %         currentPolygon = LinkedPolygon(obj.Points,polygonPath);
   %         if (isempty(obj.LinkedPolygons) == true)
   %         	obj.LinkedPolygons = currentPolygon;
   %         elseif(PolygonsContainPolygon(obj.LinkedPolygons,currentPolygon) == false)
   %         	obj.LinkedPolygons(length(obj.LinkedPolygons)+1,:) = LinkedPolygon(obj.Points,polygonPath);
   %         end 
   %     end
   %     
   %     function CreateAllLinkedPolygons(obj)
   %         GivenPoints = findobj(obj.Points,'GivenByKOR',true);
   %         for i = 1:1:length(GivenPoints)
   %             FindLinkedPolygons(obj,GivenPoints(i).Number,[]);
   %         end
   %     end
%%%%    
        function ComputeAllClosedPolygons(obj)
            amountPolygons = length(obj.ClosedPolygons);
            computedPolygons = 0;
            while (amountPolygons ~= computedPolygons)
               for i = 1:1:amountPolygons
                   if (obj.ClosedPolygons(i).Computed == false)
                       obj.ClosedPolygons(i).ProcessPolygon(obj);
                       if (obj.ClosedPolygons(i).Computed == true);
                           computedPolygons = computedPolygons + 1;
                       end
                   end
               end
            end  
        end
        
        function ComputeAllPointsMainMethod(obj)
            computedPoints = 0;
            while (computedPoints ~= length(obj.Points))
                for i = 1:1:length(obj.Points)
                    connections = FindAllConnections(obj,obj.Points(i).Number);
                    currentPointX = obj.Points(i).CoordX;
                    currentPointY = obj.Points(i).CoordY;
                    currentOutline = obj.Points(i).Outline;
                    if (~isempty(currentOutline))
                        for j = 1:1:length(connections)
                            if (connections(j).Point2.ComputedMainMethod == false)
                            currentDistance = connections(j).Distance;
                            currentAngle = currentOutline + connections(j).Direction1;
                            [newX,newY] = FirstMainGeoMethod(currentPointX, ...
                                currentPointY,currentDistance,currentAngle);
                            string = ['MainGeoMethod From ',num2str(obj.Points(i).Number)];
                            connections(j).Point2.AddComputedCoords(newX,newY,obj,string);
                            connections(j).Point2.ComputedMainMethod = true;
                            computedPoints = computedPoints + 1;
                            end
                        end
                    end
                
                end
            end
            
        end      
        
    end
end