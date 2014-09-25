//
//  DMTailorRead.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-24.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMTailorRead.h"

@interface DMTailorRead ()

@end

@implementation DMTailorRead
@synthesize delegate = _delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *tempIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [tempIV setBackgroundColor:[UIColor blackColor]];
    tempIV.alpha = 0.8;
    [self.view addSubview:tempIV];
    
    //手势
    UISwipeGestureRecognizer *tailorGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gmTailorGRAction)];
    [tailorGR setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:tailorGR];
    
    
    //UIScrollView
    UIScrollView *commentSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
    [self.view addSubview:commentSV];
    
    
    //我的订阅
    UIView *tempV = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 2, 20)];
    [tempV setBackgroundColor:[UIColor redColor]];
    UILabel *tempLabo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [tempLabo setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:tempLabo];
    UILabel *tempLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 18*4, 20)];
    
    tempLab.text = @"我的订阅";
    [tempLab setTextColor:[UIColor whiteColor]];
    [tempLab setFont:[UIFont fontWithName:@"Font" size:12]];
    [self.view addSubview:tempLab];
    [self.view addSubview:tempV];
    
    
    
    
    //添加订阅
    UIButton *addComment = [UIButton buttonWithType:UIButtonTypeSystem];
    [addComment setFrame:CGRectMake(10, 45, 300, 50 )];
    [addComment setBackgroundColor:[UIColor blackColor]];

    [addComment setTitle:@"添加订阅" forState:UIControlStateNormal];
    [addComment.titleLabel setFont:[UIFont fontWithName:@"Font" size:10]];
    [addComment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addComment.layer setCornerRadius:5];
    [addComment addTarget:self action:@selector(gmAddCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    [addComment setAlpha:0.5];
    [self.view addSubview:addComment];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//手势
-(void)gmTailorGRAction{
    [UIView animateWithDuration:0.2 animations:^{
        [_delegate gmFristTitleDisplay];
    } completion:^(BOOL finished){

    }];
}


//添加订阅
-(void)gmAddCommentAction:(id)sender{
    
    if(!self.ymTailorCommend){
        self.ymTailorCommend = [[DMTailorCommend alloc] init];
        [self.ymTailorCommend.view setFrame:CGRectMake(320, 0, 320, 420)];
    }
    
    [[self.view superview] addSubview:self.ymTailorCommend.view];

    
    [UIView animateWithDuration:0.2 animations:^{
        [self.ymTailorCommend.view setFrame:CGRectMake(0, 0, 320, 460)];
    
    } completion:^(BOOL finished){
    
    }];
}
@end
