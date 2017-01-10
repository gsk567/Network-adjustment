function test = PolygonsCompare(Polygon1,Polygon2)
    
    sameMembers1 = sum(ismember(Polygon1,Polygon2));
    sameMembers2 = sum(ismember(Polygon2,Polygon1));
    if (sameMembers1 == length(Polygon1) && sameMembers2 == length(Polygon2))
        test = true;
    else
        test = false;
    end

end

