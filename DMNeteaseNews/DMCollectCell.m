//
//  DMCollectCell.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-9.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMCollectCell.h"

@implementation DMCollectCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
//新闻收藏
-(void)gmNewsCollectTitle:(NSString *)title andContent:(NSString *)content andComments:(NSString *)comments{
    self.ymCommentsBut = [[UIButton alloc] initWithFrame:CGRectMake(10, 12, 25, 15)];
    [self.ymCommentsBut.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.ymCommentsBut setBackgroundColor:[UIColor redColor]];
    [self.ymCommentsBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ymCommentsBut setTitle:@"原文" forState:UIControlStateNormal];
    [self.ymCommentsBut setAlpha:0.6];
    [self.contentView addSubview:self.ymCommentsBut];
    
    self.ymNewsTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 270, 20)];
    [self.ymNewsTitleLab setFont:[UIFont systemFontOfSize:14]];
    [self.ymNewsTitleLab setTextColor:[UIColor whiteColor]];
    [self.ymNewsTitleLab setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.ymNewsTitleLab];
    
    self.ymNewsContentLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 30)];
    [self.ymNewsContentLab setFont:[UIFont systemFontOfSize:12]];
    [self.ymNewsContentLab setNumberOfLines:0];
    [self.ymNewsContentLab setTextColor:[UIColor grayColor]];
    [self.ymNewsContentLab setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.ymNewsContentLab];
    
    self.ymNewsCommentsLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300, 15)];
    [self.ymNewsCommentsLab setFont:[UIFont systemFontOfSize:12]];
    [self.ymNewsCommentsLab setTextColor:[UIColor grayColor]];
    [self.ymNewsCommentsLab setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:self.ymNewsCommentsLab];
    
    //赋值
    [self.ymNewsTitleLab setText:title];
    [self.ymNewsContentLab setText:content];
    [self.ymNewsCommentsLab setText:[NSString stringWithFormat:@"%@跟帖",comments]];
    
}
//图片收藏
-(void)gmPictureCollectImage:(NSMutableArray *)image andPictureLab:(NSString *)label andComments:(NSString *)comments{

    UIView *tempDownV = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 300, 190)];
    [tempDownV setBackgroundColor:[UIColor grayColor]];
    [self.contentView addSubview:tempDownV];
    
    
    self.ymPictureV = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 294, 160)];
    UIImage *tempImg = [image objectAtIndex:0];
    [self.ymPictureV setImage:tempImg];
    [tempDownV addSubview:self.ymPictureV];
    
    self.ymPictureLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 240, 20)];
    [self.ymPictureLab setFont:[UIFont systemFontOfSize:16]];
    [self.ymPictureLab setNumberOfLines:0];
    [self.ymPictureLab setTextColor:[UIColor whiteColor]];
    [self.ymPictureLab setTextAlignment:NSTextAlignmentLeft];
    [tempDownV addSubview:self.ymPictureLab];
    
    self.ymPictureCommentsLab = [[UILabel alloc] initWithFrame:CGRectMake(240, 170, 54, 20)];
    [self.ymPictureCommentsLab setFont:[UIFont systemFontOfSize:12]];
    [self.ymPictureCommentsLab setTextColor:[UIColor whiteColor]];
    [self.ymPictureCommentsLab setTextAlignment:NSTextAlignmentRight];
    [tempDownV addSubview:self.ymPictureCommentsLab];
    
    //赋值
 
    [self.ymPictureLab setText:label];
    [self.ymPictureCommentsLab setText:[NSString stringWithFormat:@"%@张",comments]];
    
}
//跟帖收藏
-(void)gmCommentCollectTitle:(NSString *)title andContent:(NSString *)content{
    
    
    
    self.ymCommentsLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 270, 20)];
    [self.ymCommentsLab setFont:[UIFont systemFontOfSize:12]];
    [self.ymCommentsLab setTextColor:[UIColor whiteColor]];
    [self.ymCommentsLab setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.ymCommentsLab];
    
    self.ymCommentsTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 30)];
    [self.ymCommentsTitleLab setFont:[UIFont systemFontOfSize:14]];
    [self.ymCommentsTitleLab setNumberOfLines:0];
    [self.ymCommentsTitleLab setTextColor:[UIColor grayColor]];
    [self.ymCommentsTitleLab setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.ymCommentsTitleLab];
    
    self.ymCommentsBut = [[UIButton alloc] initWithFrame:CGRectMake(10, 12, 25, 15)];
    [self.ymCommentsBut.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.ymCommentsBut setBackgroundColor:[UIColor redColor]];
    [self.ymCommentsBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ymCommentsBut setTitle:@"原文" forState:UIControlStateNormal];
    [self.ymCommentsBut setAlpha:0.6];
    [self.contentView addSubview:self.ymCommentsBut];
    
    //赋值
    [self.ymCommentsLab setText:title];
    [self.ymCommentsTitleLab setText:content];

}
@end
