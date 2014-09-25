//
//  DMEnterLand.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-23.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMEnterLand.h"

@interface DMEnterLand ()

@end

@implementation DMEnterLand

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(!self.ymEnterIV){
        self.ymEnterIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];

    }
    
    [self.ymEnterIV setImage:[UIImage imageNamed:@"enterLandOne.jpg"]];
    [self.view addSubview:self.ymEnterIV];

    //标题栏
    UIImageView *tempIVThree = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 0, 276.5, 42.5)];
    [tempIVThree setImage:[UIImage imageNamed:@"enterLandTwo333.jpg"]];
    [self.ymEnterIV addSubview:tempIVThree];
 
    UIButton *leftUpBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42.5, 42.5)];
    [leftUpBut addTarget:self action:@selector(gmLeftUpBut) forControlEvents:UIControlEventTouchUpInside];
    [leftUpBut setImage:[UIImage imageNamed:@"displayUpLeft111.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:leftUpBut];
    
    
    //声明两个Textfield,和两个Button 注册，登录
    for(int i = 0;i < 2;i ++){
        //注册，登陆
        
        UITextField *tempTxt = [[UITextField alloc] initWithFrame:CGRectMake(50, 70+i*60, 252, 30)];
        //grayEight.jpg"
        [tempTxt setBackground:[UIImage imageNamed:@"inPutBackground.jpg"]];
        [tempTxt addTarget:self action:@selector(gmEnterLandAction:) forControlEvents:UIControlEventEditingDidBegin];
        //关联事件，编辑完成，让登录Button是否可使用
        [tempTxt addTarget:self action:@selector(gmEnterLandEndAction:) forControlEvents:UIControlEventEditingDidEnd];
        
        //属性设置
        tempTxt.tag = 4000 + i;
        
        //修改Placeholder颜色
        [tempTxt setTextColor:[UIColor grayColor]];
        [tempTxt setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        tempTxt.keyboardAppearance = UIKeyboardAppearanceAlert;
        [self.view addSubview:tempTxt];
        
        //两个Button 注册，登录
        UIButton *theBut = [[UIButton alloc] initWithFrame:CGRectMake(13+i*133, 220, 125+i*35, 40)];
        [theBut addTarget:self action:@selector(gmEnterTheButAction:) forControlEvents:UIControlEventTouchUpInside];
        theBut.tag = 5000 +i;
        [self.view addSubview:theBut];
        
        if(i == 0){
            [tempTxt setText:@"请输入账号"];
            [theBut setImage:[UIImage imageNamed:@"enterLand184_60.jpg"] forState:UIControlStateNormal];
        }
        if(i == 1){
            [tempTxt setText:@"请输入密码"];
            [theBut setImage:[UIImage imageNamed:@"enterLand234_60.jpg"] forState:UIControlStateNormal];
            [theBut setFrame:CGRectMake(13+i*133, 220, 125+i*35, 0)];
        
        }

    }
    
    //safety,Button打钩
    if(!self.ymSafetyBut){
        self.ymSafetyBut = [[UIButton alloc] initWithFrame:CGRectMake(27, 183, 16, 16)];
        self.ymSafetyBut.selected = YES ;
    }
   
    [self.ymSafetyBut addTarget:self action:@selector(gmSafetyBut) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.ymSafetyBut];
    
    //忘记密码
    UIButton *theCode = [[UIButton alloc] initWithFrame:CGRectMake(225, 180, 80, 20)];
    [theCode addTarget:self action:@selector(gmEnterTheCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:theCode];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}
//菜单栏，左上方Button
-(void)gmLeftUpBut{

    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(320, 20, 320, 460)];
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
    
}
//textField关联方法
-(void)gmEnterLandAction:(id)sender{
    UITextField *theTxt = (UITextField *)sender;
    if(theTxt.tag == 4000){
        [theTxt setText:@""];
        [self.ymEnterIV setImage:[UIImage imageNamed:@"enterLandOne.jpg"]];

    }
    if(theTxt.tag == 4001){
        [theTxt setText:@""];
        [theTxt setSecureTextEntry:YES];
        [self.ymEnterIV setImage:[UIImage imageNamed:@"enterLandTwo.jpg"]];
        
    }

}
//safety,Button连接方法
-(void)gmSafetyBut{
    if([self.ymSafetyBut isSelected]){
        [self.ymSafetyBut setBackgroundImage:[UIImage imageNamed:@"safetyEnterOne.jpg"] forState:UIControlStateNormal];
        self.ymSafetyBut.selected = NO;
    }else{
      [self.ymSafetyBut setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        self.ymSafetyBut.selected = YES;
      
    }

}
//两个Button 注册，登录
-(void)gmEnterTheButAction:(id)sender{
    UIButton *theBut = (UIButton *)sender;
    if(theBut.tag == 5000){
       //注册
        self.ymLoginLand = nil;
        if(!self.ymLoginLand){
            self.ymLoginLand = [[DMLoginLand alloc] init];
            [self.ymLoginLand.view setFrame:CGRectMake(320,0, 320, 460)];
            [self.view addSubview:self.ymLoginLand.view];
        }
        [UIView animateWithDuration:0.25 animations:^{
            [self.ymLoginLand.view setFrame:CGRectMake(0, 0, 320, 460) ];
        } completion:^(BOOL finished){}];
        
    }
    if(theBut.tag == 5001){
        [self.view endEditing:YES];
        //登录
         UITextField *txtName = (UITextField *)[self.view viewWithTag:4000];
         UITextField *txtCode = (UITextField *)[self.view viewWithTag:4001];
        NSLog(@"%@,%@",txtName.text,txtCode.text);
        
        if(![txtName.text isEqualToString:@""] && ![txtCode.text isEqualToString:@""]){
            
            NSString *strPath = [NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/StaffWebService.asmx/LoginWithEmail?mail=%@&Password=%@",txtName.text,txtCode.text];
            NSURL *tempUrl = [NSURL URLWithString:strPath];
            
            // 网络请求
             DMUserModel *landingPostModel = (DMUserModel *)[DMJSONParse gmUserLanding:tempUrl];
            
            if([landingPostModel.ymStfId intValue] !=0 ){
                //头像
                NSString *startPath = @"http://192.168.0.43:8080/UpLoad/";
                NSString *strPath = [NSString stringWithFormat:@"%@%@",startPath,landingPostModel.ymPhoto];
                NSURL *url = [NSURL URLWithString:strPath];
                UIImage *imgtemp = [DMJSONParse gmRequestImageNews:url];
                
                //登陆成功
                [UIView animateWithDuration:0.2 animations:^{
                    [self.view setFrame:CGRectMake(320, 20, 320, 460)];
                    
                } completion:^(BOOL finished){
                    //通知立即登陆那里改变状态StfId
                      NSNotification *nfOne = [[NSNotification alloc] initWithName:@"gmLandingLabel" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[landingPostModel.ymStfId intValue]],@"StfId",landingPostModel,@"user",imgtemp,@"headImg",nil]];
                    [[NSNotificationCenter defaultCenter] postNotification:nfOne];
                    
                }];
            }else{
                UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"登陆" message:@"用户名或者密码错误" delegate:self cancelButtonTitle:@"返回修改" otherButtonTitles:nil, nil];
            
                [alertV show];
            }
        }
    }
}
//关联事件，编辑完成，让登录Button是否可使用
-(void)gmEnterLandEndAction:(id)sender{
  
    UITextField *rfOne = (UITextField *)[self.view viewWithTag:4000];
    UITextField *rfTwo = (UITextField *)[self.view viewWithTag:4001];
    UIButton *butOne = (UIButton *)[self.view viewWithTag:5001];
    if(![rfOne.text isEqualToString:@""] && ![rfTwo.text isEqualToString:@""]){
        [butOne setFrame:CGRectMake(13+133, 220, 125+35, 40)];
        
    }

}
//忘记密码ymLoginLand
-(void)gmEnterTheCodeAction:(id)sender{
    self.ymFindcoed = nil;
    if(!self.ymFindcoed){
        self.ymFindcoed = [[DMFindCoed alloc] init];
        [self.ymFindcoed.view setFrame:CGRectMake(320,0, 320, 460)];
        [self.view addSubview:self.ymFindcoed.view];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.ymFindcoed.view setFrame:CGRectMake(0, 0, 320, 460) ];
    } completion:^(BOOL finished){
        
    }];

}
@end
