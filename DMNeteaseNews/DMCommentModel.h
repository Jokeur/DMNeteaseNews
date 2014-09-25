//  跟帖类
//  DMCommentModel.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-5.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMCommentModel : NSObject<NSCoding>
@property (strong, nonatomic)NSString *ymIP;//用户IP
@property (strong, nonatomic)NSString *ymNickName;//用户昵称
@property (strong, nonatomic)NSString *ymLongitude;//GPS经度
@property (strong, nonatomic)NSString *ymLatitude;//GPS纬度
@property (nonatomic)NSInteger ymDrId;//评论编号
@property (nonatomic)NSInteger ymStfId;//用户编号
@property (nonatomic)NSInteger ymContentId;//文章id
@property (strong, nonatomic)NSString *ymPublished;//评论时间
@property (strong, nonatomic)NSString *ymContent;//评论内容

-(void)gmSetCommentModelValue:(NSString*)IP andNickName:(NSString *)nickName andLon:(NSString *)longitude andLat:(NSString *)latitude andDrid:(NSInteger)drID andStfid:(NSInteger)stfid andContentId:(NSInteger)contentid andPublished:(NSString *)published andContent:(NSString *)content;


@end
