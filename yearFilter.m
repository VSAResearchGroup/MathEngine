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
## @deftypefn {Function File} {@var{retval} =} year (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: shiven <shiven@shiven-Aspire-E5-571>
## Created: 2017-02-06

function [retval] = yearFilter (reqNet, year)
        retval = {'base'};
        removeIndices = {};
        reqNetFields = fieldnames(reqNet);
        numberOfSubjects = numel(reqNetFields) - 1;
        for i = 1:numberOfSubjects
                if (abs(year * 100 - str2num(reqNetFields{i}(4:6))) < 100)
                        removeIndices{length(removeIndices)+1} = i;
                endif        
        end
        
        removeIndices{length(removeIndices)+1} = numberOfSubjects + 1;
        indices = [1:length(reqNetFields)];
        
        for i = 1:length(removeIndices)
                indices = indices(find(indices~=removeIndices{i}));
        endfor
        
        reqNet = rmfield(reqNet,reqNetFields(indices));
        retval = reqNet;
        
        %{
        #Original algorithm
        retval = {'base'};
        fields = fieldnames(reqNet);
        for i = 1:(numel(fields) - 1)
                if (abs(year * 100 - str2num(fields{i}(4:6))) < 100)
                        retval(end + 1) = fields{i};
                endif        
        end
        %}
endfunction
