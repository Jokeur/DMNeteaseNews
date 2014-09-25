//
//  DMJSONCreate.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-5.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMUserModel.h"
#import "SBJson.h"
#import "DMAppearObserveModel.h"
#import "DMPictureNewsModel.h"
#import "DMImageInfoModel.h"
#import "DMNetWork.h"//网络监测
@interface DMJSONCreate : NSObject


//USer生成JSON格式
+(NSString *)gmJSONWithModel:(DMUserModel * )theModel;
//发表评论生成JSON格式
+(NSString *)gmJSONAppearObserve:(DMAppearObserveModel *)theModel;

//爆料
+(NSString *)gmJSONPictureNewsWithModel:(DMPictureNewsModel *)theModel;

@end
