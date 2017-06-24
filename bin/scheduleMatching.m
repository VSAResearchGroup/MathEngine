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

function [retval] = scheduleMatching (reqNet, studentDays)
        ##disp 'entered scheduleMatching'
        studentDays_2 = studentDays(1){1};
        for j = 2:numel(studentDays)
                studentDays_2 = [studentDays_2;studentDays(j){1}];
        endfor

        fields = fieldnames(reqNet);
        for i = 1:(numel(fields) - 1)
                courseDays = reqNet.(fields{i}).days;
                courseDays_2 = courseDays(1){1};
                for j = 2:numel(courseDays)
                        courseDays_2 = [courseDays_2;courseDays(j){1}];
                endfor

                subset = all(ismember(courseDays_2, studentDays_2));

                %{
                sum(pow2(studentDays_2)) - sum(pow2(courseDays_2))

                if(sum(pow2(studentDays_2)) - sum(pow2(courseDays_2)) < 0)
                        reqNet = rmfield(reqNet,fields{i});
                endif
                %}

                if(~subset)
                        reqNet = rmfield(reqNet,fields{i});
                endif

        endfor
        retval = reqNet;
        ##retval = sum(pow2(studentDays)) - sum(pow2(courseDays)) >= 0;
endfunction
