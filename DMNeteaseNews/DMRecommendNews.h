//  点击Cell后，跳转至 推荐显示
//  DMRecommendNews.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-28.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMNewsDataModel.h"
#import "DMJSONParse.h"
@interface DMRecommendNews : UIViewController
@property (strong, nonatomic)UIView *ymRecommendTitleUpV;
//scrollView
@property (strong, nonatomic)UIScrollView *ymScrollV;
@property (strong, nonatomic)DMNewsDataModel *ymRecommendModel;

@end
