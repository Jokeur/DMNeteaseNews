//
//  DMBallot.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-24.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMBallot.h"

@interface DMBallot ()

@end

@implementation DMBallot
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

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
    
    
    //手势
    UISwipeGestureRecognizer *ballotGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gmBallotGRAction)];
    [ballotGR setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:ballotGR];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//手势
-(void)gmBallotGRAction{
    
    
    [UIView animateWithDuration:0.2 animations:^{
        [_delegate gmFristTitleDisplay];
    } completion:^(BOOL finished){}];

}
@end
