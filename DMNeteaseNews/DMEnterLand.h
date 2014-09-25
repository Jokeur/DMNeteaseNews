//  登录、注册版块
//  DMEnterLand.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-23.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMFindCoed.h"
#import "DMLoginLand.h"
#import "DMJSONParse.h"

@interface DMEnterLand : UIViewController
@property (strong, nonatomic)UIImageView *ymEnterIV;
@property (strong, nonatomic)UIButton *ymSafetyBut;
@property (strong, nonatomic)DMFindCoed *ymFindcoed;
@property (strong, nonatomic)DMLoginLand *ymLoginLand;

@end
