//
//  DMAppearObserveModel.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-6.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMAppearObserveModel.h"

@implementation DMAppearObserveModel
@synthesize ymContentid =_ymContentid;
@synthesize ymStfId = _ymStfId;
@synthesize ymPublished = _ymPublished;
@synthesize ymContent = _ymContent;

//赋值
-(void)gmAppearObserveContentid:(NSString *)contentid andStfId:(NSString*)stfId andPublished:(NSString *)published andContent:(NSString *)content{
    
    _ymContentid = contentid;
    _ymStfId = stfId;
    _ymPublished = published;
    _ymContent = content;

}
//数据归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_ymContentid forKey:@"_ymContentid"];
    [aCoder encodeObject:_ymStfId forKey:@"_ymStfId"];
    [aCoder encodeObject:_ymPublished forKey:@"_ymPublished"];
    [aCoder encodeObject:_ymContent forKey:@"_ymContent"];
}
//数据逆归档
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if(self){
        _ymContentid = [aDecoder decodeObjectForKey:@"_ymContentid"];
        _ymStfId = [aDecoder decodeObjectForKey:@"_ymStfId"];
        _ymPublished = [aDecoder decodeObjectForKey:@"_ymPublished"];
        _ymContent = [aDecoder decodeObjectForKey:@"_ymContent"];
        
    }
    return self;
}


@end
