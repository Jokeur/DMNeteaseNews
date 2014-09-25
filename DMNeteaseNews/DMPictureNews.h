//  点击Cell后，跳转至 图组显示
//只需要传递新闻ID过来就可以
//  DMPictureNews.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-28.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMComments.h"
#import "DMPictureNewsModel.h"
#import "DMJSONParse.h"
#import "DMCollectionSave.h"
#import "DMImageInfoModel.h"
@interface DMPictureNews : UIViewController
@property (strong, nonatomic)UIView *ymPictureTitleUpV;

//scrollView
@property (strong, nonatomic)UIScrollView *ymScrollV;
@property (strong, nonatomic)UIScrollView *ymPictureAll;
@property(nonatomic,strong)NSMutableArray *ymImageArr;
@property(nonatomic,strong)NSMutableArray *ymImageDataArr;
//图片原点高度位置
@property float ymPicZeroHight;
//web View
@property (strong, nonatomic)UIWebView *ymWebV;
//弹出子View
@property (strong, nonatomic)UIScrollView *ymSubViewUp;
@property (strong, nonatomic)DMComments *ymCommentsPicture;
//使用Model来接收数据
@property (strong, nonatomic)DMPictureNewsModel *ymPictureModel;

@end
