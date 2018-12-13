function [labelSequence] = getLabelSequence(n)

if(n > 12)
    error("Labels only available up to twelve at this time");
end

completeSequence = {'one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve'};
labelSequence = completeSequence(1:n);