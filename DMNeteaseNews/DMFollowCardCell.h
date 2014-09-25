//  跟帖版块，自定义Cell
//  DMFollowCardCell.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-8.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMFollowCardCell : UITableViewCell

@property (strong, nonatomic)UILabel *ymFollowTitle;
@property (strong, nonatomic)UILabel *ymFollowContent;
@property (strong, nonatomic)UILabel *ymFollowSource;


//Cell赋值
-(void)gmEvaluateFromTableViewWithHight:(float)hight andTitle:(NSString *)title andContent:(NSString *)content andSource:(NSString *)source;


@end
