//
//  DMMainEnter.m
//  CopyNeteaseNews
//
//  Created by Geimin on 14-2-18.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMMainEnter.h"

@interface DMMainEnter ()

@end

@implementation DMMainEnter

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *backIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    [self.view addSubview:backIV];
    [backIV setImage:[UIImage imageNamed:@"backq22.jpg"]];

    //左侧右侧弹出是用View遮住self.ymMainFrame.view
    if(!self.ymTopView){
        self.ymTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    }
    
    //左侧视图和右侧视图的，宽度
    self.ymLeftF = 180.0;
    self.ymRightF = 230.00;
    
    //左侧导航栏定义
    [self gmLeftControl];
    
    //右侧User栏定义
    [self gmRightUser];
    
    //mainframe的添加
    [self gmMainFrameSet];
    
    //数据传递,单例
    
    [DMJSONParse sharedJSONParseMethod];
    
    
    //网络监测
    //设置通知，网络改变时触发
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNetwork:) name:kReachabilityChangedNotification object:nil];
   //创建Reachability对象
    self.ymNetwork = [Reachability reachabilityForInternetConnection];
    
    //开始监听网络
    [self.ymNetwork startNotifier];
    
}
#pragma mark - 网络检测

//判断当前是什么网络
-(void)checkNetwork{
     NetworkStatus status = [self.ymNetwork currentReachabilityStatus];
    //没有网的时候进行提示
    if (status==kNotReachable) {
        [self messageBox:@"没有网络"];
        
    }else if (status==kReachableViaWWAN){
        [self messageBox:@"正在使用2G/3G网络\n本操作将花费大量流量，是否继续？"];
        
    }else if (status==kReachableViaWiFi){
//        [self messageBox:@"正在使用wifi网络"];
        [DMLeaveLine gmRequestLeaveLinePageSize:50 andCatidNum:12];
    }
}
//网络响应提示
-(void)messageBox:(NSString *)string{
    if([string isEqualToString:@"没有网络"]){
        UIAlertView *alertNO=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil , nil];
        [alertNO show];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"放弃", nil];
        alert.tag = 3333;
        [alert show];
    }
}

//网络改变时调用
-(void)changeNetwork:(NSNotification *)notification{
    [self checkNetwork];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//左侧右侧弹出是用View遮住self.ymMainFrame.view
-(void)gmTopView{
    if(!self.ymMainFrame){
        self.ymMainFrame = [[DMMainFrame alloc] init];
        [self.view addSubview:self.ymMainFrame.view];
        [self.ymMainFrame.view setFrame:CGRectMake(0, 20, 320, 460)];
    }
    
    [self.ymMainFrame.view addSubview:self.ymTopView];
    [self.ymTopView setHidden:NO];
    
    //ymTopView一个向右的手势，一个向左的手势
    UISwipeGestureRecognizer *topSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gmTopSwipeLeft)];
    UISwipeGestureRecognizer *topSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gmTopSwipeRight)];
    [topSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [topSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.ymTopView addGestureRecognizer:topSwipeRight];
    [self.ymTopView addGestureRecognizer:topSwipeLeft];
    
    //ymTopView 添加点击手势，位置还原
    UITapGestureRecognizer *topTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gmTopTapGesture)];
    [self.ymTopView addGestureRecognizer:topTapGesture];

}
// //ymTopView一个向右的手势，一个向左的手势
-(void)gmTopSwipeLeft{
    [self gmSwipeLeft];
    
}
-(void)gmTopSwipeRight{
    
    [self gmSwipeRight];
}
//ymTopView 添加点击手势，位置还原
-(void)gmTopTapGesture{
    [self gmSwipeLeft];

}

//左侧背面视图，响应方法
-(void)gmSwipeLeftBack{
    [self.ymRightView setHidden:YES];
    [self.ymLeftView setHidden:NO];
    [self gmTopView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.ymMainFrame.view setFrame:CGRectMake(self.ymLeftF, 20, 320, 460)];
    }];
 
}
-(void)gmSwipeLeft{
   
    [UIView animateWithDuration:0.5 animations:^{
        [self.ymMainFrame.view setFrame:CGRectMake(0, 20, 320, 460)];
     }];
    [self.ymTopView setHidden:YES];
}

//右侧背面视图，响应方法
-(void)gmSwipeRightBack{
      [self.ymLeftView setHidden:YES];
    [self.ymRightView setHidden:NO];
        [self gmTopView];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.ymMainFrame.view setFrame:CGRectMake(-self.ymRightF, 20, 320, 460)];
    }];
    
}
-(void)gmSwipeRight{
    [UIView animateWithDuration:0.5 animations:^{
        [self.ymMainFrame.view setFrame:CGRectMake(0, 20, 320, 460)];

    }];
    [self.ymTopView setHidden:YES];
    
}
//左侧导航栏定义
-(void)gmLeftControl{
    if(!self.ymMArrLeft){
        self.ymMArrLeft = [[NSMutableArray alloc] initWithObjects:@"left11.jpg",@"left12.jpg",@"left21.jpg",@"left22.jpg",@"left31.jpg",@"left32.jpg",@"left41.jpg",@"left42.jpg",@"left51.jpg",@"left52.jpg",nil];
    }
    //存储左边 导航栏 Button
    if(!self.ymLeftButton){
        self.ymLeftButton = [[NSMutableArray alloc] init];
    }
    //左侧背面视图定义
    if(!self.ymLeftView){
        self.ymLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.ymLeftF, 460)];
        [self.ymLeftView setBackgroundColor:[UIColor blackColor]];
        [self.ymLeftView setHidden:YES];
        [self.view addSubview:self.ymLeftView];
        
        for(int i = 0 ;i < 5;i ++){
            UIButton *LeftBut = [[UIButton alloc] initWithFrame:CGRectMake(0, i*60, 180, 60)];
            
            [LeftBut addTarget:self action:@selector(gmLeftBut:) forControlEvents:UIControlEventTouchDown ];
            
            [LeftBut setTag:i+100];
            [self.ymLeftView addSubview:LeftBut];
            [LeftBut setBackgroundImage:[UIImage imageNamed:[self.ymMArrLeft  objectAtIndex:i*2]] forState:UIControlStateNormal];
            [self.ymLeftButton addObject:LeftBut];
            
            if(i == 0){
                [LeftBut setBackgroundImage:[UIImage imageNamed:[self.ymMArrLeft  objectAtIndex:i*2 +1]] forState:UIControlStateNormal];
            }
        }
        self.ymJudgeFirstTitle = 100;
        
        UIImageView *imgVOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, 180, 100)];
        [imgVOne setImage:[UIImage imageNamed:@"left61.jpg"]];
        [self.ymLeftView addSubview:imgVOne];
        
        UIButton *theBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, 180, 60)];
        [theBut setImage:[UIImage imageNamed:@"left71.jpg"] forState:UIControlStateNormal];
        [theBut addTarget:self action:@selector(gmLeftEndButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.ymLeftView addSubview:theBut];
        
    }
    //左侧相关手势定义
    UISwipeGestureRecognizer *ymSwipeLeftBack = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gmSwipeLeft)];

    [ymSwipeLeftBack setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.ymLeftView addGestureRecognizer:ymSwipeLeftBack];
}
///右侧User栏定义
-(void)gmRightUser{
    //右侧背面视图定义，
    if(!self.ymRightView){
        self.ymRightView = [[UIView alloc] initWithFrame:CGRectMake(320-self.ymRightF, 20, self.ymRightF, 460)];
        UIImageView *rightV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.ymRightF, 460)];
        
        [rightV setImage:[UIImage imageNamed:@"right111.jpg"]];
         [self.ymRightView addSubview:rightV];
         
        [self.ymRightView setHidden:YES];
        [self.view addSubview:self.ymRightView];
    }
    
    //用户中心，头像
    self.ymHeadPhoto = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.ymHeadPhoto setFrame:CGRectMake(74, 10, 75, 75)];
    [self.ymHeadPhoto setBackgroundColor:[UIColor clearColor]];
    self.ymHeadPhoto.layer.masksToBounds = YES;
    [self.ymHeadPhoto.layer setCornerRadius:37.5];
    [self.ymHeadPhoto addTarget:self action:@selector(gmUserPhotoButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ymRightView addSubview:self.ymHeadPhoto];
    
    //注册通知，更改头像
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gmHeadPhotoChange:) name:@"gmHeadPhotoChange" object:nil];
    
    //右侧相关手势定义
    UISwipeGestureRecognizer *ymSwipeRightEnter = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gmSwipeRight)];
  
    [ymSwipeRightEnter setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.ymRightView addGestureRecognizer:ymSwipeRightEnter];
    
    //立即登陆Button
    self.ymLandingLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 88, 230, 20)];
    [self.ymLandingLab setTextAlignment:NSTextAlignmentCenter];
    [self.ymLandingLab setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"right230_20_2.jpg"]]];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gmLandingLabel:) name:@"gmLandingLabel" object:nil];
    
    [self.ymLandingLab setHidden:YES ];
    [self.ymLandingLab setTextColor:[UIColor whiteColor]];
    [self.ymLandingLab setText:@""];
    [self.ymRightView addSubview:self.ymLandingLab];
    
//右侧弹出View的BUtton设置
    [self gmRightViewButton];
}
//注册通知，更改头像
-(void)gmHeadPhotoChange:(id)sender{
    UIImage *img = (UIImage *)[[sender userInfo] objectForKey:@"headPhoto"];

    [self.ymHeadPhoto setBackgroundImage:img forState:UIControlStateNormal];;
}
//用户中心，头像Button,
-(void)gmUserPhotoButton:(id)sender{
    if(![[DMJSONParse gmPassValue:@""] isEqualToString:@""]){
        //登录成功进入 用户信息管理

        if(!self.ymUserManeger){
            self.ymUserManeger = [[DMUserManager alloc] init];
            self.ymUserManeger.ymUserModelManager = self.ymUserModel;//用户登录返回信息
            [self.ymUserManeger.view setFrame:CGRectMake(320, 20, 320, 460)];
        
            [self.view addSubview:self.ymUserManeger.view];
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.ymUserManeger.view setFrame:CGRectMake(0, 20, 320, 460)];
        } completion:^(BOOL finished){}];
    }else{
        self.ymUserManeger = nil;
    }
}
//立即登陆Button
//注册通知
-(void)gmLandingLabel:(id)sender{
    NSString *strTemp = [[sender userInfo] objectForKey:@"StfId"];

    [self.ymLandingLab setText:strTemp];
  
    if(![strTemp isEqualToString:@""]){
        //用户登录返回信息
        self.ymUserModel = (DMUserModel *)[[sender userInfo] objectForKey:@"user"];
        
        UIImage *imgTemp = (UIImage *)[[sender userInfo] objectForKey:@"headImg"];
        if(imgTemp){
          [self.ymHeadPhoto setBackgroundImage:imgTemp forState:UIControlStateNormal];
        }
       
        [self.ymLandingLab setHidden:NO ];
    }else{
        [self.ymLandingLab setHidden:YES ];
        [self.ymHeadPhoto setBackgroundImage:nil forState:UIControlStateNormal];
        
    }

    //响应发表评论通知
    if(![self.ymLandingLab.text isEqualToString:@""]){
        NSNotification *notificationUserId = [[NSNotification alloc] initWithName:@"gmAppearONotification" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys:self.ymLandingLab.text,@"UserId" ,nil]];
        [[NSNotificationCenter defaultCenter] postNotification:notificationUserId];
        
        [DMJSONParse gmPassValue:self.ymLandingLab.text];
    }
}

//右侧弹出View的BUtton定义
-(void)gmRightViewButton{
    //定义几个Float 便于以后调试
    float markX = 0;
    float markY = 260;
    float markW = 76;
    float markH = 45;
    
    //登陆Button
    UIButton *logInBut = [[UIButton alloc] initWithFrame:CGRectMake(75, 85, 75, 25)];
    [logInBut setBackgroundColor:[UIColor clearColor]];/////
    [logInBut setAlpha:0.5];
    [logInBut addTarget:self action:@selector(gmLogInEnter) forControlEvents:UIControlEventTouchUpInside];
    [self.ymRightView addSubview:logInBut];

    //存储图片名
    NSMutableArray *pictureRight = [[NSMutableArray alloc] initWithObjects:@"right10.jpg",@"right11.jpg",@"right12.jpg",@"right20.jpg",@"right21.jpg",@"right22.jpg",@"right30.jpg",@"right31.jpg",@"right32.jpg",@"right211.jpg",@"right222.jpg", nil];
    if(!self.ymMarkLeftBuTArr){
        self.ymMarkLeftBuTArr = [[NSMutableArray alloc] init];
    
    }
    [self.ymMarkLeftBuTArr removeAllObjects];
    
    //下面的标签选项
    for(int i = 0 ; i < 3;i ++){
            for(int j = 0 ; j < 3;j ++){
        
                UIButton *tempMark = [[UIButton alloc] initWithFrame:CGRectMake(markX+(j%3)*(markW+1), markY+(i%3)*(markH+1), markW, markH)];
                [tempMark setBackgroundColor:[UIColor blueColor]];
               
                [tempMark setImage:[UIImage imageNamed:[pictureRight objectAtIndex:(i*3)+j]] forState:UIControlStateNormal];
                tempMark.tag = (10000+(i*3)+j)*7;
                
                [tempMark setSelected:YES];
                
                //右侧下发所有标签关联到一个事件上
                [tempMark addTarget:self action:@selector(gmRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.ymMarkLeftBuTArr addObject:tempMark];
                [self.ymRightView addSubview:tempMark];
                
            }
    }
    //设置Button控件
    UIButton *tempSetBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 420, 70, 40)];
    [self.ymRightView addSubview:tempSetBut];
    [tempSetBut addTarget:self action:@selector(gmTempSetBut) forControlEvents:UIControlEventTouchUpInside];
   
    //版本Button控件
    UIButton *tempEditionBut = [[UIButton alloc] initWithFrame:CGRectMake(160, 420, 70, 40)];

    [self.ymRightView addSubview:tempEditionBut];
    [tempEditionBut addTarget:self action:@selector(gmTempEditionBut) forControlEvents:UIControlEventTouchUpInside];

}
//登陆Button跳转入口,点击立即登录
-(void)gmLogInEnter{
  
    //未登陆是就跳转到登陆界面
    if([[DMJSONParse gmPassValue:@""] isEqualToString:@""]){
    
        if(!self. ymEnterLand){
            self. ymEnterLand = [[DMEnterLand alloc] init];
            [self. ymEnterLand.view setFrame:CGRectMake(320, 20, 320, 460)];
        }
        [self.view addSubview:self.ymEnterLand.view];
        self.ymTakeOver = self.ymEnterLand.view;
    
        [UIView animateWithDuration:0.25 animations:^{
            [self.ymEnterLand.view setFrame:CGRectMake(0, 20, 320, 460)];
        
        } completion:^(BOOL finished){}];
    }else{
    //登陆后就跳转至另一个界面
    
    
    }
}
//右侧下发所有标签关联到一个事件上
-(void)gmRightButtonAction:(id)sender{
   
    UIButton *theButton = (UIButton * )sender;
    //0收藏
    if(theButton.tag == (10000+0)*7){
        self.ymCollectVC = nil;
        if(!self.ymCollectVC){
            self.ymCollectVC = [[DMCollectVC alloc] init];
            [self.ymCollectVC.view setFrame:CGRectMake(320, 20, 320, 460)];
            [self.view addSubview:self.ymCollectVC.view];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.ymCollectVC.view setFrame:CGRectMake(0, 20, 320, 460)];
            
        } completion:^(BOOL finished){}];
    }
    //1跟帖
    if(theButton.tag == (10000+1)*7){

        //如果已经登录，则进入更贴界面
        if(![[DMJSONParse gmPassValue:@""] isEqualToString:@""]){
            //我的跟帖
            self.ymFollowUpVC = nil;
            if(!self.ymFollowUpVC){
                self.ymFollowUpVC = [[DMFollowUpVC alloc] init];
                
                [self.ymFollowUpVC.view setFrame:CGRectMake(320, 20, 320, 460)];
                [self.view addSubview:self.ymFollowUpVC.view];
            }
            [UIView animateWithDuration:0.25 animations:^{
                [self.ymFollowUpVC.view setFrame:CGRectMake(0, 20, 320, 460)];
                
            } completion:^(BOOL finished){}];
            
        }else{
        //未登录时
            [self gmLogInEnter];
        }
    }
    //2消息
    if(theButton.tag == (10000+2)*7){
        self.ymMessageVC = nil;
        if(!self.ymMessageVC){
            self.ymMessageVC = [[DMMessageVC alloc] init];
            [self.ymMessageVC.view setFrame:CGRectMake(320, 20, 320, 460)];
        }
        [self.view addSubview:self.ymMessageVC.view];
        [UIView animateWithDuration:0.25 animations:^{
            [self.ymMessageVC.view setFrame:CGRectMake(0, 20, 320, 460)];
            
        } completion:^(BOOL finished){}];
    }
    //3天气
    if(theButton.tag == (10000+3)*7){
        self.ymWeatherVC = nil;
        if(!self.ymWeatherVC){
            self.ymWeatherVC = [[DMWeather alloc] init];
            [self.ymWeatherVC.view setFrame:CGRectMake(320, 20, 320, 460)];
        }
        [self.view addSubview:self.ymWeatherVC.view];
        [UIView animateWithDuration:0.25 animations:^{
            [self.ymWeatherVC.view setFrame:CGRectMake(0, 20, 320, 460)];
            
        } completion:^(BOOL finished){}];
    }
    //4离线，下载
    if(theButton.tag == (10000+4)*7){
            [theButton setImage:[UIImage imageNamed:@"right2111.jpg"] forState:UIControlStateNormal];
            
            //获得当前网络
            [self checkNetwork];
    }
    //5夜间。白天
    if(theButton.tag == (10000+5)*7){
        if(theButton.isSelected){
            
            [theButton setImage:[UIImage imageNamed:@"right2222.jpg"] forState:UIControlStateNormal];
            [theButton setSelected:NO];
        }
        else{
            [theButton setImage:[UIImage imageNamed:@"right22.jpg"] forState:UIControlStateNormal];
           [theButton setSelected:YES];
        }

    }
    
    //6搜索
    if(theButton.tag == (10000+6)*7){
        self.ymSearchVC = nil;
        if(!self.ymSearchVC){
            self.ymSearchVC = [[DMSearchVC alloc] init];
            [self.ymSearchVC.view setFrame:CGRectMake(320, 20, 320, 460)];
        }
        [self.view addSubview:self.ymSearchVC.view];
        [UIView animateWithDuration:0.25 animations:^{
            [self.ymSearchVC.view setFrame:CGRectMake(0, 20, 320, 460)];
        } completion:^(BOOL finished){}];
    }
    //7每日一槽
    if(theButton.tag == (10000+7)*7){
        
        self.ymTsukkomlVC = nil;
        if(!self.ymTsukkomlVC){
            self.ymTsukkomlVC = [[DMTsukkomlVC alloc] init];
            [self.ymTsukkomlVC.view setFrame:CGRectMake(320, 20, 320, 460)];
        }
           [self.view addSubview:self.ymTsukkomlVC.view];
        [UIView animateWithDuration:0.25 animations:^{
            [self.ymTsukkomlVC.view setFrame:CGRectMake(0, 20, 320, 460)];
            
        } completion:^(BOOL finished){}];
    }
    //8添加
    if(theButton.tag == (10000+8)*7){
        self.ymPublishNews = nil;
        if(!self.ymPublishNews){
            self.ymPublishNews = [[DMPublishNews alloc] initWithNibName:@"DMPublishNews" bundle:Nil];
            [self.ymPublishNews.view setFrame:CGRectMake(320, 20, 320, 460)];
        }
        [self.view addSubview:self.ymPublishNews.view];
        [UIView animateWithDuration:0.25 animations:^{
            [self.ymPublishNews.view setFrame:CGRectMake(0, 20, 320, 460)];
            
        } completion:^(BOOL finished){}];
    }
    //9
    if(theButton.tag == (10000+9)*7){
        
    }
  
}


//设置Button控件
-(void)gmTempSetBut{
    self.ymSetRightVC = nil;
    if(!self.ymSetRightVC){
        self.ymSetRightVC = [[DMSetRight alloc] init];
        [self.ymSetRightVC.view setFrame:CGRectMake(320, 20, 320, 460)];
    }
    [self.view addSubview:self.ymSetRightVC.view];
    self.ymTakeOver = self.ymSetRightVC.view;
    [UIView animateWithDuration:0.25 animations:^{
        [self.ymSetRightVC.view setFrame:CGRectMake(0, 20, 320, 460)];
        
    } completion:^(BOOL finished){}];
}
//版本Button控件
-(void)gmTempEditionBut{
    self.ymEditionVC = nil;
    if(!self.ymEditionVC){
        self.ymEditionVC = [[DMEdition alloc] init];
        [self.ymEditionVC.view setFrame:CGRectMake(320, 20, 320, 460)];
        [self.view addSubview:self.ymEditionVC.view];
    }
 
    [UIView animateWithDuration:0.5 animations:^{
        [self.ymEditionVC.view setFrame:CGRectMake(0, 20, 320, 460)];

    } completion:^(BOOL finished){

    
    }];
    
    UIButton *tempB = [[UIButton alloc] initWithFrame:CGRectMake(320*3+205, 325, 54, 54)];

    [tempB addTarget:self action:@selector(gmEditionGesture) forControlEvents:UIControlEventTouchUpInside];
    [self.ymEditionVC.ymEditionSV addSubview:tempB];

}
//版本Button页面关联方法
-(void)gmEditionGesture{

    [UIView animateWithDuration:0.5 animations:^{
        [self.ymEditionVC.view setFrame:CGRectMake(320, 0, 320, 460)];

    } completion:^(BOOL finished){

    }];

}

//添加MainFrame页面 相关设置
-(void)gmMainFrameSet{
    if(!self.ymMainFrame){
        self.ymMainFrame = [[DMMainFrame alloc] init];
        [self.view addSubview:self.ymMainFrame.view];
        [self.ymMainFrame.view setFrame:CGRectMake(0, 20, 320, 460)];
        
    }
  
    //添加一个TitleView
    self.ymTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];

    [self.ymMainFrame.view addSubview:self.ymTitleView];
    
    //title左边Button
    UIButton *titleLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [titleLeft setBackgroundImage:[UIImage imageNamed:@"leftTitleUpNitht70_70.jpg"] forState:UIControlStateNormal];
    [titleLeft setSelected:YES];
    [titleLeft addTarget:self action:@selector(gmTitleButtonLeft:) forControlEvents:UIControlEventTouchUpInside ];
    [self.ymMainFrame.view addSubview:titleLeft];
    
    //title右边Button
    UIButton *titleRight = [[UIButton alloc] initWithFrame:CGRectMake(320-40, 0, 40, 40)];
    [titleRight setBackgroundImage:[UIImage imageNamed:@"rightTitleUpNight70_70.jpg"] forState:UIControlStateNormal];
    [titleRight setSelected:YES];
    [titleRight addTarget:self action:@selector(gmTitleButtonRight:) forControlEvents:UIControlEventTouchUpInside];
    [self.ymTitleView addSubview:titleRight];
    
    //title中间UIImageview
    if(!self.ymTitleImg){
        self.ymTitleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midTitleNight332_56.jpg"]];
        [self.ymTitleImg setFrame:CGRectMake(40, 0, 240, 40)];
        [self.ymMainFrame.view addSubview:self.ymTitleImg];
    }

    //设置代理
    self.ymMainFrame.delegate = self;
    

}

//title左边Button
-(void)gmTitleButtonLeft:(id)sender{
    UIButton *theButton = (UIButton *)sender;
    if(theButton.isSelected){
         [self gmSwipeLeftBack];
        [theButton setSelected:NO];
    }
    else{
         [self gmSwipeLeft];
        [theButton setSelected:YES];
    }
    
}
//title右边Button
-(void)gmTitleButtonRight:(id)sender{

    UIButton *theButton = (UIButton *)sender;
    if(theButton.isSelected){
        [self gmSwipeRightBack];
        [theButton setSelected:NO];
    }
    else{
         [self gmSwipeRight];
        [theButton setSelected:YES];
    }
    
}


//左边导航栏Button设置
-(void)gmLeftBut:(id)sender{
    UIButton *tempBut = (UIButton *)sender;
    for(int i = 0;i <[self.ymLeftButton count];i ++){
        [[self.ymLeftButton objectAtIndex:i] setBackgroundImage:[UIImage imageNamed:[self.ymMArrLeft objectAtIndex:i*2]] forState:UIControlStateNormal];
    }
    [tempBut setBackgroundImage:[UIImage imageNamed:[self.ymMArrLeft objectAtIndex:(tempBut.tag-100)*2+1]] forState:UIControlStateNormal ];

    [self gmSwipeLeft];
    
    //一级标题设置
    //新闻
    if(tempBut.tag == 100 && self.ymJudgeFirstTitle != 100){
         self.ymJudgeFirstTitle = 100;
        [self.ymTitleImg setImage:[UIImage imageNamed:@"midTitleNight332_56.jpg"]];
        
        [self gmLeftFristTitle];
     
    }
  
    //订阅
    if(tempBut.tag == 101 && self.ymJudgeFirstTitle != 101){
        self.ymJudgeFirstTitle = 101;
        [self.ymTitleImg setImage:[UIImage imageNamed:@"readNight10.jpg"]];
         [self gmLeftFristTitle];
        if(!self.ymTailorRead){
            self.ymTailorRead = [[DMTailorRead alloc] init];
        [self.ymTailorRead.view setFrame:CGRectMake(0, 40, 320, 420)];
        [self.ymMainFrame.view addSubview:self.ymTailorRead.view]; 
        }

    }
    //跟帖
    if(tempBut.tag == 102 && self.ymJudgeFirstTitle != 102){
        self.ymJudgeFirstTitle = 102;
        [self.ymTitleImg setImage:[UIImage imageNamed:@"followNight10.jpg"]];
         [self gmLeftFristTitle];
        if(!self.ymFollowPaste){
            self.ymFollowPaste = [[DMFollowPaste alloc] init];
        [self.ymFollowPaste.view setFrame:CGRectMake(0, 40, 320, 420)];
        [self.ymMainFrame.view addSubview:self.ymFollowPaste.view];

        }
        
               
    }
    //图片
    if(tempBut.tag == 103 && self.ymJudgeFirstTitle != 103){
        self.ymJudgeFirstTitle = 103;
        [self.ymTitleImg setImage:[UIImage imageNamed:@"pictureNight10.jpg"]];
         [self gmLeftFristTitle];
        if(!self.ymPictureTitle){
            self.ymPictureTitle = [[DMPictureTitle alloc] init];
        [self.ymPictureTitle.view setFrame:CGRectMake(0, 40, 320, 420)];
        [self.ymMainFrame.view addSubview:self.ymPictureTitle.view];

        }
}
    //投票
    if(tempBut.tag == 104 && self.ymJudgeFirstTitle != 104){
        self.ymJudgeFirstTitle = 104;
        [self.ymTitleImg setImage:[UIImage imageNamed:@"ballotNight10.jpg"]];
        [self gmLeftFristTitle];
        if(!self.ymBallot){
            self.ymBallot = [[DMBallot alloc] init];
        [self.ymBallot.view setFrame:CGRectMake(0, 40, 320, 420)];
        [self.ymMainFrame.view addSubview:self.ymBallot.view];

        }
      }
    
}

//左边一级标题显示
-(void)gmLeftFristTitle{
    [self.ymBallot.view removeFromSuperview];
    [self.ymFollowPaste.view removeFromSuperview];
    [self.ymPictureTitle.view removeFromSuperview];
    [self.ymTailorRead.view removeFromSuperview];

    self.ymBallot = nil;
    self.ymFollowPaste = nil;
    self.ymPictureTitle = nil;
    self.ymTailorRead = nil;

}

//左边最后一个Button，跳转
-(void)gmLeftEndButton{
    if(!self.ymLeftEnd){
        self.ymLeftEnd = [[UIView alloc] initWithFrame:CGRectMake(0, 20, -320, 460)];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, -320, 460)];
        
        [imgV setImage:[UIImage imageNamed:@"leftEnd2.jpg"]];
        [self.ymLeftEnd addSubview:imgV];
        
        [self.view addSubview:self.ymLeftEnd];
        
        UISwipeGestureRecognizer *swipeGes =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gmSwipeLeftEnd)];
        [swipeGes setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.ymLeftEnd addGestureRecognizer:swipeGes];
    
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.ymLeftEnd setFrame:CGRectMake(0, 20, 320, 460)];
        
    }];

}

//左边最后一个Button，手势响应
-(void)gmSwipeLeftEnd{
    [UIView animateWithDuration:0.5 animations:^{
        [self.ymLeftEnd setFrame:CGRectMake(0, 20, -320, 460)];
    
    }];

}


//左侧视图
-(void)gmLeftRightViewDisplay:(BOOL)display andLeft:(BOOL)dismiss{
  
    if(display){
        [self gmSwipeLeftBack];
    }
    if(dismiss){
        [self gmSwipeLeft];
    }

}
//右侧视图
-(void)gmLeftRightViewDisplay:(BOOL)display andRight:(BOOL)dismiss{
    if(display){
        [self gmSwipeRightBack];

    }
    if(dismiss){
        [self gmSwipeRight];
    
    }
}

//调整左侧一级菜单现、隐
-(void)gmFristTitleDisplay{
    [self gmSwipeLeftBack];

}

#pragma mark UIAlertViewDelegate
//提示框消失后执行该操作
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == 3333){
        //选择确定
        if(buttonIndex == 0){
            //离线下载 保存至沙盒
            
            [DMLeaveLine gmRequestLeaveLinePageSize:100 andCatidNum:12];
            
        }
    }             
    

}


@end
