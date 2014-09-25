//
//  DMTailorCommend.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-2.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMTailReadCell.h"
@interface DMTailorCommend : UIViewController<UITableViewDataSource,UITableViewDelegate>

//左侧导航栏
@property (strong, nonatomic)UITableView *ymLeftTitleTV;
@property (strong, nonatomic)NSMutableArray *ymLeftTitleArr;
//右侧导航栏
@property (strong, nonatomic)UITableView *ymRightTitleTV;
@property (strong, nonatomic)NSMutableDictionary *ymRightTitleDict;

@property NSInteger ymFloat ;
@end
