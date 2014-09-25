//
//  DMCommentModel.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-5.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMCommentModel.h"

@implementation DMCommentModel
@synthesize ymIP = _ymIP;//用户IP
@synthesize ymNickName = _ymNickName;//用户昵称
@synthesize ymLongitude = _ymLongitude;//GPS经度
@synthesize ymLatitude = _ymLatitude;//GPS纬度
@synthesize ymDrId = _ymDrId;//评论编号
@synthesize ymStfId = _ymStfId;//用户编号
@synthesize ymContentId = _ymContentId;//文章id
@synthesize ymPublished = _ymPublished;//评论时间
@synthesize ymContent = _ymContent;//评论内容

-(void)gmSetCommentModelValue:(NSString*)IP andNickName:(NSString *)nickName andLon:(NSString *)longitude andLat:(NSString *)latitude andDrid:(NSInteger)drID andStfid:(NSInteger)stfid andContentId:(NSInteger)contentid andPublished:(NSString *)published andContent:(NSString *)content{

    _ymIP = IP;
    _ymNickName = nickName;
    _ymLongitude = longitude;
    _ymLatitude = latitude;
    _ymDrId = drID;
    _ymStfId = stfid;
    _ymContentId = contentid;
    _ymPublished = published;
    _ymContent = content;

}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_ymIP forKey:@"_ymIP"];
    [aCoder encodeObject:_ymNickName forKey:@"_ymNickName"];
    [aCoder encodeObject:_ymLongitude forKey:@"_ymLongitude"];
    [aCoder encodeObject:_ymLatitude forKey:@"_ymLatitude"];
    [aCoder encodeInteger:_ymDrId forKey:@"_ymDrId"];
    [aCoder encodeInteger:_ymStfId forKey:@"_ymStfId"];
    [aCoder encodeInteger:_ymContentId forKey:@"_ymContentId"];
    [aCoder encodeObject:_ymPublished forKey:@"_ymPublished"];
    [aCoder encodeObject:_ymContent forKey:@"_ymContent"];
    

}
//逆归档
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        _ymIP = [aDecoder decodeObjectForKey:@"_ymIP"];
        _ymNickName = [aDecoder decodeObjectForKey:@"_ymNickName"];
        _ymLongitude = [aDecoder decodeObjectForKey:@"_ymLongitude"];
        _ymLatitude = [aDecoder decodeObjectForKey:@"_ymLatitude"];
        _ymDrId = [aDecoder decodeIntegerForKey:@"_ymDrId"];
        _ymStfId = [aDecoder decodeIntegerForKey:@"_ymStfId"];
        _ymContentId = [aDecoder decodeIntegerForKey:@"_ymContentId"];
        _ymPublished = [aDecoder decodeObjectForKey:@"_ymPublished"];
        _ymContent = [aDecoder decodeObjectForKey:@"_ymContent"];

    }
    return self;
}

@end
