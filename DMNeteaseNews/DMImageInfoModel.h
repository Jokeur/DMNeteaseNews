//图片属性类
//  DMImageInfoModel.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMImageInfoModel : NSObject<NSCoding>
@property(nonatomic)NSInteger ymContentid;//图片所属新闻ID
@property(strong, nonatomic)NSString *ymDescription;//图片描述
@property(nonatomic)NSInteger ymFrid;//图片编号
@property(strong, nonatomic)NSString *ymFrURL;//图片地址
@property(strong, nonatomic)NSString *ymPublished;//发布日期


//数据设置
-(void)gmImageInfoModelContentid:(NSInteger)contentid andDescription:(NSString *)description andFrid:(NSInteger)frid andFrURL:(NSString *)frURL andPublished:(NSString *)published;


@end
