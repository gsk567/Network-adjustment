function test = PolygonsContainPolygon(polygons,polygon)

    polygonPoints = polygon.GetPolygonPoints();
    test = false;

    for i = 1:1:length(polygons)
        currentPolygonPoints = polygons(i).GetPolygonPoints();
        compareTest = PolygonsCompare(polygonPoints,currentPolygonPoints);
        if (compareTest == true)
            test = true;
            break;
        end
    end

end