//  新闻版块自定义Cell
//  DMTableViewCell.h
//  DMNeteaseNews
//
//  Created by TY on 14-2-24.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DMNewsDataModel.h"
#import "DMMainFrame.h"
@interface DMTableViewCell : UITableViewCell<UIScrollViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (strong, nonatomic)UIView *ymCellView;
@property (strong, nonatomic)UILabel *ymCellUpLabel;
@property (strong, nonatomic)UILabel *ymCellDownLabel;
@property (strong, nonatomic)UIImageView *ymCellLeftIV;
//section==0 && row==0专用
@property (strong, nonatomic)UIScrollView *ymSoRoIV;
@property (strong, nonatomic)UIPageControl *ymPVCFirst;
//section != 0 && row == 0专用
@property (strong, nonatomic)UIImageView *ymSRoOne;
@property (strong, nonatomic)UIImageView *ymSRoTwo;
@property (strong, nonatomic)UIImageView *ymSRoThree;
//section最大 row最大时专用
@property (strong, nonatomic)UILabel *ymFootLab;
//专题Project
@property (strong, nonatomic)UIButton *ymProjectButton;
//独家Exclusive
@property (strong, nonatomic)UIButton *ymExclusiveButton;
//推荐Recommended
@property (strong, nonatomic)UIButton *ymRecommendedButton;
//直播Live
@property (strong, nonatomic)UIButton *ymLiveButton;
//跟帖Comments
@property (strong, nonatomic)UILabel *ymCommentsButton;
//图集picture
@property (strong, nonatomic)UIButton *ymPictureButton;

//实现scrollView循环显示
@property (nonatomic) NSInteger ymSVCycle;

-(void)gmLeftIV:(UIImage *)theIV andModelid:(NSInteger)theModelid andCommentsNum:(NSString *)theCommentsNum andTitle:(NSString*)theTitle andInfo:(NSString *)theInfo andHight:(float)theHight;

//section==0 && row==0专用
-(void)gmSectionZeroRowZero:(NSArray *)theImgArr andHight:(float)theHight andTarget:(id)target;
//section != 0 && row == 0专用
-(void)gmSectionRowZero:(BOOL)display andIVOne:(UIImage *)theImgOne andIVTwo:(UIImage *)theImgTwo andIVThree:(UIImage *)theImgThree andHight:(float)theHight;
//section最大 row最大时专用
-(void)gmFootLabel:(NSString*)theText andHight:(float)theHight;


@end
