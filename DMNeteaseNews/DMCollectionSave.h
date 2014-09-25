//  收藏功能，新闻收藏，跟帖收藏，图组收藏
//  DMCollectionSave.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-9.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMNewsDataModel.h"
#import "DMPictureNewsModel.h"
#import "DMCommentModel.h"

#import "DMNetWork.h"//网络监测
@interface DMCollectionSave : NSObject

//单例初始化
+(void)sharedCollection;

//赋值
+(void)gmSharedNews:(DMNewsDataModel *)news;
//跟帖收藏
+(void)gmSharedComment:(DMCommentModel *)comment;
//图片收藏
+(void)gmSharedPicture:(DMPictureNewsModel *)picture;

//取值
//新闻收藏
+(NSMutableArray *)gmSharedNewsCollection;
//跟帖收藏
+(NSMutableArray *)gmSharedCommentCollection;
//图片收藏
+(NSMutableArray *)gmSharedPictureCollection;

//返回文本新闻，标题
+(NSString *)gmTextNewsTitleFromContent:(NSInteger)contentid;
//从沙盒获取数据
+(NSMutableArray *)gmAcquireCollectDataPath:(NSString *)strPath;

@end
