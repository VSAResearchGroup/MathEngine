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

function [retval] = procedure (input1)
  disp(input1)
  
  #DataStructure_WorkingSet.mat needs to be saved in binary format
  #save ("-binary", "DataStructure_Sample.workspace",<varname>)
  load DataStructure_WorkingSet.mat

  fields = fieldnames(ReqNet)
  maxIndexNum = numel(fields)

  #test segment
  #{
    for i = 1:maxIndexNum
      str2num(fields{i})-1568400
    end
  #}
  
endfunction