function document = ReportGenerator(networkAdjustmentData,mR,a,b,nameOfProject,networkFigure)

    givenPoints = findobj(networkAdjustmentData.Points,'GivenByKOR',true);
    newPoints = findobj(networkAdjustmentData.Points,'GivenByKOR',false);

    givenTable{1,1} = 'Number';
    givenTable{1,2} = 'Coordinate X [m]';
    givenTable{1,3} = 'Coordinate Y [m]';
    for i = 1:1:length(givenPoints)
       givenTable{i+1,1} = sprintf('%d',givenPoints(i).Number);
       givenTable{i+1,2} = sprintf('%10.3f',givenPoints(i).CoordX);
       givenTable{i+1,3} = sprintf('%10.3f',givenPoints(i).CoordY);
    end

    newTable{1,1} = 'Number';
    newTable{1,2} = 'Coordinate X [m]';
    newTable{1,3} = 'Coordinate Y [m]';
    newTable{1,4} = 'RMS X [mm]';
    newTable{1,5} = 'RMS Y [mm]';
    newTable{1,6} = 'RMS [mm]';
    for i = 1:1:length(newPoints)
        newTable{i+1,1} = sprintf('%d',newPoints(i).Number);
        newTable{i+1,2} = sprintf('%10.3f',newPoints(i).CoordX);
        newTable{i+1,3} = sprintf('%10.3f',newPoints(i).CoordY);
        newTable{i+1,4} = sprintf('%7.2f',newPoints(i).RMSX*1000);
        newTable{i+1,5} = sprintf('%7.2f',newPoints(i).RMSY*1000);
        newTable{i+1,6} = sprintf('%7.2f',newPoints(i).RMS*1000);  
    end

    amountMeasurements = length(networkAdjustmentData.Measurements);
    adjustmentRMS = networkAdjustmentData.AccuracyEvaluation*10000;
    amountGivenPoints = length(givenPoints);
    amountNewPoints = length(newPoints);
    
    mkdir('Results');
    import mlreportgen.dom.*;
    document = Document(['Results/Adjustment Report_',nameOfProject],'docx');
    open(document);

    title = Paragraph('Results from Network Least Square Adjustment');
    title.Style = {LineSpacing(1)};
    title.FontSize = '22';
    title.HAlign = 'center';
    append(document,title);

    projectTitle = Paragraph(['Name of the project: ',nameOfProject]);
    projectTitle.Style = {LineSpacing(1)};
    projectTitle.FontSize = '20';
    projectTitle.HAlign = 'center';
    append(document,projectTitle);

    statisticTitle = Paragraph('Statistic from adjustment');
    statisticTitle.Style = {LineSpacing(1)};
    statisticTitle.FontSize = '18';
    statisticTitle.HAlign = 'center';
    append(document,statisticTitle);

    amountMeasurementsS = sprintf('- In computations are used %d direction measurements and %d distance measurements.',...
        amountMeasurements,amountMeasurements);
    amountMeasurementsP = Paragraph(amountMeasurementsS);
    amountMeasurementsP.FontSize = '16';
    amountMeasurementsP.HAlign = 'left';
    append(document,amountMeasurementsP);

    aprioriRS = sprintf('- Directions A priori (mR): %d cc',mR);
    aprioriRP = Paragraph(aprioriRS);
    aprioriRP.FontSize = '16';
    aprioriRP.HAlign = 'left';
    append(document,aprioriRP);

    apriorDS = sprintf('- Distance A priori (a+bS): %d + %d [S]',a,b);
    apriorDP = Paragraph(apriorDS);
    apriorDP.FontSize = '16';
    apriorDP.HAlign = 'left';
    append(document,apriorDP);

    amountGivenS = sprintf('- In computations are used %d given points.',...
        amountGivenPoints);
    amountGivenP = Paragraph(amountGivenS);
    amountGivenP.FontSize = '16';
    amountGivenP.HAlign = 'left';
    append(document,amountGivenP);

    amountNewS = sprintf('- In computations are computed %d new points.',...
        amountNewPoints);
    amountNewP = Paragraph(amountNewS);
    amountNewP.FontSize = '16';
    amountNewP.HAlign = 'left';
    append(document,amountNewP);

    RMSS = sprintf('- Root Mean Square from the adjustment is %5.2f cc',...
        adjustmentRMS);
    RMSP = Paragraph(RMSS);
    RMSP.FontSize = '16';
    RMSP.HAlign = 'left';
    append(document,RMSP);

    %Given Points Table
    givenPointsParagraph = Paragraph('Given points');
    givenPointsParagraph.Style = {LineSpacing(1)};
    givenPointsParagraph.HAlign = 'center';
    givenPointsParagraph.FontSize = '18';
    append(document,givenPointsParagraph);

    tableGivenPoints = append(document,givenTable);
    tableGivenPoints.Style = {RowHeight('0.2in')};
    tableGivenPoints.Border = 'single';
    tableGivenPoints.ColSep = 'single';
    tableGivenPoints.RowSep = 'single';
    tableGivenPoints.HAlign = 'center';
    tableGivenPoints.TableEntriesHAlign = 'center';
    tableGivenPoints.TableEntriesVAlign = 'middle';

    emptyParagraph = Paragraph('');
    emptyParagraph.Style = {LineSpacing(1)};
    append(document,emptyParagraph);

    %Observed Points Table
    newPointsParagraph = Paragraph('New points');
    newPointsParagraph.Style = {LineSpacing(1)};
    newPointsParagraph.HAlign = 'center';
    newPointsParagraph.FontSize = '18';
    append(document,newPointsParagraph);

    tableNewPoints = append(document,newTable);
    tableNewPoints.Style = {RowHeight('0.2in')};
    tableNewPoints.Border = 'single';
    tableNewPoints.ColSep = 'single';
    tableNewPoints.RowSep = 'single';
    tableNewPoints.HAlign = 'center';
    tableNewPoints.TableEntriesHAlign = 'center';
    tableNewPoints.TableEntriesVAlign = 'middle';
    
    emptyParagraph = Paragraph('');
    emptyParagraph.Style = {LineSpacing(1)};
    append(document,emptyParagraph);
    
    
    figureFileName = ['Results/',nameOfProject,'_figure'];
    print(networkFigure,figureFileName,'-djpeg');
    
    figImage = Image([figureFileName,'.jpg']);
    figImage.Style = {ScaleToFit};
    
    
    append(document,figImage);
    
    close(document);
end
