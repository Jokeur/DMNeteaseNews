//
//  DMNightDayVC.m
//  DMNeteaseNews
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMNightDayVC.h"

@interface DMNightDayVC ()

@end

@implementation DMNightDayVC

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
    
    [tempIV setImage:[UIImage imageNamed:@"weatherMark1_480_760.jpg"]];
    [self.view addSubview:tempIV];
    
    UIButton *leftUpBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [leftUpBut addTarget:self action:@selector(gmLeftUpBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftUpBut];
    
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//菜单栏，左上方Button
-(void)gmLeftUpBut{
    [self.view removeFromSuperview];
    
    
}
@end
