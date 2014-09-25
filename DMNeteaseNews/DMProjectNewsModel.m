//
//  DMProjectNewsModel.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMProjectNewsModel.h"

@implementation DMProjectNewsModel
@synthesize ymCatname = _ymCatname;


//数据归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_ymCatname forKey:@"_ymCatname"];
    
}
//数据逆归档
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if(self){
        _ymCatname = [aDecoder decodeObjectForKey:@"_ymCatname"];
       
    }
    return self;
}

@end
