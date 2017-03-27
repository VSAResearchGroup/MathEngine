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
## @deftypefn {Function File} {@var{retval} =} test2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: shiven <shiven@shiven-Aspire-E5-571>
## Created: 2017-02-05

function [retval] = userInput ()  
  #DataStructure_WorkingSet.mat needs to be saved in binary format
  #save ("-binary", "DataStructure_Sample.workspace",<varname>)
  load DataStructure_WorkingSet.workspace;
  reqNet = ReqNet;

  reqNet = prerequisites(reqNet);
  
  startTimePrompt = 'Enter the time(in 24 hour clock) after which you are free to attend classes:';
  startTime = input(startTimePrompt);
  endTimePrompt = 'Enter the time(in 24 hour clock) before which you are free to attend classes:';
  endTime = input(endTimePrompt);
  reqNet = timeFilter(reqNet, startTime, endTime);
  
  yearPrompt = 'Enter the year of your course:';
  year = input(yearPrompt);
  #reqNet = yearFilter(reqNet, year);
  
  daysPrompt = 'Enter the days (1 for monday, 2 for tuesday, 3 for wednesday and so on) on which you are free to attend classes. Enter the numericals representing days separated by comma and with no spaces:';
  daysFreeStr = input(daysPrompt,'s');
  daysFree = strsplit(daysFreeStr,',');
  
  
  %{
  courseDays = reqNet.(fields{i}).days;
          courseDays_2 = courseDays(1){1};
          for j = 2:numel(courseDays)
                  courseDays_2 = [courseDays_2;courseDays(j){1}];
          endfor
  scheduleMatching(reqNet ,daysFree)
  %}
  retval = reqNet;
endfunction