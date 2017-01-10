function fig = GenerateNetworkFigure(network)

connections = network.Connections;
points = network.Points;

fig = figure;
hold on
axis equal
axis off
title('Network Visualization','FontSize',14,'FontWeight','bold','Color','k')

drawnConnections = [];
for i = 1:1:length(connections)
    currentConnection(1,1) = connections(i).Point1.Number;
    currentConnection(1,2) = connections(i).Point2.Number;
    existingDrawnConnection = IsDrawn(drawnConnections,currentConnection);
    
    if (existingDrawnConnection == false)
        DrawConnection(connections(i));
        drawnConnections = [drawnConnections;currentConnection];
    end    
end

for i = 1:1:length(points)
    if (points(i).GivenByKOR == true)
        scatter(points(i).CoordY,points(i).CoordX,'filled','^','MarkerEdgeColor','r','MarkerFaceColor','r')
        text(points(i).CoordY,points(i).CoordX,num2str(points(i).Number),'VerticalAlignment','bottom','HorizontalAlignment','right')
    elseif (points(i).GivenByKOR == false)
        scatter(points(i).CoordY,points(i).CoordX,20,'filled','o','MarkerEdgeColor','b','MarkerFaceColor','b')
        text(points(i).CoordY,points(i).CoordX,num2str(points(i).Number),'VerticalAlignment','bottom','HorizontalAlignment','right')
        DrawEllipse(points(i).CoordY,points(i).CoordX,points(i).EllipseAxisA*10,points(i).EllipseAxisB*10,points(i).EllipsePhi)
    end
    
end

figLimits = axis;

ScaleBar(figLimits);

hold off


end

