function [configurationMatrix,freeMembersMatrix,weigthMatrix] = LSQMatrixes(points,newPoints,stations,mR,mSa,mSb)
    
    measurements = [];
	for i = 1:1:length(stations)
        measurements = [measurements;stations(i).Measurements];
    end

	configurationOrientations = zeros(length(measurements),length(stations));
	configurationOrienationsEmpty = zeros(length(measurements),length(stations));
	configurationDirections = zeros(length(measurements),2*length(newPoints));
	configurationDistances = zeros(length(measurements),2*length(newPoints));
    
    freeMembersMatrixDir = zeros(length(measurements),1);
    freeMembersMatrixDist = zeros(length(measurements),1);
    
    weigthMatrixDir = zeros(length(measurements),1);
    weigthMatrixDist = zeros(length(measurements),1);
    
    constant = mR^2;
    
	for i = 1:1:length(measurements)
        currentStationNumber = measurements(i).StartPoint;
        for j = 1:1:length(stations)
            currentObservationPoint = findobj(points,'Number',measurements(i).EndPoint);
            if (currentStationNumber == stations(j).Number && currentObservationPoint.GivenByKOR == false)
                configurationOrientations(i,j) = -1;
            end
        end
    end

	for i = 1:1:length(measurements)
        startPointN = measurements(i).StartPoint;
        endPointN = measurements(i).EndPoint;
        startPoint = findobj(points,'Number',startPointN);
        endPoint = findobj(points,'Number',endPointN);
        
        measuredDirection = measurements(i).Direction;
        measuredDistance = measurements(i).HorizontalDistance;
        computedAlpha = AlphaFromCoords(startPoint.CoordX,startPoint.CoordY,...
            endPoint.CoordX,endPoint.CoordY);
        computedDistance = sqrt((endPoint.CoordX-startPoint.CoordX)^2 + ...
            (endPoint.CoordY-startPoint.CoordY)^2);
        computedOutline = startPoint.Outline;
        computedDirection = computedAlpha - computedOutline;
        if (computedDirection < 0)
            computedDirection = computedDirection + 400;
        end
        
        if (NearTo(measuredDirection,0,20) || NearTo(measuredDirection,400,20))
            measuredDirection = measuredDirection + 200;
            computedDirection = computedDirection + 200;
            if (measuredDirection > 400)
               measuredDirection = measuredDirection - 400; 
            end
            
            if (computedDirection > 400)
               computedDirection = computedDirection - 400; 
            end
        end
        freeMemberDir = computedDirection - measuredDirection;
        freeMemberDist = computedDistance - measuredDistance;
               
        [aDir12,bDir12] = ConfigurationCoefficientsForDirection(startPoint.CoordX, ...
            startPoint.CoordY,endPoint.CoordX,endPoint.CoordY);
               
        [aDir21,bDir21] = ConfigurationCoefficientsForDirection(endPoint.CoordX, ...
            endPoint.CoordY,startPoint.CoordX,startPoint.CoordY);
               
        [aDist12,bDist12] = ConfigurationCoefficientsForDistance(startPoint.CoordX, ...
            startPoint.CoordY,endPoint.CoordX,endPoint.CoordY);
               
        [aDist21,bDist21] = ConfigurationCoefficientsForDistance(endPoint.CoordX, ...
            endPoint.CoordY,startPoint.CoordX,startPoint.CoordY);
        
        pDir = constant/(mR^2);
        mS = (mSa + mSb*sqrt(computedDistance/1000));
        pDist = constant/(mS^2);
        
        freeMembersMatrixDir(i) = freeMemberDir;
        freeMembersMatrixDist(i) = freeMemberDist;
        weigthMatrixDir(i) = pDir;
        weigthMatrixDist(i) = pDist;        
        
        for j = 1:1:length(newPoints)
            if (startPointN == newPoints(j).Number)
                configurationDirections(i,2*j-1) = aDir12;
                configurationDirections(i,2*j) = bDir12;
                configurationDistances(i,2*j-1) = aDist12;
                configurationDistances(i,2*j) = bDist12;
            elseif (endPointN == newPoints(j).Number)
                configurationDirections(i,2*j-1) = aDir21;
                configurationDirections(i,2*j) = bDir21;
                configurationDistances(i,2*j-1) = aDist21;
                configurationDistances(i,2*j) = bDist21;

            end
        end
	end
       
	configurationMatrix = [configurationOrientations,configurationDirections; ...
        configurationOrienationsEmpty,configurationDistances];
    
    freeMembersMatrix = [freeMembersMatrixDir;freeMembersMatrixDist];
    
    weigthMatrix = [weigthMatrixDir;weigthMatrixDist];
    weigthMatrix = diag(weigthMatrix);
                
    

end

