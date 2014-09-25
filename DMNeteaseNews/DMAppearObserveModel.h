//  发表评论Model
//  DMAppearObserveModel.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-6.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMAppearObserveModel : NSObject<NSCoding>
@property (strong, nonatomic)NSString *ymContentid;//新闻ID
@property (strong, nonatomic)NSString *ymStfId;//用户ID
@property (strong, nonatomic)NSString *ymPublished;//评论时间
@property (strong, nonatomic)NSString *ymContent;//评论内容

//赋值
-(void)gmAppearObserveContentid:(NSString *)contentid andStfId:(NSString*)stfId andPublished:(NSString *)published andContent:(NSString *)content;

@end
