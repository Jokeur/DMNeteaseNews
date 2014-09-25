//  跳转后界面进入 当前新闻的跟帖页面
//  DMComments.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-2.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMCommentModel.h"
#import "DMCommentsCell.h"
#import "DMJSONParse.h"
#import "ggHttpFounction.h"
#import "DMAppearObserve.h"//发表评论
#import "DMCollectionSave.h"
#import "DMEnterLand.h"//登录页面
@interface DMComments : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic)UIView *ymCommentsTitleUpV;
//下方，写跟帖
@property (strong, nonatomic)UIImageView *ymDownImgComments;
@property (strong, nonatomic)UIView *ymDownV;
@property (strong, nonatomic)UITextField *ymTxtDownUpBut;
//TableView
@property (strong, nonatomic)UITableView *ymTableView;
//web View
@property (strong, nonatomic)UIWebView *ymWebV;
//弹出子View
@property (strong, nonatomic)UIScrollView *ymSubViewUp;
//标题栏中跟帖Button
@property (strong, nonatomic)UIButton *ymTitleButComments;
//从Cell获得新闻ID
@property (nonatomic)NSInteger ymContentid;
@property (strong, nonatomic)NSMutableArray *ymCellData;

@property (strong, nonatomic) DMCommentModel *ymTempCommentModel;
//跳转到登录页面
@property (strong, nonatomic) DMEnterLand *ymEnterLand;
@end
