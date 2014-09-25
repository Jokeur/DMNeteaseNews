//
//  DMSetRight.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-23.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMSetRight.h"

@interface DMSetRight ()

@end

@implementation DMSetRight

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
    //ScrollView
    UIView *tempSV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
//    [tempSV setContentSize:CGSizeMake(320, 460*2)];
    [self.view addSubview:tempSV];
    [tempSV setBackgroundColor:[UIColor blackColor]];
//    tempSV.showsHorizontalScrollIndicator = NO;
//    tempSV.showsVerticalScrollIndicator = NO;
    

    UIImageView *tempIVThree = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 0, 276.5, 42.5)];
    [tempIVThree setImage:[UIImage imageNamed:@"setNight111.jpg"]];
    [tempSV addSubview:tempIVThree];
    
    UIButton *leftUpBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42.5, 42.5)];
    [leftUpBut setImage:[UIImage imageNamed:@"displayUpLeft111.jpg"] forState:UIControlStateNormal];
    [leftUpBut addTarget:self action:@selector(gmLeftUpBut) forControlEvents:UIControlEventTouchUpInside];
    [tempSV addSubview:leftUpBut];

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
