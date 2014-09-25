//  点击Cell后，跳转至 专题显示
//  DMProjectNews.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-28.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMNewsDataModel.h"
#import "DMJSONParse.h"
@interface DMProjectNews : UIViewController
@property (strong, nonatomic)UIView *ymProjectTitleUpV;
//scrollView
@property (strong, nonatomic)UIScrollView *ymScrollV;
@property (strong, nonatomic)DMNewsDataModel *ymProjectModel;

@end
