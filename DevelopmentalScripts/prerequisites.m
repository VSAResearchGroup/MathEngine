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
## @deftypefn {Function File} {@var{retval} =} prerequisites (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: shiven <shiven@shiven-Aspire-E5-571>
## Created: 2017-02-06

function [retval] = prerequisites (reqNet)
        disp 'entered prerequisites'
        reqNetFields = fieldnames(reqNet);
        for i = 1:(numel(reqNetFields) - 1)
                prereqCoursesToCheck = reqNet.(reqNetFields{i}).preReqs;
                for j = 1:numel(prereqCoursesToCheck)
                          if (!reqNet.(prereqCoursesToCheck{j}).taken)
                                reqNet = rmfield(reqNet, reqNetFields{i});
                                break;
                          endif
                endfor
        endfor
        retval = reqNet;
endfunction

#{
## Calculates prerequisite requirements dor just one course
function [retval] = prerequisites (reqNet, courseCode)
        retval = true;
        coursesToCheck = reqNet.(courseCode).preReqs;
        for i = 1:numel(coursesToCheck)
                retval = retval & reqNet.(coursesToCheck{i}).taken;
        end
        reqNet.(courseCode).feasibility = retval;
endfunction
#}
