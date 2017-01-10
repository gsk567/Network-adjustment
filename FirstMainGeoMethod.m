function [x,y] = FirstMainGeoMethod(x1,y1,distance,alpha)

    ro = 200/pi;
    x = x1 + distance*cos(alpha/ro);
    y = y1 + distance*sin(alpha/ro);

end

