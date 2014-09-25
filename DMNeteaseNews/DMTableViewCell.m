//
//  DMTableViewCell.m
//  DMNeteaseNews
//
//  Created by TY on 14-2-24.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMTableViewCell.h"

@implementation DMTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //View
        self.ymCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, MAXFLOAT)];
        [self.ymCellView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
        
        //UIImageView
        self.ymCellLeftIV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        [self.ymCellView addSubview:self.ymCellLeftIV];
        
        //UILabel
        self.ymCellUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 3, 215+35, 15)];
        self.ymCellDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 215+35, 35)];
        [self.ymCellUpLabel setTextColor:[UIColor whiteColor]];
        [self.ymCellDownLabel setTextColor:[UIColor grayColor]];
        
        [self.ymCellUpLabel setFont:[UIFont fontWithName:@"Arial" size:12]];
        [self.ymCellDownLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        [self.ymCellDownLabel setNumberOfLines:2];

        
        [self.ymCellView addSubview:self.ymCellUpLabel];
        [self.ymCellView addSubview:self.ymCellDownLabel];
        
        //专题project
        self.ymProjectButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 42, 30, 12)];
        [self.ymCellView addSubview:self.ymProjectButton];
        [self.ymProjectButton setBackgroundColor:[UIColor redColor]];
        [self.ymProjectButton setTitle:@"专题" forState:UIControlStateNormal];
        [self.ymProjectButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        
        //独家exclusive
        self.ymExclusiveButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 42, 30, 12)];
        [self.ymCellView addSubview:self.ymExclusiveButton];
        [self.ymExclusiveButton setBackgroundColor:[UIColor brownColor]];
        [self.ymExclusiveButton setTitle:@"独家" forState:UIControlStateNormal];
        [self.ymExclusiveButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        //推荐recommended
        
        self.ymRecommendedButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 42, 30, 12)];
        [self.ymCellView addSubview:self.ymRecommendedButton];
        [self.ymRecommendedButton setBackgroundColor:[UIColor redColor]];
        [self.ymRecommendedButton setTitle:@"推荐" forState:UIControlStateNormal];
        [self.ymRecommendedButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        //直播live
        
        self.ymLiveButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 42, 30, 12)];
        [self.ymCellView addSubview:self.ymLiveButton];
        [self.ymLiveButton setBackgroundColor:[UIColor orangeColor]];
        [self.ymLiveButton setTitle:@"视频" forState:UIControlStateNormal];
        [self.ymLiveButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        
        
        //图集picture
        self.ymPictureButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 42, 30, 12)];
        [self.ymCellView addSubview:self.ymPictureButton];
        [self.ymPictureButton setBackgroundColor:[UIColor blueColor]];
        [self.ymPictureButton setTitle:@"组图" forState:UIControlStateNormal];
        [self.ymPictureButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        
        //跟帖comments
        self.ymCommentsButton = [[UILabel alloc] initWithFrame:CGRectMake(225, 42, 90, 12)];
        [self.ymCellView addSubview:self.ymCommentsButton];
        [self.ymCommentsButton setBackgroundColor:[UIColor clearColor]];
        [self.ymCommentsButton setTextAlignment:NSTextAlignmentRight];
        [self.ymCommentsButton setTextColor:[UIColor grayColor]];
        [self.ymCommentsButton setFont:[UIFont fontWithName:@"Arial" size:10]];

        
        [self.contentView addSubview:self.ymCellView];
        //隐藏所有Button
        [self gmHiddenAllButton];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)gmLeftIV:(UIImage *)theIV andModelid:(NSInteger)theModelid andCommentsNum:(NSString *)theCommentsNum andTitle:(NSString*)theTitle andInfo:(NSString *)theInfo andHight:(float)theHight{
    //隐藏所有Button
    [self gmHiddenAllButton];
    
    [self.ymCellView setFrame:CGRectMake(0, 0, 320, theHight)];
    [self.ymCellLeftIV setImage:theIV];
    [self.ymCellUpLabel setText:theTitle];
    [self.ymCellDownLabel setText:theInfo];
    
    BOOL result = NO;
    if(theModelid == 2){
        [self.ymPictureButton setHidden:NO];
        result = YES;
    }else if(theModelid == 4){
          [self.ymLiveButton setHidden:NO];
        result = YES;
    
    }else if(theModelid == 5){
            [self.ymExclusiveButton setHidden:NO];
        result = YES;
        
    }else if(theModelid == 9){
        
        [self.ymRecommendedButton setHidden:NO];
        result = YES;
        
    }else if(theModelid == 10){
          [self.ymProjectButton setHidden:NO];
        result = YES;
        
    }
        [self.ymCommentsButton setHidden:NO];
        [self.ymCommentsButton setText:[NSString stringWithFormat:@"%@跟帖",theCommentsNum]];

    
    if(result){
        [self.ymCommentsButton setFrame:CGRectMake(195, 40, 90, 15)];
    }



   
}
//section==0 && row==0专用
-(void)gmSectionZeroRowZero:(NSArray *)theImgArr andHight:(float)theHight andTarget:(id)target{
    self.ymSVCycle = [theImgArr count]+2;
    
    //ScrollView
    self.ymSoRoIV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, theHight)];
    [self.ymSoRoIV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];

    //为了实现循环
    [self.ymSoRoIV setContentSize:CGSizeMake(320*self.ymSVCycle,theHight )];
    [self.ymSoRoIV setContentOffset:CGPointMake(320, 0)];
    [self.ymSoRoIV setBounces:NO];//不反弹
    [self.ymSoRoIV setPagingEnabled:YES];//整页翻动
    [self.ymCellView addSubview:self.ymSoRoIV];
    self.ymSoRoIV.showsHorizontalScrollIndicator=NO; //不显示水平滑动线
    self.ymSoRoIV.showsVerticalScrollIndicator=NO;//不显示垂直滑动线
    
    //设置代理
    [self.ymSoRoIV setDelegate:self];
    [self.ymCellView setFrame:CGRectMake(0, 0, 320, theHight)];
    for(int i = 0;i < self.ymSVCycle ; i ++){

        UIImageView *tempImg = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, theHight)];
        //imageView接收点击事件
        UITapGestureRecognizer *TapImgV = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gmTapGestureRecognizerAction:)];
        [tempImg addGestureRecognizer:TapImgV];
        
        if([theImgArr count]> 0){
        if(i == 0){
            
                [tempImg setImage:[theImgArr objectAtIndex:self.ymSVCycle-3]];
            
            
        }else if(i == self.ymSVCycle-1){
            [tempImg setImage:[theImgArr objectAtIndex:0]];
        }else{
            [tempImg setImage:[theImgArr objectAtIndex:i-1]];
        }
            }
        [self.ymSoRoIV addSubview:tempImg];
    }
    
    //UIPageControl
    self.ymPVCFirst = [[UIPageControl alloc] init];
    //UIPageControl
    [self.ymPVCFirst setFrame:CGRectMake(350 - (self.ymSVCycle+2)*15, theHight-15, (self.ymSVCycle+2)*15, 10)];
    
    self.ymPVCFirst.numberOfPages = self.ymSVCycle-2;//总共多少页
    self.ymPVCFirst.currentPage = 0;//默认选中第几页
    [self.ymCellView addSubview:self.ymPVCFirst ];
   
    
    [self.ymPVCFirst setDefersCurrentPageDisplay:YES];
//    self.ymPVCFirst.userInteractionEnabled=NO; //pagecontroller不响应点击操作
    
    if([theImgArr count] > 10){
         self.ymPVCFirst.alpha=0; //设置pageController 不可见
    }

    //添加委托
    
    [self.ymPVCFirst addTarget:self action:@selector(gmPVCFristAction) forControlEvents:UIControlEventTouchDown];
    
    
}
//imageView接收点击事件
-(void)gmTapGestureRecognizerAction:(id)recognizer{
    
}
//section != 0 && row == 0专用
-(void)gmSectionRowZero:(BOOL)display andIVOne:(UIImage *)theImgOne andIVTwo:(UIImage *)theImgTwo andIVThree:(UIImage *)theImgThree andHight:(float)theHight{
 
    self.ymSRoOne = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, theHight)];
    self.ymSRoTwo = [[UIImageView alloc] initWithFrame:CGRectMake(5+105, 5, 100, theHight)];
    self.ymSRoThree = [[UIImageView alloc] initWithFrame:CGRectMake(5+105+105, 5, 100, theHight)];
    
    [self.ymCellView setFrame:CGRectMake(0, 0, 320, theHight)];
    
    [self.ymCellView addSubview:self.ymSRoOne];
    [self.ymCellView addSubview:self.ymSRoTwo];
    [self.ymCellView addSubview:self.ymSRoThree];
    
    [self.ymSRoOne setHighlighted:display];
    [self.ymSRoTwo setHighlighted:display];
    [self.ymSRoThree setHighlighted:display];
    
    [self.ymSRoOne setImage:theImgOne];
    [self.ymSRoTwo setImage:theImgTwo];
    [self.ymSRoThree setImage:theImgThree];
}
//section最大 row最大时专用
-(void)gmFootLabel:(NSString*)theText andHight:(float)theHight{

    self.ymFootLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, theHight)];
    [self.ymFootLab setTextAlignment:NSTextAlignmentCenter];
    [self.ymFootLab setText:theText];
    [self.ymCellView addSubview:self.ymFootLab];
    [self.ymCellView setFrame:CGRectMake(0, 0, 320, theHight)];

}
//隐藏不需要的Button
-(void)gmHiddenAllButton{
    //设置隐藏
    [self.ymProjectButton setHidden:YES];
    [self.ymExclusiveButton setHidden:YES];
    [self.ymRecommendedButton setHidden:YES];
    [self.ymLiveButton setHidden:YES];
    [self.ymPictureButton setHidden:YES];
    [self.ymCommentsButton setHidden:YES];


}

#pragma mark UIScrollViewDelegate

// any offset changes
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint thePoint = [scrollView contentOffset];
    
    if(thePoint.x / 320 == 0){
        self.ymPVCFirst.currentPage = self.ymSVCycle - 2;
    
    }
    else if (thePoint.x / 320 == self.ymSVCycle - 1) {
        self.ymPVCFirst.currentPage = 0;
    }
    else{
         self.ymPVCFirst.currentPage = thePoint.x / 320 - 1;
    
    }
   
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint thePoint = [scrollView contentOffset];
    
    if(thePoint.x/320 == self.ymSVCycle-1){
        scrollView.contentOffset = CGPointMake(320, 0);
        self.ymPVCFirst.currentPage = 0;
    }else if(thePoint.x/320 == 0){
        scrollView.contentOffset = CGPointMake((self.ymSVCycle-2)*320, 0);
        self.ymPVCFirst.currentPage = self.ymSVCycle-2;
        
    }


}
//UIPageControl关联方法
-(void)gmPVCFristAction{
    int page = self.ymPVCFirst.currentPage;
    [self.ymSoRoIV setContentOffset:CGPointMake(320*page+320, 0)];

}

@end
