// 离线下载功能
//  DMLeaveLine.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-9.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMJSONParse.h"
#import "DMNetWork.h"//网络监测

@interface DMLeaveLine : NSObject

//请求新闻
+(void)gmRequestLeaveLinePageSize:(NSInteger)size andCatidNum:(NSInteger)catid;
@end
