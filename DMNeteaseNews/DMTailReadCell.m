//
//  DMTailReadCell.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-13.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMTailReadCell.h"

@implementation DMTailReadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//订阅Cell
-(void)gmTailorReadCellWidth:(float)width andHight:(float)hight andTitle:(NSString *)title andTxtColor:(NSInteger)color{
    self.ymTailorReadCell = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, hight)];
    [self.ymTailorReadCell setBackgroundColor:[UIColor blackColor]];
    
    
    [self.ymTailorReadCell setTextAlignment:NSTextAlignmentCenter];
    [self.ymTailorReadCell setText:title];
    if(color == 0){
        [self.ymTailorReadCell setTextColor:[UIColor grayColor]];
        self.ymTailorReadCell.alpha = 0.7;
    }
    if(color == 1){
        [self.ymTailorReadCell setTextColor:[UIColor whiteColor]];
        self.ymTailorReadCell.alpha = 0.8;
    }

    [self.contentView addSubview:self.ymTailorReadCell];
    
    
}


@end
