//  图组新闻版块
//  DMGroupPicture.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-10.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMJSONWonderfulComment.h"
#import "DMJSONParse.h"
#import "DMPictureNewsModel.h"
#import "DMNetWork.h"//网络监测
@interface DMGroupPicture : NSObject
//新闻数据准备，新闻ID
+(void)gmPrepareNewsDataCatid:(NSInteger)catid andPageSize:(NSInteger)pageSize andPage:(NSInteger)page;
//准备数据-图片
+(NSMutableArray *)gmPreparePictureData:(NSInteger)contentid;
//准备数据-图组Model
+(DMPictureNewsModel *)gmPictureNewsData:(NSInteger)contentid;
@end
