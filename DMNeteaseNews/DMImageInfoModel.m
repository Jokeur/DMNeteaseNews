//
//  DMImageInfoModel.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMImageInfoModel.h"

@implementation DMImageInfoModel
@synthesize ymContentid = _ymContentid;
@synthesize ymDescription = _ymDescription;
@synthesize ymFrid = _ymFrid;
@synthesize ymFrURL = _ymFrURL;
@synthesize ymPublished = _ymPublished;


//数据设置
-(void)gmImageInfoModelContentid:(NSInteger)contentid andDescription:(NSString *)description andFrid:(NSInteger)frid andFrURL:(NSString *)frURL andPublished:(NSString *)published{

    _ymContentid = contentid;
    _ymDescription = description;
    _ymFrid = frid;
    _ymFrURL = frURL;
    _ymPublished = published;
}
//数据归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:_ymContentid forKey:@"_ymContentid"];
    [aCoder encodeObject:_ymDescription forKey:@"_ymDescription"];
    [aCoder encodeInteger:_ymFrid forKey:@"_ymFrid"];
    [aCoder encodeObject:_ymFrURL forKey:@"_ymFrURL"];
    [aCoder encodeObject:_ymPublished forKey:@"_ymPublished"];
}
//数据逆归档
- (id)initWithCoder:(NSCoder *)aDecoder{

    self = [super init];
    if(self){
        _ymContentid = [aDecoder decodeIntForKey:@"_ymContentid"];
        _ymDescription = [aDecoder decodeObjectForKey:@"_ymDescription"];
        _ymFrid = [aDecoder decodeIntForKey:@"_ymFrid"];
        _ymFrURL = [aDecoder decodeObjectForKey:@"_ymFrURL"];
        _ymPublished = [aDecoder decodeObjectForKey:@"_ymPublished"];
    }
    return self;
}



@end
