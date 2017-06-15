function [retval] = randList_nElements(list)
        randomIndex = ceil(rand(1)*length(list));
        listRanomized = list(randperm(length(list)));
        retval = listRanomized(1:randomIndex);
endfunction