function ScaleBar(figLimits)

minX = figLimits(1);
maxX = figLimits(2);
minY = figLimits(3);
maxY = figLimits(4);

barSpace = (maxY - minY)/10;
barSize = (maxX - minX)/2;
barSize = round(barSize) - mod(round(barSize),100);
mPX = mean([maxX,minX]);

scaleBar = [mPX-10-barSize/2,minY-barSpace;mPX+10+barSize/2,minY-barSpace];
plot(scaleBar(:,1),scaleBar(:,2),'LineWidth',6,'Color','k');

scaleBar = [mPX-barSize/2,minY-barSpace;mPX-barSize/4,minY-barSpace];
plot(scaleBar(:,1),scaleBar(:,2),'LineWidth',4,'Color','k');

scaleBar = [mPX-barSize/4,minY-barSpace;mPX,minY-barSpace];
plot(scaleBar(:,1),scaleBar(:,2),'LineWidth',4,'Color',[0.95,0.95,0.95]);

scaleBar = [mPX,minY-barSpace;mPX+barSize/4,minY-barSpace];
plot(scaleBar(:,1),scaleBar(:,2),'LineWidth',4,'Color','k');

scaleBar = [mPX+barSize/4,minY-barSpace;mPX+barSize/2,minY-barSpace];
plot(scaleBar(:,1),scaleBar(:,2),'LineWidth',4,'Color',[0.95,0.95,0.95]);

text(mPX-barSize/2,minY-barSpace-130,num2str(0),'VerticalAlignment','bottom','HorizontalAlignment','center')
text(mPX-barSize/4,minY-barSpace-130,num2str(barSize/4),'VerticalAlignment','bottom','HorizontalAlignment','center')
text(mPX,minY-barSpace-130,num2str(barSize/2),'VerticalAlignment','bottom','HorizontalAlignment','center')
text(mPX+barSize/4,minY-barSpace-130,num2str(3*barSize/4),'VerticalAlignment','bottom','HorizontalAlignment','center')
text(mPX+barSize/2,minY-barSpace-130,num2str(barSize),'VerticalAlignment','bottom','HorizontalAlignment','center')

end

