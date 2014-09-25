//  图片版块，自定义Cell
//  DMPictureBoardCell.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-8.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMPictureBoardCell.h"

@implementation DMPictureBoardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         [self.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
        //图片
        self.ymImgVLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 212.7, 213)];
        [self.contentView addSubview:self.ymImgVLeft];
        [self.ymImgVLeft setImage:[UIImage imageNamed:@"topic_post_back_small@2x.png"]];
        
        self.ymImgVRightUp = [[UIImageView alloc] initWithFrame:CGRectMake(214.7, 15, 105.3, 105.3)];
        [self.contentView addSubview:self.ymImgVRightUp];
        [self.ymImgVRightUp setImage:[UIImage imageNamed:@"topic_post_back_small@2x.png"]];
        
        self.ymImgVRightDown = [[UIImageView alloc] initWithFrame:CGRectMake(214.7, 122.3, 105.3, 105.3)];
        [self.contentView addSubview:self.ymImgVRightDown];
        [self.ymImgVRightDown setImage:[UIImage imageNamed:@"topic_post_back_small@2x.png"]];
        
        //下方标题
        self.ymLabelDown = [[UILabel alloc] initWithFrame:CGRectMake(0, 229.7, 240, 20.3)];
        [self.ymLabelDown setFont:[UIFont systemFontOfSize:14]];
        [self.ymLabelDown setTextAlignment:NSTextAlignmentLeft];
        [self.ymLabelDown setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.ymLabelDown];
        
        //跟帖
        self.ymComments = [[UILabel alloc] initWithFrame:CGRectMake(240, 229.7, 80, 20.3)];
        [self.ymComments setFont:[UIFont systemFontOfSize:12]];
        [self.ymComments setTextAlignment:NSTextAlignmentRight];
        [self.ymComments setBackgroundColor:[UIColor grayColor]];
        [self.ymComments setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.ymComments];
        
        
        [self.ymImgVLeft setBackgroundColor:[UIColor grayColor]];
        [self.ymImgVRightUp setBackgroundColor:[UIColor grayColor]];
        [self.ymImgVRightDown setBackgroundColor:[UIColor grayColor]];
        [self.ymLabelDown setBackgroundColor:[UIColor grayColor]];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//cell赋值
-(void)gmPictureTitleCellImage:(NSMutableArray *)imgArr andTitle:(NSString *)title andComment:(NSString *)comment{


//     [self.ymImgVLeft
//      [self.ymImgVRightUp
//       [self.ymImgVRightDown
    if([imgArr count] > 3){
        [self.ymImgVLeft setImage:[imgArr objectAtIndex:0]];
        [self.ymImgVRightUp setImage:[imgArr objectAtIndex:1]];
        [self.ymImgVRightDown setImage:[imgArr objectAtIndex:2]];
    
    }else if([imgArr count] > 0 && [imgArr count] < 3){
        [self.ymImgVLeft setImage:[imgArr objectAtIndex:0]];
        [self.ymImgVRightUp setHidden:YES];
        [self.ymImgVRightDown setHidden:YES];
        [self.ymImgVLeft setFrame:CGRectMake(0, 15, 320, 212.7)];

    }
    
    [self.ymLabelDown setText:title];
    [self.ymComments setText:[NSString stringWithFormat:@"%@跟帖",comment]];


}
@end
