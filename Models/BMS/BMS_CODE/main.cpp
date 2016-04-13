/*****************************************************************************
*	Implemetation of the saliency detction method described in paper
*	"Saliency Detection: A Boolean Map Approach", Jianming Zhang, 
*	Stan Sclaroff, ICCV, 2013
*	
*	Copyright (C) 2013 Jianming Zhang
*
*	This program is free software: you can redistribute it and/or modify
*	it under the terms of the GNU General Public License as published by
*	the Free Software Foundation, either version 3 of the License, or
*	(at your option) any later version.
*
*	This program is distributed in the hope that it will be useful,
*	but WITHOUT ANY WARRANTY; without even the implied warranty of
*	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*	GNU General Public License for more details.
*
*	You should have received a copy of the GNU General Public License
*	along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*	If you have problems about this software, please contact: jmzhang@bu.edu
*******************************************************************************/

#include <iostream>
#include <ctime>

#include "opencv2/opencv.hpp"
#include "BMS.h"
#include "fileGettor.h"

using namespace cv;
using namespace std;

void help()
{
	cout<<"Usage: \n"
		<<"BMS <input_path> <output_path> <step_size> <opening_width> <dilation_width1> <dilation_width2> <blurring_std> <use_normalization> <handle_border>\n"
		<<"Press ENTER to continue ..."<<endl;
	getchar();
}


void doWork(
	const string in_path,
	const string out_path,
	const int sample_step,
	const int opening_width,
	const int dilation_width_1,
	const int dilation_width_2,
	const float blur_std,
	const bool use_normalize,
	const bool handle_border
	)
{
	if (in_path.compare(out_path)==0)
		cerr<<"output path must be different from input path!"<<endl;
	FileGettor fg(in_path.c_str());
	vector<string> file_list=fg.getFileList();

	clock_t ttt;
	double avg_time=0;

	for (int i=0;i<file_list.size();i++)
	{
		/* get file name */
		string ext=getExtension(file_list[i]);
		if (!(ext.compare("jpg")==0 || ext.compare("jpeg")==0 || ext.compare("JPG")==0 || ext.compare("tif")==0 || ext.compare("png")==0 || ext.compare("bmp")==0))
			continue;
		cout<<file_list[i]<<"...";

		/* Preprocessing */
		Mat src=imread(in_path+file_list[i]);
		Mat src_small;
		resize(src,src_small,Size(600,src.rows*(600.0/src.cols)),0.0,0.0,INTER_AREA);// standard: width: 600 pixel
		GaussianBlur(src_small,src_small,Size(3,3),1,1);// removing noise

		/* Computing saliency */
		ttt=clock();

		BMS bms(src_small,dilation_width_1,opening_width,use_normalize,handle_border);
		bms.computeSaliency((float)sample_step);
		
		Mat result=bms.getSaliencyMap();

		/* Post-processing */
		if (dilation_width_2>0)
			dilate(result,result,Mat(),Point(-1,-1),dilation_width_2);
		if (blur_std > 0)
		{
			int blur_width = MIN(floor(blur_std)*4+1,51);
			GaussianBlur(result,result,Size(blur_width,blur_width),blur_std,blur_std);
		}			
		
		ttt=clock()-ttt;
		float process_time=(float)ttt/CLOCKS_PER_SEC;
		avg_time+=process_time;
		cout<<"average_time: "<<avg_time/(i+1)<<endl;

		/* Save the saliency map*/
		resize(result,result,src.size());
		imwrite(out_path+rmExtension(file_list[i])+".png",result);		
	}
}


int main(int args, char** argv)
{
	if (args != 10)
	{
		cout<<"wrong number of input arguments."<<endl;
		help();
		return 1;
	}

	/* initialize system parameters */
	string INPUT_PATH		=	argv[1];
	string OUTPUT_PATH		=	argv[2];
	int SAMPLE_STEP			=	atoi(argv[3]);//8: delta

	/*Note: we transform the kernel width to the equivalent iteration 
	number for OpenCV's **dilate** and **erode** functions**/
	int OPENING_WIDTH		=	(atoi(argv[4])-1)/2;//2: omega_o	
	int DILATION_WIDTH_1	=	(atoi(argv[5])-1)/2;//3: omega_d1
	int DILATION_WIDTH_2	=	(atoi(argv[6])-1)/2;//11: omega_d2

	float BLUR_STD			=	atof(argv[7]);//20: sigma	
	bool NORMALIZE			=	atoi(argv[8]);//1: whether to use L2-normalization
	bool HANDLE_BORDER		=	atoi(argv[9]);//0: to handle the images with artificial frames
	

	doWork(INPUT_PATH,OUTPUT_PATH,SAMPLE_STEP,OPENING_WIDTH,DILATION_WIDTH_1,DILATION_WIDTH_2,BLUR_STD,NORMALIZE,HANDLE_BORDER);

	return 0;
}