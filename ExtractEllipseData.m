function [axisA,axisB,phi] = ExtractEllipseData(index,reverseMatrix,m)

    Qxx = reverseMatrix(index,index);
    Qyy = reverseMatrix(index+1,index+1);
    Qxy = reverseMatrix(index,index+1);
    
    lamda1 = 0.5*(Qxx + Qyy) + sqrt((0.5*(Qxx-Qyy))^2 + Qxy^2);
    lamda2 = 0.5*(Qxx + Qyy) - sqrt((0.5*(Qxx-Qyy))^2 + Qxy^2);
    axisA = 1000*sqrt(lamda1)*m;
    axisB = 1000*sqrt(lamda2)*m;
    
    T = sqrt((Qxx-Qyy)^2 + 4*Qxy^2);
    phi = atan(-(Qxx-Qyy+T)/(2*Qxy))*200/pi + 100;
    
    
    if (phi > 400)
        phi = phi - 400;
    end
          
    
end

