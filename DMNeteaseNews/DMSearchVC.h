//  搜索新闻,输入关键字
//  DMSearchVC.h
//  DMNeteaseNews
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMNewsDataModel.h"
#import "DMTableViewCell.h"
#import "DMJSONParse.h"
#import "DMBasicNews.h"
@interface DMSearchVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITextField *ymTxtField; //修理标题栏
//数据存储地址
@property (strong, nonatomic)NSString *ymStrPath;
@property (strong, nonatomic)NSMutableArray *ymSearchArr;//搜索结果存储

@property (strong, nonatomic)UITableView *ymTVSearch;//搜查结果显示
@property (strong, nonatomic)DMBasicNews *ymBasicNews;//点击后显示
@end
