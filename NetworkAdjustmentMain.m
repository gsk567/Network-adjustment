clear;
clc;

fileDirDPI = uigetfile({'*.dpi';'*.txt';'*.asc'},'Open measurements file');
fileDirKOR = uigetfile({'*.kor';'*.txt';'*.asc'},'Open given points file');
rawStationArray = ReadDPIFile(fileDirDPI);
rawCoordinateData = load(fileDirKOR);
[projectName,mR,mSa,mSb] = InputProjectData();

stationArray = MeasurementsPreProccessing(rawStationArray);
pointsArray = ExtractPointsFromMeasurements(stationArray,rawCoordinateData);

test = VarificationGivenPoints(pointsArray);
if (test == false)
    clear;
    clc;
    return;
end

network = Network(pointsArray,stationArray);
network.AddAttributePartOfPolygon();
network.CreateAllClosedPolygons();
network.ComputeAllPointsMainMethod();
network.ComputeAllClosedPolygons();

networkAdjustment = NetworkAdjustment(pointsArray, stationArray, mR, mSa, mSb);

networkFigure = GenerateNetworkFigure(network);
reportDocument = ReportGenerator(networkAdjustment, mR, mSa, mSb, projectName, networkFigure);
rptview(reportDocument.OutputPath);

clc;
disp('Computation successful!')
disp('Results are printed in folder Results')