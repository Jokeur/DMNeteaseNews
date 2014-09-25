//  多类取值，组合成评论Model 
//  DMAppearObserve.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMAppearObserveModel.h"
#import "ggHttpFounction.h"
#import "DMJSONCreate.h"
#import "DMJSONParse.h"
#import "DMNowTime.h"//得到时间
#import "DMNetWork.h"//网络监测
@interface DMAppearObserve : UIViewController

//组合成评论Model 在转换成JSON
+(NSString *)gmFromAppearObserveToJSONContentid:(NSString *)contentid andContent:(NSString *)content;



@end
