//  订阅版块
//  DMTailorRead.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-24.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMLeftRightViewDisplay.h"
#import "DMTailorCommend.h"
@interface DMTailorRead : UIViewController{
    id delegate;
}
@property (strong, nonatomic)id <DMLeftRightViewDisplay> delegate;
@property (strong, nonatomic)DMTailorCommend *ymTailorCommend;

@end
