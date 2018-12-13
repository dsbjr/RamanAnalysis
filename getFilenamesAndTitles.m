function [listFiles,listNames] = getFilenamesAndTitles(filesAndNames)

j = 1;
k = 1;

for i = 1:numel(strlength(filesAndNames))
    if(mod(i,2))
        listFiles(j) = filesAndNames(i);
        j = j + 1;
    else
        listNames(k) = filesAndNames(i);
        k = k + 1;
    end
end