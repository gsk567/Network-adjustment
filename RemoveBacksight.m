function connections = RemoveBacksight(connections,pPath)

        if (length(pPath)>1)
            for i = 1:1:length(connections)
                if (connections(i).Point2.Number == pPath(length(pPath)-1))
                    connections(i) = [];
                    break;
                end
            end
        end

end

