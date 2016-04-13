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


function BMS(input_dir, output_dir, sod)
% A matlab wrapper for excuting BMS.exe. Make sure to copy the compiled
% executable file in the same directory of this wrapper. Moreover,OpenCV
% library should be in the system's path.
%
% The input and output dir should end with path sperator '/' or '\' depending
% on the operating system.
%
% **sod** is a boolean value indicating whether to use the salient object
% detection mode

if input_dir(end) ~= '/' && input_dir(end) ~= '\'
    input_dir           =   [input_dir,'/'];
end

if output_dir(end) ~= '/' && output_dir(end) ~= '\'
    output_dir          =   [output_dir,'/'];
end

if ~exist(output_dir,'dir')
    mkdir(output_dir);
end

if ~sod % for eye fixation prediction
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
else % for salient object detection
    sample_step_size    =   8;  % \delta
    opening_width       =   13; % \omega_o
    dilation_width_1    =   1;  % \omega_{d1} (turn off dilation)
    dilation_width_2    =   1;  % \omega_{d2} (turn off dilation)
    blur_std            =   0;  % \sigma (turn off bluring)
   
    use_normalization   =   0;  % L2-normalization
    handle_border       =   1;
end

command = sprintf('./BMS %s %s %d %d %d %d %f %d %d',input_dir,output_dir,...
    sample_step_size,opening_width,dilation_width_1,dilation_width_2,...
    blur_std,use_normalization,handle_border);
system(command);

% post-processing for salient object detection tasks
if sod
    radius              =   15;
    D                   =   dir(fullfile(output_dir,'*.png'));
    file_list           =   {D.name};
    for i               =   1:numel(file_list)
        I               =   imread(fullfile(output_dir,file_list{i}));
        I               =   postProcSOD(I,radius);
        imwrite(I,fullfile(output_dir,[file_list{i}(1:end-4),'.png']));
    end
end

end

%% Post-processing function for Salient Object Detection

function sMap           =   postProcSOD(mAttMap,radius)
% opening by reconstruction followed by closing by reconstruction
% see the following material for detailed explanations 
% http://www.mathworks.com/products/demos/image/watershed/ipexwatershed.html

img_size                =   size(mAttMap);
I                       =   imresize(mAttMap,[NaN 400]); %  width = 400
se                      =   strel('disk',radius);
Ie                      =   imerode(I, se);
Iobr                    =   imreconstruct(Ie, I);
Iobrd                   =   imdilate(Iobr, se);
Iobrcbr                 =   imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr                 =   imcomplement(Iobrcbr);
sMap                    =   imresize(mat2gray(Iobrcbr),img_size(1:2));

end


