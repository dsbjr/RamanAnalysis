function [dataSubtracted] = subtractBackground521peak(filenameData,filenameBackground)

%CONSTANTS
peakProminence = 4;
peak521UpperLimit = 560;
peak521LowerLimit = 500;
backgroundMedianRange = [-10 10];

%read data from files
data = getCsvData(filenameData);
temp = data.one; clear data;
data = temp; clear temp;

background = getCsvData(filenameBackground);
temp = background.one; clear background;
background = temp; clear temp;

%generate interpolation
backgroundInterpolation = pchip(background(:,1),background(:,2),data(:,1));

%find 521 peaks
[~,dataPksLocs] = findpeaks(data(:,2),'MinPeakProminence',peakProminence);
[~,backgroundPksLocs] = findpeaks(backgroundInterpolation,'MinPeakProminence',peakProminence);
numDataPeaks = length(dataPksLocs);
numBackgroundPeaks = length(backgroundPksLocs);

for i = 1:numDataPeaks
    tempData = data(:,1); tempDataY = data(:,2);
    if(tempData(dataPksLocs(i)) < peak521UpperLimit && tempData(dataPksLocs(i)) > peak521LowerLimit)
        data521PeakHeight = tempDataY(dataPksLocs(i));
    end;
end

for i = 1:numBackgroundPeaks
    tempBackground = data(:,1); tempBackgroundY = backgroundInterpolation;
    if(tempBackground(backgroundPksLocs(i)) < peak521UpperLimit && tempBackground(backgroundPksLocs(i)) > peak521LowerLimit)
        background521PeakHeight = tempBackgroundY(backgroundPksLocs(i));
    end
end

%calculate 521 peak ratio

peakRatio = data521PeakHeight/background521PeakHeight;
if(peakRatio < 1)
    warning('Peak ratio is less than one - background signal may be large');
end


%subtract such that 521 peak disappears

backgroundSubtracted = data(:,2) - peakRatio.*backgroundInterpolation;
backgroundSubtractedMedian = median(backgroundSubtracted);
checkBackgroundSubtractedMedian = (backgroundSubtractedMedian > backgroundMedianRange(1) && backgroundSubtractedMedian < backgroundMedianRange(2));
if(~checkBackgroundSubtractedMedian)
    warning('Median Background Specification out of Bounds');
end

%plot and output data

dataSubtracted = [data(:,1) backgroundSubtracted];