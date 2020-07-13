# reprojectionErrorPlotting
Scripts for formatting and plotting reprojection errors from calibrations obtained with MATLAB's camera calibration toolbox.

## formattingForPlotting.m
### Description
MATLAB script for preparing a .txt file with the reprojected points and reprojection errors from a calibration. The file can then be read by the plot.C root script.
### Instructions
1. Open a calibration session file in MATLAB. This is a file generated from the Camera Calibration Toolbox and should contain a 1x1 calibrationSession with exterinsic and intrinsic camera calibration parameters as well as reprojection errors for each image used in the calibration.
1. Run the script. The output will be an input.txt file stored in the same directory as the script.
