## Copyright (C) 2017 shiven
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} timeFilter_multiPair (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: shiven <shiven@shiven-Aspire-E5-571>
## Created: 2017-03-25

function [retval] = timeFilter_multiPair (reqNet, studentTimes)
        skipToNextSubject = false;
        
        studentDays = fieldnames(studentTimes);
        numberOfDays = length(studentDays);
        
        reqNetFields = fieldnames(reqNet);
        removeIndices = {};
        numberOfSubjects = numel(reqNetFields) - 1;
        
        for i = 1:numberOfSubjects
                skipToNextSubject = false;
                courseStartTime = reqNet.(reqNetFields{i}).startTime;
                courseEndTime = reqNet.(reqNetFields{i}).endTime;
                for j = 1:numberOfDays
                        arrOfTimePairs = studentTimes.(studentDays{j});
                        numberOfTimePairs = length(arrOfTimePairs);
                        for k = 1:numberOfTimePairs
                                studentStartTime = arrOfTimePairs{k}{1};
                                studentEndTime = arrOfTimePairs{k}{2};
                                if ( courseStartTime >= studentStartTime && courseEndTime <= studentEndTime )
                                        removeIndices{length(removeIndices)+1} = i;
                                        
                                        skipToNextSubject = true;
                                endif
                        endfor
                endfor
                if skipToNextSubject
                        continue
                endif
        endfor
        
        removeIndices{length(removeIndices)+1} = numberOfSubjects + 1;
        indices = [1:length(reqNetFields)];
        
        for i = 1:length(removeIndices)
                indices = indices(find(indices~=removeIndices{i}));
        endfor
        
        reqNet = rmfield(reqNet,reqNetFields(indices));
        retval = reqNet;
endfunction