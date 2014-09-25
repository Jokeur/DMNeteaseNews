//  图片新闻版块
//  DMPictureTitle.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-24.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMLeftRightViewDisplay.h"
#import "EGORefreshTableHeaderView.h"
#import "DMJSONWonderfulComment.h"
#import "DMJSONParse.h"
#import "DMPictureBoardCell.h"
#import "DMPictureNewsModel.h"
#import "DMGroupPicture.h"
#import "DMPictureNews.h"
@interface DMPictureTitle : UIViewController<UIScrollViewDelegate,EGORefreshTableHeaderDelegate,UITableViewDelegate,UITableViewDataSource>{
    id delegate;
}
@property (strong, nonatomic)id <DMLeftRightViewDisplay> delegate;

@property (strong, nonatomic)NSMutableArray *ymPictureTitle;
@property (strong, nonatomic)UIScrollView *ymPictureTitleSV;
@property (nonatomic) float ymNum;
//下划线的问题
@property (strong, nonatomic)NSMutableArray *ymTitleName;
@property (strong, nonatomic)NSMutableArray *ymDownLine;
//建立横向ScrollView
@property (strong, nonatomic) UIScrollView *ymTempScrollV;
@property (strong, nonatomic )NSMutableArray *ymRefreshViewArr;//存储下拉刷新
@property (strong, nonatomic) NSMutableArray *ymTableViewArr;//存储Tableview
@property BOOL ymReloading;

@property (strong, nonatomic)DMPictureNewsModel *ymPictureNewsModel;
@property (strong, nonatomic)DMPictureNews *ymPictureNews;//点击后显示

@end
