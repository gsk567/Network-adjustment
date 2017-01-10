function DrawConnection(connection)

    startPoint = connection.Point1;
    endPoint = connection.Point2;

    startPointX = startPoint.CoordX;
    startPointY = startPoint.CoordY;
    endPointX = endPoint.CoordX;
    endPointY = endPoint.CoordY;
    middlePointX = mean([startPointX,endPointX]);
    middlePointY = mean([startPointY,endPointY]);

    if (connection.DoubleSight == true)
        plot([startPointY,endPointY],[startPointX,endPointX],'Color','k','LineWidth',1.0);  
    elseif (connection.DoubleSight == false)
        plot([startPointY,middlePointY],[startPointX,middlePointX],'Color','k','LineWidth',1.0);
        plot([middlePointY,endPointY],[middlePointX,endPointX],'Color','k','LineStyle','--','LineWidth',1.0);
    end

end

