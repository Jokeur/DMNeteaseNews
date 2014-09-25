//  投票版块
//  DMBallot.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-24.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMLeftRightViewDisplay.h"
@interface DMBallot : UIViewController{
    id delegate;
}
@property (strong, nonatomic)id <DMLeftRightViewDisplay> delegate;

@end
