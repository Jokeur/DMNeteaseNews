//
//  DMEdition.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-24.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMEdition.h"

@interface DMEdition ()

@end

@implementation DMEdition

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
    
    if(!self.ymEditionSV){
        self.ymEditionSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460 )];
    }
    
    
    [self.ymEditionSV setContentSize:CGSizeMake(320*4, 460)];
    self.ymEditionSV.pagingEnabled = YES;
    self.ymEditionSV.showsHorizontalScrollIndicator = NO;
    self.ymEditionSV.showsVerticalScrollIndicator = NO;
    self.ymEditionSV.alwaysBounceHorizontal = NO;
    
    //默认是yes,就是滚动超过边界,会反弹有反弹回来的效果,假如是 NO,那么滚动到达边界,那么会连忙停止
    self.ymEditionSV.bounces = NO;
    NSMutableArray *mArrTemp = [[NSMutableArray alloc] initWithObjects:@"edition1.jpg",@"edition2.jpg",@"edition3.jpg",@"edition4.jpg", nil];
    for(int j = 0 ; j < 4 ; j ++){
        UIImageView *editionIV = [[UIImageView alloc] initWithFrame:CGRectMake(j*320, 0, 320, 460)];
        [editionIV setImage:[UIImage imageNamed:[mArrTemp objectAtIndex:j]]];
        
        [self.ymEditionSV addSubview:editionIV];
        
    }
    
    [self.view addSubview:self.ymEditionSV];//////////////
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
