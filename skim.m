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
## @deftypefn {Function File} {@var{retval} =} skim (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: shiven <shiven@shiven-Aspire-E5-571>
## Created: 2017-03-23

function [retval] = skim (targets,reqNet)

        nextLayer = {'base'};
        targetNet = {};
        while(!isempty(nextLayer))
                nextLayer = {};
                %disp('Earlier - targets:'); disp(targets);
                %disp('Earlier - nextLayer:'); disp(nextLayer);
                for i=1:length(targets)
                        targetNet.(targets{i}) = reqNet.(targets{i});
                        if isfield(reqNet.(targets{i}),'preReqs')
                                nextLayer = [ reqNet.(targets{i}).preReqs,nextLayer ];
                        endif
                endfor
                targets = nextLayer;
                %disp('After - targets:'); disp(targets);
                %disp('After - nextLayer:'); disp(nextLayer);
        end

        if isfield(targetNet,'base')
                targetNet = rmfield(targetNet,'base');
        endif
        targetNet.('base') = reqNet.('base');

        retval = targetNet;
endfunction