//  跟帖版块
//  DMFollowUpVC.h
//  DMNeteaseNews
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMLeftRightViewDisplay.h"
#import "EGORefreshTableHeaderView.h"
#import "DMJSONWonderfulComment.h"//跟帖排序
#import "DMNewsDataModel.h"
#import "DMJSONParse.h"
#import "DMCommentModel.h"
#import "DMFollowCardCell.h"
#import "DMGroupPicture.h"
#import "DMBasicNews.h"
@interface DMFollowUpVC : UIViewController<UIScrollViewDelegate,EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate >



@property (strong, nonatomic)NSMutableArray *ymFollowPaste;//二级菜单名
@property (strong, nonatomic)UIScrollView *ymFollowPasteSV;//菜单
@property (nonatomic) float ymNum;
//下划线的问题
@property (strong, nonatomic)NSMutableArray *ymTitleName;//存菜单Button
@property (strong, nonatomic)NSMutableArray *ymDownLine;//存下划线Button
//先建立横向ScrollView
@property (strong, nonatomic) UIScrollView *ymTempScrollV;
@property (strong, nonatomic )NSMutableArray *ymRefreshViewArr;//存储下拉刷新
@property (strong, nonatomic) NSMutableArray *ymTableViewArr;//存储Tableview
@property BOOL ymReloading;
@property (nonatomic)float ymCellHight;
@property (strong, nonatomic)NSMutableArray *ymCommentMarr;//得到评论
@property (strong, nonatomic)NSMutableArray *ymCommentCellMe;//新闻爆料评论
@property (strong, nonatomic)DMBasicNews *ymBasicNews;//点击后显示

@end
