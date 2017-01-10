function [a,b] = ConfigurationCoefficientsForDistance(x1,y1,x2,y2)
    
    ro = 200/pi;
    alpha12 = AlphaFromCoords(x1,y1,x2,y2);

    a = -cos(alpha12/ro);
    b = -sin(alpha12/ro);

end
