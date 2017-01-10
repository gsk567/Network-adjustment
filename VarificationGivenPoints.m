function test = VarificationGivenPoints(points)
    
    givenPoints = findobj(points,'GivenByKOR',true);    
    test = true;
    for i = 1:1:length(givenPoints)
        
        if (isempty(givenPoints(i).CoordX) && isempty(givenPoints(i).CoordY))
            test = false;
            pointNumber = givenPoints(i).Number;
            message = ['Given point with number ',num2str(pointNumber),' has no coordinates!'];
            msgbox(message,'Given Point Varification');
        end
    end
    
end

