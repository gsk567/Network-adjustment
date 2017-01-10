function alfa = AlphaFromCoords(Xi,Yi,Xj,Yj)
    dY = Yj-Yi;
    dX = Xj-Xi;
    sdy=sign(dY);
    sdx=sign(dX);
    if (dY == 0 && dX == 0)
        return;
    elseif (dY == 0 && dX ~= 0)
        if (dX>0)
            alfa = 0;
        else
            alfa = 200;
        end
    elseif (dY ~= 0 && dX == 0)
        if (dY>0)
            alfa = 100;
        else
            alfa = 300;
        end
    elseif (dY ~=0 && dX ~=0)
        if (sdy>0 && sdx>0)
            alfat = atan(abs(dY/dX))*(200/pi);
            alfa = alfat;
        elseif (sdy>0 && sdx<0)
            alfat = atan(abs(dY/dX))*(200/pi);
            alfa = 200-alfat;
        elseif (sdy<0 && sdx<0)
            alfat = atan(abs(dY/dX))*(200/pi);
            alfa = 200+alfat;
        elseif (sdy<0 && sdx>0)
            alfat = atan(abs(dY/dX))*(200/pi);
            alfa = 400-alfat;
        end
    end
end