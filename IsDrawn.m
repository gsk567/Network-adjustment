function test = IsDrawn(drawnConnections,newConnection)

    test = false;
    
    if (isempty(drawnConnections))
        return;
    end
    
    
    for i = 1:1:length(drawnConnections(:,1))
        if ((newConnection(1) == drawnConnections(i,1) && newConnection(2) == drawnConnections(i,2)) || ...
        	(newConnection(2) == drawnConnections(i,1) && newConnection(1) == drawnConnections(i,2)))
            test = true;
            return;
        end      
    end

end

