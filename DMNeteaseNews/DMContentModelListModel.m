//
//  DMContentModelListModel.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-5.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMContentModelListModel.h"

@implementation DMContentModelListModel
@synthesize ymModelid = _ymModelid;
@synthesize ymSort = _ymSort;
@synthesize ymThumb = _ymThumb;
@synthesize ymName = _ymName;

-(void)gmCategoryListModelModelid:(NSInteger)modelid andSort:(NSInteger)sort andThumb:(NSString *)thumb andName:(NSString *)name{
    
    _ymModelid = modelid;
    _ymSort = sort;
    _ymThumb = thumb;
    _ymName = name;
    
}
//数据归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:_ymModelid forKey:@"_ymModelid"];
    [aCoder encodeInteger:_ymSort forKey:@"_ymSort"];
    [aCoder encodeObject:_ymThumb forKey:@"_ymThumb"];
    [aCoder encodeObject:_ymName forKey:@"_ymName"];
}
//数据逆归档
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if(self){
        _ymModelid = [aDecoder decodeIntegerForKey:@"_ymModelid"];
         _ymSort = [aDecoder decodeIntegerForKey:@"_ymSort"];
        _ymThumb = [aDecoder decodeObjectForKey:@"_ymThumb"];
          _ymName = [aDecoder decodeObjectForKey:@"_ymName"];
    }
    return self;
}

@end
