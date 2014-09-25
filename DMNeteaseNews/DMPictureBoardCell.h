//
//  DMPictureBoardCell.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-8.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMPictureBoardCell : UITableViewCell

@property (strong, nonatomic)UIImageView *ymImgVLeft;
@property (strong, nonatomic)UIImageView *ymImgVRightUp;
@property (strong, nonatomic)UIImageView *ymImgVRightDown;
@property (strong, nonatomic)UILabel *ymLabelDown;
@property (strong, nonatomic)UILabel *ymComments;

//cell赋值
-(void)gmPictureTitleCellImage:(NSMutableArray *)imgArr andTitle:(NSString *)title andComment:(NSString *)comment;


@end
