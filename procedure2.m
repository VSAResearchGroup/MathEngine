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
## @deftypefn {Function File} {@var{retval} =} procedure (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: shiven <shiven@shiven-Aspire-E5-571>
## Created: 2017-03-26

function [retval] = procedure2 ()
        clc
        clear 
        load DataStructure_WorkingSet.workspace 
        clc
        targetCourses = {'CSS344','CSS220','CSS341'};
        ReqNet = skim(targetCourses,ReqNet);
        ReqNet = yearFilter(ReqNet, 2);
        ReqNet = scheduleMatching(ReqNet, {1, 2, 3, 4, 5, 6, 7});
        ReqNet = timeFilter_multiPair(ReqNet, studentTimes);
        
        retval = quarterDistribution(ReqNet, targetCourses);

endfunction

function [retval] = quarterDistribution(reqNet, targetCourses)
        
        reqNetArray = clashDetection_planCreation(reqNet);
        reqNetArray = prerequisites_multiPlans(reqNetArray);
        
        qtrArr = {{reqNetArray}};
        qtrArrRow = 1;
        [qtrArr{qtrArrRow} count] = courseStatusUpdation(qtrArr{qtrArrRow});
        #qtrArr{qtrArrRow}
        count = 1;
        while count~=0
                arrOfReqNetArray = qtrArr{qtrArrRow};
                arrOfReqNetArrayLen = length(arrOfReqNetArray);
                for i = 1:arrOfReqNetArrayLen
                        reqNetArray = arrOfReqNetArray{i};
                        
                        reqNets = fieldnames(reqNetArray);
                        numberOfReqNets = length(reqNets);
                        for j = 1:numberOfReqNets
                                
                        
        end
        
        quarterCount = 1;
        
endfunction

function [arr_retval count_retval] = courseStatusUpdation(arrOfReqNetArray)
        count = 0;
        arrOfReqNetArrayLen = length(arrOfReqNetArray);
        for i = 1:arrOfReqNetArrayLen
                reqNetArray = arrOfReqNetArray{i};
                
                reqNets = fieldnames(reqNetArray);
                numberOfReqNets = length(reqNets);
                for j = 1:numberOfReqNets
                        
                        reqNet = reqNetArray.(reqNets{j});
                        
                        reqNetFields = fieldnames(reqNet);
                        numberOfReqNetFields = numel(reqNetFields) - 1;
                        
                        for k = 1:numberOfReqNetFields
                                if !reqNet.(reqNetFields{k}).taken       #true is 1
                                        count++;
                                        arrOfReqNetArray{i}.(reqNets{j}).(reqNetFields{k}).taken = false;
                                        #reqNet.(reqNetFields{k}).taken = false;
                                endif
                        endfor
                endfor
        endfor
        arr_retval = arrOfReqNetArray;
        count_retval = count;
endfunction