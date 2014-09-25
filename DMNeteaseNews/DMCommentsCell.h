//  跟帖版块，自定义Cell
//  DMCommentsCell.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-6.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMCommentsCell : UITableViewCell

//头像
@property(strong, nonatomic)UIButton *ymPhotoBut;
//网名
@property(strong, nonatomic) UILabel *ymNetName;
//时间
@property(strong, nonatomic)UILabel *ymLabTime;
//跟帖内容
@property(strong, nonatomic)UILabel *ymContentLab;

//赋值
-(void)gmCommentsCellPhoto:(UIImage *)photo andNetName:(NSString *)netName andStfId:(NSString*)StfId andTime:(NSString *)time andContent:(NSString *)content;
//热门跟帖
-(void)gmHotComments;
//暂无跟帖
-(void)gmNoHaveComments;


@end
