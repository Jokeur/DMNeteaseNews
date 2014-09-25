//图片新闻类
//  DMPictureNewsModel.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMNewsDataModel.h"

@interface DMPictureNewsModel : DMNewsDataModel<NSCoding>

@property (strong, nonatomic)NSMutableArray *ymImageList;//图片列表

@end
