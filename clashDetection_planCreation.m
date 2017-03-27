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
## @deftypefn {Function File} {@var{retval} =} scheduleMatching (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: shiven <shiven@shiven-Aspire-E5-571>
## Created: 2017-02-06

function [retval] = clashDetection_planCreation (reqNet)
        expectedStandardTime = 200;
        retval.('1') = reqNet;
        reqNetFields = fieldnames(reqNet);
        runnumberoftimes = 0;
        breakFlagOuterLoop = 0;
        for i = 1:(numel(reqNetFields) - 1)
                for j = i+1:(numel(reqNetFields) - 1)
                          for lenDaysArray_iCourse = 1:length(reqNet.(reqNetFields{i}).days)
                                for lenDaysArray_jCourse = 1:length(reqNet.(reqNetFields{j}).days)
                                        #sprintf('length of Days Array in courseCode{%d} = %d\n',i,length(reqNet.(reqNetFields{i}).days))
                                        #sprintf('length of Days Array in courseCode{%d} = %d\n',j,length(reqNet.(reqNetFields{j}).days))
                                        
                                        #Assigning values
                                        course1Day = reqNet.(reqNetFields{i}).days{lenDaysArray_iCourse};
                                        #sprintf('courseCode{%d} = %s\n',i,reqNetFields{i})
                                        
                                        course1StartTime = reqNet.(reqNetFields{i}).startTime;
                                        course2Day = reqNet.(reqNetFields{j}).days{lenDaysArray_jCourse};
                                        #sprintf('courseCode{%d} = %s\n',j,reqNetFields{j})
                                        course2StartTime = reqNet.(reqNetFields{j}).startTime;
                                        
                                        #checking clash
                                        %%{
                                        if abs(course1StartTime - course2StartTime - (course2Day - course1Day)*2400) < expectedStandardTime
                                                #disp('runnumberoftimes:'); disp(runnumberoftimes+1);
                                                #disp(reqNetFields{i}); disp(reqNetFields{j});
                                                retval = splitStructOfStructs(retval,reqNetFields{i},reqNetFields{j});
                                                
                                                breakFlagOuterLoop = 1;
                                                break
                                        endif
                                        %%}
                                endfor
                                
                                if breakFlagOuterLoop
                                        break
                                endif
                          endfor
                endfor
        endfor
        #retval = reqNet;
        
        #retval = abs(course1StartTime - course2StartTime - (course2Day - course1Day)*2400) >= expectedStandardTime;
endfunction

function [retval] = splitStructOfStructs (reqNetStruct_a, courseA, courseB)
        reqNetStruct_b = struct(reqNetStruct_a);
        #disp('reqNetStruct_b'); disp(reqNetStruct_b);
        lengthStruct = length(fieldnames(reqNetStruct_a));
        
        for i = 1: lengthStruct
                #remove courseA from reqNetStruct_a
                if isfield(reqNetStruct_a.(int2str(i)),courseA)
                        reqNetStruct_a.(int2str(i)) = rmfield(reqNetStruct_a.(int2str(i)),courseA);
                endif
                
                #remove courseB from reqNetStruct_b
                if isfield(reqNetStruct_b.(int2str(i)),courseB)
                        reqNetStruct_b.(int2str(i)) = rmfield(reqNetStruct_b.(int2str(i)),courseB);
                endif
                
                #assign to new structOfStructs
                retval.(int2str(i)) = reqNetStruct_a.(int2str(i));
                retval.(int2str(i+lengthStruct)) = reqNetStruct_b.(int2str(i));
        endfor
        #disp('reqNetStruct_a'); disp(fieldnames(reqNetStruct_a.('1')));
        #disp('reqNetStruct_b'); disp(fieldnames(reqNetStruct_b.('1')));
endfunction