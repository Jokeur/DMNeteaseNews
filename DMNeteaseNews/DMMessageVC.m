//
//  DMMessageVC.m
//  DMNeteaseNews
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMMessageVC.h"

@interface DMMessageVC ()

@end

@implementation DMMessageVC

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
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
    
    //修理标题栏
    UIImageView *tempIVThree = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 0, 276.5, 42.5)];
    [tempIVThree setImage:[UIImage imageNamed:@"messageNight11.jpg"]];
    [self.view addSubview:tempIVThree];
    
    UIButton *leftUpBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42.5, 42.5)];
    [leftUpBut addTarget:self action:@selector(gmLeftUpBut) forControlEvents:UIControlEventTouchUpInside];
    [leftUpBut setImage:[UIImage imageNamed:@"displayUpLeft111.jpg"] forState:UIControlStateNormal];

    [self.view addSubview:leftUpBut];
    
  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//菜单栏，左上方Button
-(void)gmLeftUpBut{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(320, 20, 320, 460)];
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
    
}
@end
