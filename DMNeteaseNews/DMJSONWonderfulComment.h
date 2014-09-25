//  跟帖版块，跟帖排序
//  DMJSONWonderfulComment.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-8.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMJSONParse.h"
#import "DMNewsDataModel.h"
#import "DMNowTime.h"
#import "DMNetWork.h"
@interface DMJSONWonderfulComment : NSObject

//单例初始化
+(void)sharedCommentMethod;

//文本新闻解析，跟帖
+(void)gmRequestNewsFromURL:(NSURL*)url;
////图片新闻解析，图片
//+(void)gmRequestNewsPictureFromURL:(NSURL *)url;

//精彩跟帖
+(NSMutableArray *)gmSharedJSONNewsWonderful;

//今日排行
+(NSMutableArray *)gmSharedJSONNewsToday;

//我参与的评论
+(NSMutableArray *)gmSharedMyJoinComment;
//回复我的评论
+(NSMutableArray *)gmSharedCallMeComment;
//我参与的评论
+(void)gmSharedMyJoinNIL;
//回复我的评论
+(void)gmSharedCallMeNIL;


//图片新闻，新闻ID
+(NSMutableDictionary *)gmSharedJSONNewsPicture;

//判断TextView中文本高度
+(float)gmTextHightFromWidth:(float)width andFontSize:(float)size andString:(NSString *)string;
//传递新闻版块标题名
+(void)gmNewsBoardTitleChangeValue:(NSMutableArray *)theArr;
//传递新闻版块标题名
+(NSMutableArray *)gmAcquireNewsBoardTitleValue;
@end
