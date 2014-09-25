//  收藏版块
//  DMCollectVC.h
//  DMNeteaseNews
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMCollectionSave.h"
#import "DMCollectCell.h"
#import "DMJSONParse.h"
#import "DMBasicNews.h"
#import "DMPictureNews.h"
@interface DMCollectVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UIScrollView *ymCollectView;
@property (strong, nonatomic)UIButton *ymCollectButton;
@property (strong, nonatomic)NSMutableArray *ymCollectMArr;

//TableView
@property (strong, nonatomic)UITableView *ymCollectTV;
@property (strong, nonatomic)NSMutableArray *ymCellMArr;
@property (nonatomic) float ymFloat;

//收藏文件沙盒位置
@property (strong, nonatomic)NSString *ymCollectPath;
@property (strong, nonatomic)DMBasicNews *ymBasicNews;//点击后显示
@property (strong, nonatomic)DMPictureNews *ymPictureNews;//点击后显示
@end
