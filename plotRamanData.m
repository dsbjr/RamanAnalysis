function [] = plotRamanData(peakProminence,varargin)

if(~mod(nargin,2))
    error("Each filename must have an accompanying chart title.")
end
names = string(varargin);
numEntries = numel(strlength(names));

%generate strings for filenames and titles
[listFiles,listNames] = getFilenamesAndTitles(names(1:numEntries));

%Read the xlsdata for each filename into data structure
ramanData = getCsvData(listFiles);

%find peaks and plot
numFiles = numEntries/2;
labelSequence = getLabelSequence(numFiles);

for i = 1:(numFiles)
    figure;
    x = flipud(ramanData.(string(labelSequence(i)))(:,1)); y = flipud(ramanData.(string(labelSequence(i)))(:,2));
    findpeaks(y,x,'MinPeakProminence',peakProminence);
    xlabel('Raman shift (cm^{-1})'); ylabel('Intensity (Arbitrary Units)'); title(string(listNames(i)));
    clear x; clear y;
end