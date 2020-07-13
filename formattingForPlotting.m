
fileID = fopen("input.txt","w");
%FeatureID/C:nImages/I:ImagePosition[11][2]/I:ExpectedWorldPosition[3]/D:RecoWorldPosition[3]/D:ReprojectedPosition[11][2]/D:ReprojectionError[11]/D

reprojectedPosition = calibrationSession.CameraParameters.ReprojectedPoints;
reprojectionErrors = calibrationSession.CameraParameters.ReprojectionErrors;
imagePositions = calibrationSession.BoardSet.BoardPoints;

numberOfPoints = size(reprojectedPosition,1);
numberOfImages = size(reprojectedPosition,3);

reprojectionPointsArray = zeros(numberOfPoints,numberOfImages*2+1);
reprojectionErrorsArray = zeros(numberOfPoints,numberOfImages+1);
imagePositionsArray = zeros(numberOfPoints,numberOfImages*2+1);

for point = 1:numberOfPoints
    reprojectionPointsArray(point,1) = point;
    reprojectionErrorsArray(point,1) = point;
    imagePositionsArray(point,1) = point;
    pointsCounter = 2;
    errorCounter = 2;
    for image = 1:numberOfImages
        reprojectionPointsArray(point,pointsCounter) = reprojectedPosition(point,1,image);
        reprojectionPointsArray(point,pointsCounter+1) = reprojectedPosition(point,2,image);
        imagePositionsArray(point,pointsCounter) = round(imagePositions(point,1,image));
        imagePositionsArray(point,pointsCounter+1) = round(imagePositions(point,2,image));
        %averageReprojection = (abs(reprojectionErrors(point,1,image)) + abs(reprojectionErrors(point,2,image)))/2;
        
        averageReprojection = sqrt(reprojectionErrors(point,1,image)^2 + (reprojectionErrors(point,2,image)^2));
        
        reprojectionErrorsArray(point,errorCounter) = averageReprojection;
        errorCounter = errorCounter+1;
        pointsCounter = pointsCounter+2;
    end
    
    
end

fprintf(fileID,"FeatureID/C:nImages/I:ImagePosition[")
fprintf(fileID,"%d",numberOfImages)
fprintf(fileID,"][2]/I:ExpectedWorldPosition[3]/D:RecoWorldPosition[3]/D:ReprojectedPosition[")
fprintf(fileID,"%d",numberOfImages)
fprintf(fileID,"][2]/D:ReprojectionError[")
fprintf(fileID,"%d",numberOfImages)
fprintf(fileID,"]/D\n")


for point = 1:numberOfPoints
    fprintf(fileID,"%d\t%d",point,numberOfImages);
    for counter = 2:numberOfImages*2+1
        fprintf(fileID,"\t%d",imagePositionsArray(point,counter));
    end
    fprintf(fileID,"0\t0\t0\t0\t0\t0\t0");
    for counter = 2:numberOfImages*2+1
        fprintf(fileID,"\t%f",reprojectionPointsArray(point,counter));
    end
    for counter = 2:numberOfImages+1
        fprintf(fileID,"\t%f",reprojectionErrorsArray(point,counter));
    end
    fprintf(fileID,"\n");
end

fclose(fileID)