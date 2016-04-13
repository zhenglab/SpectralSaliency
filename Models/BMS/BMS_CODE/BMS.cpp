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

#include "BMS.h"

#include <vector>
#include <cmath>
#include <ctime>
#include <opencv2/imgproc.hpp>

using namespace cv;
using namespace std;


BMS::BMS(const Mat& src, const int dw1, const int ow, const bool nm, const bool hb)
	:_rng(),_dilation_width_1(dw1),_opening_width(ow),_normalize(nm),_handle_border(hb)
{
	_src=src.clone();
	Mat lab;
	cvtColor(_src,lab,COLOR_RGB2Lab);

	vector<Mat> maps;
	maps.push_back(lab);

	for (int i=0;i<maps.size();i++)
	{
		vector<Mat> sp;
		split(maps[i],sp);
		_feature_maps.push_back(sp[0]);
		_feature_maps.push_back(sp[1]);
		_feature_maps.push_back(sp[2]);
	}
	_sm=Mat::zeros(src.size(),CV_64FC1);
}

void BMS::computeSaliency(float step)
{
	for (int i=0;i<_feature_maps.size();++i)
	{
		double max_,min_;
		minMaxLoc(_feature_maps[i],&min_,&max_);
		for (float thresh=min_;thresh<max_;thresh+=step)
		{
			Mat bm=_feature_maps[i]>thresh;
			registerPosition(bm);
			bm=_feature_maps[i]<=thresh;
			registerPosition(bm);
		}
	}
}

Mat BMS::registerPosition(const Mat& bm)
{
	Mat bm_=bm.clone();
	if (_opening_width>0)
	{
		dilate(bm,bm_,Mat(),Point(-1,-1),_opening_width);
		erode(bm_,bm_,Mat(),Point(-1,-1),_opening_width);
	}
	
	Mat innovation=getAttentionMap(bm_);
	_sm=_sm+innovation;
	return innovation;
}


Mat BMS::getAttentionMap(const Mat& bm)
{
	Mat ret=bm.clone();
	int jump;
	if (_handle_border)
	{
		for (int i=0;i<bm.rows;i++)
		{
			jump= _rng.uniform(0.0,1.0)>0.99 ? _rng.uniform(5,25):0;
			if (ret.at<char>(i,0+jump)!=1)
				floodFill(ret,Point(0+jump,i),Scalar(1),0,Scalar(0),Scalar(0),8);
			jump = _rng.uniform(0.0,1.0)>0.99 ?_rng.uniform(5,25):0;
			if (ret.at<char>(i,bm.cols-1-jump)!=1)
				floodFill(ret,Point(bm.cols-1-jump,i),Scalar(1),0,Scalar(0),Scalar(0),8);
		}
		for (int j=0;j<bm.cols;j++)
		{
			jump= _rng.uniform(0.0,1.0)>0.99 ? _rng.uniform(5,25):0;
			if (ret.at<char>(0+jump,j)!=1)
				floodFill(ret,Point(j,0+jump),Scalar(1),0,Scalar(0),Scalar(0),8);
			jump= _rng.uniform(0.0,1.0)>0.99 ? _rng.uniform(5,25):0;
			if (ret.at<char>(bm.rows-1-jump,j)!=1)
				floodFill(ret,Point(j,bm.rows-1-jump),Scalar(1),0,Scalar(0),Scalar(0),8);
		}
	}
	else
	{
		for (int i=0;i<bm.rows;i++)
		{
			if (ret.at<char>(i,0)!=1)
				floodFill(ret,Point(0,i),Scalar(1),0,Scalar(0),Scalar(0),8);
			if (ret.at<char>(i,bm.cols-1)!=1)
				floodFill(ret,Point(bm.cols-1,i),Scalar(1),0,Scalar(0),Scalar(0),8);
		}
		for (int j=0;j<bm.cols;j++)
		{
			if (ret.at<char>(0,j)!=1)
				floodFill(ret,Point(j,0),Scalar(1),0,Scalar(0),Scalar(0),8);
			if (ret.at<char>(bm.rows-1,j)!=1)
				floodFill(ret,Point(j,bm.rows-1),Scalar(1),0,Scalar(0),Scalar(0),8);
		}
	}
	
	double max_, min_;
	minMaxLoc(ret,&min_,&max_);
	ret=ret != 1;
	
	if(_dilation_width_1>0)
		dilate(ret,ret,Mat(),Point(-1,-1),_dilation_width_1);
	ret.convertTo(ret,CV_64FC1);
	if (_normalize)
		normalize(ret,ret,1.0,0.0,NORM_L2);
	else
		normalize(ret,ret,1.0,0.0,NORM_MINMAX);
	return ret;
}

Mat BMS::getSaliencyMap()
{
	Mat ret; 
	normalize(_sm,ret,255.0,0.0,NORM_MINMAX);
	ret.convertTo(ret,CV_8UC1);
	return ret;
}
