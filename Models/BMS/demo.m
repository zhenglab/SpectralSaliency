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

% BMS('bruce/','bruce_efp/',false); % for eye fixation prediction
% BMS('bruce/','bruce_sod/',true); % for salient object detection
% 
% BMS('ECSSD/','ECSSD_efp/',false); % for eye fixation prediction
% BMS('ECSSD/','ECSSD_sod/',true); % for salient object detection
% 
% BMS('Imgsal/','Imgsal_efp/',false); % for eye fixation prediction
% BMS('Imgsal/','Imgsal_sod/',true); % for salient object detection
% 
% BMS('pascal/','pascal_efp/',false); % for eye fixation prediction
% BMS('pascal/','pascal_sod/',true); % for salient object detection

BMS('judd/','judd_efp/',false);

% % D = dir('src/*.bmp');
% % file_list = {D.name};
% % src = imread(fullfile('src/',file_list{1}));
% % sMap_efp = imread(fullfile('output_efp/',[file_list{1}(1:end-4),'.png']));
% % sMap_sod = imread(fullfile('output_sod/',[file_list{1}(1:end-4),'.png']));
% % 
% % figure
% % subplot(2,2,1:2)
% % imshow(src)
% % title('Input Image')
% % subplot(2,2,3)
% % imshow(double(sMap_efp)/max(double(sMap_efp(:)))) % normalize for better visualization
% % title('Eye Fixation Prediction')
% % subplot(2,2,4)
% % imshow(sMap_sod)
% % title('Salient Object Detection')
