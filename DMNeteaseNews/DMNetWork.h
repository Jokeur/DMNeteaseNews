//  网络监测，每个网络请求前判断
//  DMNetWork.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-16.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface DMNetWork : NSObject<UIAlertViewDelegate>
@property (strong, nonatomic)Reachability *ymNetwork;
@property BOOL result;

//网络监测
-(BOOL)gmNetWork;

@end
