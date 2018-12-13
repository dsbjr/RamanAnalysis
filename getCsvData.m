function [ramanData] = getCsvData(listFiles)

numFiles = numel(strlength(listFiles));
labelSequence = string(getLabelSequence(numFiles));

for i = 1:numFiles
    fid = fopen(listFiles(i), 'r');               % Open source file.
    for j = 1:37                                  % Read/discard line.
        fgetl(fid) ;
    end
    buffer = fread(fid, Inf) ;                    % Read rest of the file.
    fclose(fid);
    fid = fopen(strcat(listFiles(i),'1'), 'w');   % Open destination file.
    fwrite(fid, buffer) ;                         % Save to file.
    fclose(fid);
end

for i = 1:numFiles
    ramanData.(labelSequence(i)) = dlmread(strcat(listFiles(i),'1'));
end

delete *.txt1