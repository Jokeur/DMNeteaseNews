//  定义版块，自定义Cell
//  DMTailReadCell.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-13.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMTailReadCell : UITableViewCell


@property (strong, nonatomic)UILabel *ymTailorReadCell;

//订阅Cell
-(void)gmTailorReadCellWidth:(float)width andHight:(float)hight andTitle:(NSString *)title andTxtColor:(NSInteger)color;

@end
