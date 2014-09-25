//图片新闻
//  DMPictureNewsModel.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMPictureNewsModel.h"

@implementation DMPictureNewsModel
@synthesize ymImageList = _ymImageList;




//数据归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_ymImageList forKey:@"_ymImageList"];
    
}
//数据逆归档
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){
        _ymImageList = [aDecoder decodeObjectForKey:@"_ymImageList"];
        
    }
    return self;
}
@end
