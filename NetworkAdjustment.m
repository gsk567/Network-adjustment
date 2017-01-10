classdef NetworkAdjustment < handle
    
    properties
        Points;
        Measurements;
        ConfigurationMatrix;
        FreeMembersMatrix;
        WeigthMatrix;
        NormalMatrix;
        NormalFreeMembersMatrix;
        ReverseMatrix;
        CorrectionsMatrix;
        ResidualsMatrix;
        AccuracyEvaluation;
    end
    
    methods
        function obj = NetworkAdjustment(points, stations, mR, mSa, mSb)
            
            measurements = [];
            for i = 1:1:length(stations)
                measurements = [measurements;stations(i).Measurements];
            end
            obj.Measurements = measurements;
            
            newPoints = findobj(points,'GivenByKOR',false);
            obj.Points = points;
            
            [obj.ConfigurationMatrix,obj.FreeMembersMatrix,obj.WeigthMatrix] = ...
                LSQMatrixes(points,newPoints,stations, mR, mSa, mSb);

            obj.NormalMatrix = (obj.ConfigurationMatrix')*obj.WeigthMatrix*obj.ConfigurationMatrix;
            obj.NormalFreeMembersMatrix = (obj.ConfigurationMatrix')*obj.WeigthMatrix*obj.FreeMembersMatrix;
            obj.ReverseMatrix = inv(obj.NormalMatrix);
            obj.CorrectionsMatrix = -obj.ReverseMatrix*obj.NormalFreeMembersMatrix;
            obj.ResidualsMatrix = obj.ConfigurationMatrix*obj.CorrectionsMatrix + obj.FreeMembersMatrix;
            obj.AccuracyEvaluation = sqrt((obj.ResidualsMatrix'*obj.WeigthMatrix*obj.ResidualsMatrix)/ ...
                (length(obj.ConfigurationMatrix(:,1))-(length(newPoints)+length(stations))));
            SetResidualsToPoints(obj, newPoints, stations)
        end
        
        function SetResidualsToPoints(obj, newPoints, stations)
            
            for i = 1:1:length(newPoints)
                newPointsIndexes(i,:) = newPoints(i).Number;
            end
            
            for j = 1:1:length(stations)
            	stationIndexes(j) = stations(j).Number;
            end
            
            for i = 1:1:length(obj.Points)
               if (obj.Points(i).GivenByKOR == false)
                   indexInPointsIndexes = find(newPointsIndexes == obj.Points(i).Number);
                   mainIndex = length(stations) + 2*indexInPointsIndexes - 1;
                   obj.Points(i).CorrectionX = obj.CorrectionsMatrix(mainIndex);
                   obj.Points(i).CorrectionY = obj.CorrectionsMatrix(mainIndex+1);
                   obj.Points(i).RMSX = obj.AccuracyEvaluation*sqrt(obj.ReverseMatrix(mainIndex,mainIndex));
                   obj.Points(i).RMSY = obj.AccuracyEvaluation*sqrt(obj.ReverseMatrix(mainIndex+1,mainIndex+1));
                   obj.Points(i).RMS = sqrt(obj.Points(i).RMSX^2 + obj.Points(i).RMSY^2);
                   [axisA,axisB,phi] = ExtractEllipseData(mainIndex,obj.ReverseMatrix,obj.AccuracyEvaluation);
                   obj.Points(i).EllipseAxisA = axisA;
                   obj.Points(i).EllipseAxisB = axisB;
                   obj.Points(i).EllipsePhi = phi;
                   obj.Points(i).AddCorrectionIntoCoordinates();
               end

               currentStation = findobj(stations,'Number',obj.Points(i).Number);
               if (~isempty(currentStation))
                    stationIndex = find(stationIndexes == currentStation.Number);
                    obj.Points(i).CorrectionO = obj.CorrectionsMatrix(stationIndex);
                    obj.Points(i).RMSO = obj.AccuracyEvaluation*sqrt(obj.ReverseMatrix(stationIndex,stationIndex));
                    obj.Points(i).AddOutlineCorrection();
               end
               
            end
        end
        
    end
    
end

