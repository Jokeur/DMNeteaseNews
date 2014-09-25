//
//  DMFollowCardCell.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-8.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMFollowCardCell.h"

@implementation DMFollowCardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
        
        //原文Button
        UIButton *tempBut = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 30, 15 )];
        [tempBut.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [tempBut setBackgroundColor:[UIColor redColor]];
        [tempBut setTitle:@"原文" forState:UIControlStateNormal];
        [tempBut setAlpha:0.6];
        
        [self.contentView addSubview:tempBut];
        
        //新闻标题
        self.ymFollowTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 250, 15)];
        [self.ymFollowTitle setFont:[UIFont systemFontOfSize:12.0]];
//        [self.ymFollowTitle setBackgroundColor:[UIColor blackColor]];
//        [self.ymFollowTitle setAlpha:0.8];
        [self.ymFollowTitle setTextColor:[UIColor grayColor]];
        [self.ymFollowTitle setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.ymFollowTitle];
        
        //新闻内容
        self.ymFollowContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 300, 30)];
        [self.ymFollowContent setFont:[UIFont systemFontOfSize:14.0]];
        [self.ymFollowContent setNumberOfLines:0];
        [self.ymFollowContent setTextColor:[UIColor whiteColor]];

//        [self.ymFollowContent setAlpha:0.5];
        
        [self.contentView addSubview:self.ymFollowContent];
        
        //新闻来源
        self.ymFollowSource = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 15)];
        [self.ymFollowSource setFont:[UIFont systemFontOfSize:12.0]];
//        [self.ymFollowSource setBackgroundColor:[UIColor blackColor]];
        [self.ymFollowSource setText:@"网易网友"];
        [self.ymFollowSource setTextAlignment:NSTextAlignmentRight];
        [self.ymFollowSource setTextColor:[UIColor grayColor]];

        [self.ymFollowContent setAlpha:0.5];
        
        [self.contentView addSubview:self.ymFollowSource];
     
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//Cell赋值
-(void)gmEvaluateFromTableViewWithHight:(float)hight andTitle:(NSString *)title andContent:(NSString *)content andSource:(NSString *)source{
  
    self.ymFollowTitle.text = title;
    self.ymFollowContent.text = content;
    self.ymFollowSource.text = source;

    [ self.ymFollowContent setFrame:CGRectMake(10, 20, 300, hight-40)];
    [self.ymFollowSource setFrame:CGRectMake(10, hight - 20, 300, 15)];


}
@end
