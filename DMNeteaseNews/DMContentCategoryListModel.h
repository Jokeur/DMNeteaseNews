//  新闻内容分类Model
//  DMContentCategoryListModel.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-5.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMContentCategoryListModel : NSObject<NSCoding>
@property (nonatomic)NSInteger ymCatid;
@property (nonatomic)NSInteger ymSort;
@property (strong, nonatomic)NSString *ymThumb;
@property (strong, nonatomic)NSString *ymName;


-(void)gmCategoryListModelCatid:(NSInteger)catid andSort:(NSInteger)sort andThumb:(NSString *)thumb andName:(NSString *)name;

@end
