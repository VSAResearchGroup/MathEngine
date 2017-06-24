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
## @seealso
## @end deftypefn

## Author: shiven <shiven@shiven-Aspire-E5-571>
## Created: 2017-03-22

function [retval] = procedure ()
        clc
        clear
        load ../Input/DataStructure_WorkingSet.workspace
        delete ../Output/*.*
        clc
        ##disp 'entered procedure'
        targetCourses = {'CSS344','CSS220','CSS341'};
        ReqNet = skim(targetCourses,ReqNet);
        #ReqNet = yearFilter(ReqNet, 4);
        ReqNet = scheduleMatching(ReqNet, {1, 2, 3, 4, 5, 6, 7});
        ReqNet = timeFilter_multiPair(ReqNet, studentTimes);
        ReqNet = courseStatusUpdation(ReqNet);
        ReqNetArray = clashDetection_planCreation(ReqNet);
        #retval = prerequisites_multiPlans(ReqNetArray);
        QtrArr = quarter_budgetDistribution(ReqNetArray);
        plans = createFinalPlansStruct(QtrArr);
        TF = writeJSON(plans);
        if TF
                disp('Success');
        endif
        retval = plans;
endfunction


function [retval] = courseStatusUpdation(reqNet)
        reqNetFields = fieldnames(reqNet);
        numberOfReqNetFields = numel(reqNetFields) - 1;

        for k = 1:numberOfReqNetFields
                if !reqNet.(reqNetFields{k}).taken       #true is 1
                        reqNet.(reqNetFields{k}).taken = true;
                endif
        endfor
        retval = reqNet;
endfunction

function [retval] = quarter_budgetDistribution(reqNetArray)
        ##This function assumes that all the courses after 10 credits incurr the same fees
        perQtrCrdHr = 0;
        planArr = {};
        reqNets = fieldnames(reqNetArray);
        numberOfReqNets = length(reqNets);
        for j = 1:numberOfReqNets
                qtrArr = {};
                qtrArrRow = 1;          #rows of array
                qtrArrCol = 1;          #columns of array

                perQtrCrdHr = 0;
                reqNet = reqNetArray.(reqNets{j});

                reqNetFields = fieldnames(reqNet);      #reversing the array of courses
                numberOfReqNetFields = numel(reqNetFields) - 1;

                for k = 1:numberOfReqNetFields
                        perQtrCrdHr += creditCreditHours(reqNet,reqNetFields{numberOfReqNetFields - k + 1});
                        qtrArr{qtrArrRow}{qtrArrCol++} = reqNetFields{numberOfReqNetFields - k + 1};
                        if perQtrCrdHr>5
                                qtrArrRow++;
                                qtrArrCol= 1;
                        endif
                endfor
                planArr{j} = qtrArr;
        endfor
        retval = planArr;
endfunction

function [retval] = createFinalPlansStruct(planArr)
        FinalPlansStruct = {};
        for planNumber = 1:length(planArr)
                qtrArr = planArr{planNumber};
                rowsQtrArr = length(qtrArr);

                for row = 1:rowsQtrArr
                        FinalPlansStruct.(strcat('Plan-', num2str(planNumber))).(strcat('Quarter-', num2str(row))).coursesSuggested = qtrArr{row};
                endfor
        endfor
        retval = FinalPlansStruct;
endfunction

function [retval_tf] = writeJSON(plans)
        fileStr = savejson('plans', plans);
        fid=fopen(fullfile('../Output','plans.json'),'w'); ,'w'
        fprintf(fid, fileStr);
        fclose(fid);
        retval_tf = true;
endfunction
