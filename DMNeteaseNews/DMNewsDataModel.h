
//文本新闻
//新闻模型基类

//  DMNewsDataModel.h
//  DMNeteaseNews
//
//  Created by TY on 14-2-25.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMNewsDataModel : NSObject<NSCoding>
@property (strong, nonatomic)NSString *ymContentid;//新闻ID
@property (strong, nonatomic)NSString *ymTitle;//新闻标题
@property (strong, nonatomic)NSString *ymModelid;// "模型id"比如 1 文章 2 组图 3 视频
@property (strong, nonatomic)NSString *ymCatid;//分类id
@property (strong, nonatomic)NSString *ymDescription;//内容简介
@property (strong, nonatomic)NSString *ymPublished;//新闻发布时间戳
@property (strong, nonatomic)NSString *ymContent;//新闻内容
@property (strong, nonatomic)NSString *ymSource;//新闻来源
@property (strong, nonatomic)NSString *ymThumb;//新闻配图地址
@property (strong, nonatomic)NSString *ymVideo;//视频URL(请求的新闻模型为modelid=4，其他为空)
@property (strong, nonatomic)NSString *ymPlaytime;//点击次数
@property (strong, nonatomic)NSString *ymTopicid;// 话题id  用于评论
@property (strong, nonatomic)NSString *ymComments;//评论条数

///新闻获取
-(void)setContentid:(NSString *)theContentid
           andTitle:(NSString *)theTitle
         andModelid:(NSString *)theModelid
           andCatid:(NSString *)theCatid
       andPublished:(NSString *)thePublished
          andSource:(NSString *)theSource
     andDescription:(NSString *)theDescription
         andContent:(NSString *)theContent
           andThumb:(NSString *)theThumb
           andVideo:(NSString *)theVideo
        andPlaytime:(NSString *)thePlaytime
         andTopicid:(NSString *)theTopicid
        andComments:(NSString *)theComments;
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder;
//逆归档
- (id)initWithCoder:(NSCoder *)aDecoder;

@end
