//  用户注册
//  DMLoginLand.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-23.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMJSONCreate.h"
#import "DMUserModel.h"//引入用户MOdel
#import "ggHttpFounction.h"

@interface DMLoginLand : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic)UITextField *ymTxtEmail;
@property (strong, nonatomic)UITextField *ymTxtCodeOne;
@property (strong, nonatomic)UITextField *ymTxtCodeTwo;

@property (strong, nonatomic)DMJSONCreate *ymJSOMLogin;
@property (strong, nonatomic)DMUserModel *ymUserModelLogin;


@end
