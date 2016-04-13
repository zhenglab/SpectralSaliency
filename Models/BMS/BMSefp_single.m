%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Implemetation of the saliency detction method described in paper
%	"Saliency Detection: A Boolean Map Approach", Jianming Zhang, 
%	Stan Sclaroff, ICCV, 2013
%	
%	Copyright (C) 2013 Jianming Zhang
%
%	This program is free software: you can redistribute it and/or modify
%	it under the terms of the GNU General Public License as published by
%	the Free Software Foundation, either version 3 of the License, or
%	(at your option) any later version.
%
%	This program is distributed in the hope that it will be useful,
%	but WITHOUT ANY WARRANTY; without even the implied warranty of
%	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%	GNU General Public License for more details.
%
%	You should have received a copy of the GNU General Public License
%	along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%	If you have problems about this software, please contact: jmzhang@bu.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc
%CVBIOUC% function BMS(input_dir, output_dir, sod)
imgfile = '001.jpg';
% A matlab wrapper for excuting BMS.exe. Make sure to copy the compiled
% executable file in the same directory of this wrapper. Moreover,OpenCV
% library should be in the system's path.
%
% The input and output dir should end with path sperator '/' or '\' depending
% on the operating system.
%
% **sod** is a boolean value indicating whether to use the salient object
% detection mode

input_dir = './src/';
output_dir = './result/';

sample_step_size     =   8;  % \delta
opening_width        =   5;  % \omega_o
dilation_width_1     =   7;  % \omega_{d1}
dilation_width_2     =   23; % \omega_{d2}
blur_std             =   20; % \sigma

use_normalization    =   1;  % L2-normalization
handle_border        =   0;  % Some images have thin artifical black
% borders surrounding them, which can
% affect the output of BMS. You can
% certainly trim the image before
% processing it. Here we provide an adhoc
% method to deal with it. When doing
% floodfill, we randomly put some seeds at
% positions near the image borders, instead
% of putting them exactly at the borders.
% We use this method in our experiments of
% salient object detection, because some of
% the testing images have this issue.

command = sprintf('./BMS %s %s %d %d %d %d %f %d %d',input_dir,output_dir,...
    sample_step_size,opening_width,dilation_width_1,dilation_width_2,...
    blur_std,use_normalization,handle_border);
system(command);


