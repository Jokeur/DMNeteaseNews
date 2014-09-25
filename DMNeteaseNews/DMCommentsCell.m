//
//  DMCommentsCell.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-6.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMCommentsCell.h"

@implementation DMCommentsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor blackColor]];
        [self.contentView setAlpha:0.8];
        
        //头像
        self.ymPhotoBut = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
        [self.ymPhotoBut.layer  setCornerRadius:10];
        [self.ymPhotoBut setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"photo20_20.jpg"]]];
        [self.contentView addSubview:self.ymPhotoBut];
        
        //网名
        self.ymNetName = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 205, 20)];
        [self.ymNetName setTextColor:[UIColor grayColor]];
        [self.ymNetName setFont:[UIFont fontWithName:@"Arial" size:12]];
        [self.ymNetName setText:@"网易网友"];
        [self.contentView addSubview:self.ymNetName];
        
        //时间
        self.ymLabTime = [[UILabel alloc] initWithFrame:CGRectMake(280, 5, 55, 20)];
        [self.ymLabTime setTextColor:[UIColor grayColor]];
        [self.ymLabTime setFont:[UIFont fontWithName:@"Arial" size:12]];
        [self.contentView addSubview:self.ymLabTime];
        
        //跟帖内容
        self.ymContentLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 300, 20)];
        [self.ymContentLab setTextColor:[UIColor whiteColor]];
        [self.ymContentLab setNumberOfLines:0];
        [self.ymContentLab setFont:[UIFont fontWithName:@"Arial" size:12]];
        [self.contentView addSubview:self.ymContentLab];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//赋值
-(void)gmCommentsCellPhoto:(UIImage *)photo andNetName:(NSString *)netName andStfId:(NSString*)StfId andTime:(NSString *)time andContent:(NSString *)content{
    
    if(photo){
         [self.ymPhotoBut setImage:photo forState:UIControlStateNormal];
    }
    if(![netName isEqualToString:@""]){
        self.ymNetName.text = netName;
    }else if(![StfId isEqualToString:@""]){
        self.ymNetName.text = StfId;
    }
    
    self.ymLabTime.text = time ;
//    self.ymContentLab.text = content;
//    [self.contentView setFrame:CGRectMake(0, 0, 320, 50)];
    
   
    [self.ymContentLab setNumberOfLines:0];
    [self.ymContentLab setText:content];
//    [self.ymContentLab setTextColor:[UIColor whiteColor]];
//    UIFont *fontTwo = [UIFont systemFontOfSize:12];
//    self.ymContentLab.font = fontTwo;
//    self.ymContentLab.lineBreakMode = NSLineBreakByTruncatingTail;
//    NSDictionary *dictTwo = [NSDictionary dictionaryWithObjectsAndKeys:fontTwo,NSFontAttributeName, nil];
//    CGSize sizeTwo = [self.ymContentLab.text boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictTwo context:nil].size;

    
}
//隐藏控件
-(void)gmHiddenControl{
    [self.ymPhotoBut setHidden:YES];
    [self.ymNetName setHidden:YES];
    [self.ymLabTime setHidden:YES];
    [self.ymContentLab setHidden:YES];
}
//热门跟帖
-(void)gmHotComments{
    [self gmHiddenControl];
    UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [but setTitle:@"热门跟帖" forState:UIControlStateNormal];
    [but setAlpha:0.6];
    [but setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:but];
    
    UILabel *labNohaveC = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 80, 30)];
    labNohaveC.text = @"暂无跟帖";
    [labNohaveC setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:labNohaveC];
    
    UIButton *butOne = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 80, 20)];
    [butOne setTitle:@"最新跟帖" forState:UIControlStateNormal];
    [butOne setAlpha:0.6];
    [butOne setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:butOne];
    
    UILabel *labNohaveCOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 80, 30)];
    labNohaveCOne.text = @"暂无跟帖";
    [labNohaveCOne setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:labNohaveCOne];
    
}
//暂无跟帖
-(void)gmNoHaveComments{
//    [self gmHiddenControl];
//    UILabel *labNohaveC = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 30)];
//    labNohaveC.text = @"暂无跟帖";
//    [labNohaveC setTextColor:[UIColor grayColor]];
//    [self.contentView addSubview:labNohaveC];
//    
//    UIButton *butOne = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 80, 20)];
//    [butOne setTitle:@"最新跟帖" forState:UIControlStateNormal];
//    [butOne setAlpha:0.6];
//    [butOne setBackgroundColor:[UIColor redColor]];
//    [self.contentView addSubview:butOne];
//    
//    UILabel *labNohaveCOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 80, 30)];
//    labNohaveCOne.text = @"暂无跟帖";
//    [labNohaveCOne setTextColor:[UIColor grayColor]];
//    [self.contentView addSubview:labNohaveCOne];
}
@end
