//专题新闻类
//  DMProjectNewsModel.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMNewsDataModel.h"

@interface DMProjectNewsModel : DMNewsDataModel<NSCoding>
@property (strong, nonatomic)NSString *ymCatname;

@end
