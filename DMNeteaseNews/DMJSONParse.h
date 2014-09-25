//文本新闻解析
//  DMJSONParse.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMNewsDataModel.h"
#import "DMPictureNewsModel.h"
#import "DMImageInfoModel.h"
#import "DMCommentModel.h"
#import "DMUserModel.h"
#import "DMNetWork.h"//网络监测
@interface DMJSONParse : NSObject
@property (strong, nonatomic)DMNewsDataModel *ymNewsDataModelJOSN;


//单例类方法
+(id)sharedJSONParseMethod;

//文本新闻解析
+(NSMutableDictionary *)gmRequestNewsFromCatid:(NSInteger)catid andURL:(NSURL*)url;
//图片解析
+(UIImage *)gmRequestImageNews:(NSURL*)url;
//图组解析
+(NSMutableDictionary *)gmJSONPictureParse:(NSURL *)url andKey:(NSString *)key;

//获取当前新闻的评论列表
+(NSMutableArray *)gmJSONCommentList:(NSURL *)url;

//登陆返回数据
+(id)gmUserLanding:(NSURL *)url;
//清空登录数据记录
+(void)gmDismissPassValue;

//传递数据
+(NSString *)gmPassValue:(NSString *)StfId;

@end
