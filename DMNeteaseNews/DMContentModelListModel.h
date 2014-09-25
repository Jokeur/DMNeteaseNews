//  新闻模式分类 Model
//  DMContentModelListModel.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-5.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMContentModelListModel : NSObject<NSCoding>
@property (nonatomic)NSInteger ymModelid;
@property (nonatomic)NSInteger ymSort;
@property (strong, nonatomic)NSString *ymThumb;
@property (strong, nonatomic)NSString *ymName;


-(void)gmCategoryListModelModelid:(NSInteger)modelid andSort:(NSInteger)sort andThumb:(NSString *)thumb andName:(NSString *)name;
@end
