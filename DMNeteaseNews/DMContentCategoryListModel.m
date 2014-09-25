//
//  DMContentCategoryListModel.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-5.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMContentCategoryListModel.h"

@implementation DMContentCategoryListModel
@synthesize ymCatid = _ymCatid;
@synthesize ymSort = _ymSort;
@synthesize ymThumb = _ymThumb;
@synthesize ymName = _ymName;

-(void)gmCategoryListModelCatid:(NSInteger)catid andSort:(NSInteger)sort andThumb:(NSString *)thumb andName:(NSString *)name{

    _ymCatid = catid;
    _ymSort = sort;
    _ymThumb = thumb;
    _ymName = name;

}
//数据归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_ymThumb forKey:@"_ymThumb"];
    [aCoder encodeInteger:_ymCatid forKey:@"_ymCatid"];
    [aCoder encodeInteger:_ymSort forKey:@"_ymSort"];
    [aCoder encodeObject:_ymName forKey:@"_ymName"];
}
//数据逆归档
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if(self){
        _ymThumb = [aDecoder decodeObjectForKey:@"_ymThumb"];
        _ymName = [aDecoder decodeObjectForKey:@"_ymName"];
        _ymCatid = [aDecoder decodeIntegerForKey:@"_ymCatid"];
        _ymSort = [aDecoder decodeIntegerForKey:@"_ymSort"];
        
    }
    return self;
}


@end
