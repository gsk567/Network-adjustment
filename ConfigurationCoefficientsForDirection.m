function [a,b] = ConfigurationCoefficientsForDirection(x1,y1,x2,y2)
    
    ro = 200/pi;
    alpha = AlphaFromCoords(x1,y1,x2,y2);
    distance = sqrt((x2-x1)^2 + (y2-y1)^2);
    
    a = (sin(alpha/ro)/distance)*ro;
    b = -(cos(alpha/ro)/distance)*ro;

end

