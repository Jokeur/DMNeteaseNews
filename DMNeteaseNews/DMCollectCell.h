//  收藏版块，自定义Cell 
//  DMCollectCell.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-9.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMTableViewCell.h"

@interface DMCollectCell : DMTableViewCell

//新闻收藏
@property (strong, nonatomic)UILabel *ymNewsTitleLab;
@property (strong, nonatomic)UILabel *ymNewsContentLab;
@property (strong, nonatomic)UILabel *ymNewsCommentsLab;

//图片收藏
@property (strong, nonatomic)UIImageView *ymPictureV;
@property (strong, nonatomic)UILabel *ymPictureLab;
@property (strong, nonatomic)UILabel *ymPictureCommentsLab;

//跟帖收藏
@property (strong, nonatomic)UIButton *ymCommentsBut;
@property (strong, nonatomic)UILabel *ymCommentsLab;
@property (strong, nonatomic)UILabel *ymCommentsTitleLab;


//新闻收藏
-(void)gmNewsCollectTitle:(NSString *)title andContent:(NSString *)content andComments:(NSString *)comments;
//图片收藏
-(void)gmPictureCollectImage:(NSMutableArray *)image andPictureLab:(NSString *)label andComments:(NSString *)comments;
//跟帖收藏
-(void)gmCommentCollectTitle:(NSString *)title andContent:(NSString *)content;

@end
