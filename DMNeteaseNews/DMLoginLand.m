//
//  DMLoginLand.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-23.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMLoginLand.h"

@interface DMLoginLand ()

@end

@implementation DMLoginLand

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
    UIView *tempVOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [tempVOne setBackgroundColor:[UIColor blackColor]];
    [tempVOne setAlpha:0.9];
    
    [self.view addSubview:tempVOne];
    
    UIImageView *tempIVThree = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 0, 276.5, 42.5)];
    [tempIVThree setImage:[UIImage imageNamed:@"enterRightBook11.jpg"]];
    [self.view addSubview:tempIVThree];
    [tempIVThree setAlpha:0.7];
   
    UIButton *leftUpBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42.5, 42.5)];
    [leftUpBut addTarget:self action:@selector(gmLeftUpBut) forControlEvents:UIControlEventTouchUpInside];
     [leftUpBut setImage:[UIImage imageNamed:@"findReturnUp11.jpg"] forState:UIControlStateNormal];
    [leftUpBut setAlpha:0.7];
    [self.view addSubview:leftUpBut];
    //注册功能
    [self gmLoginSet];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//菜单栏，左上方Button
-(void)gmLeftUpBut{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(320,0, 320, 460)];
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
    
    
}
//注册功能
-(void)gmLoginSet{
    //邮箱
    UILabel *labEmail = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 60, 30)];
    [labEmail setText:@"邮 箱:"];
    [labEmail setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:labEmail];
    self.ymTxtEmail = [[UITextField alloc] initWithFrame:CGRectMake(70, 60, 200, 30)];
    [self.ymTxtEmail setBackgroundColor:[UIColor grayColor]];
    [self.ymTxtEmail setPlaceholder:@"输入邮箱"];
    [self.ymTxtEmail setAlpha:0.7];
    [self.ymTxtEmail setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self.ymTxtEmail.layer setCornerRadius:5];
    [self.view addSubview:self.ymTxtEmail];
    
    
    //密码
    UILabel *labCodeOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 60, 30)];
    [labCodeOne setText:@"密 码:"];
    [labCodeOne setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:labCodeOne];
    self.ymTxtCodeOne = [[UITextField alloc] initWithFrame:CGRectMake(70, 100, 200, 30)];
    [self.ymTxtCodeOne setBackgroundColor:[UIColor grayColor]];
    [self.ymTxtCodeOne setPlaceholder:@"输入密码"];
    [self.ymTxtCodeOne setSecureTextEntry:YES];
    [self.ymTxtCodeOne setAlpha:0.7];
    [self.ymTxtCodeOne setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self.ymTxtCodeOne.layer setCornerRadius:5];
    [self.view addSubview:self.ymTxtCodeOne];
    
      //密码重复验证
    UILabel *labCodeTwo = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 51, 30)];
    [labCodeTwo setText:@"密 码:"];
    [labCodeTwo setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:labCodeTwo];
    self.ymTxtCodeTwo = [[UITextField alloc] initWithFrame:CGRectMake(70, 140, 200, 30)];
    [self.ymTxtCodeTwo setBackgroundColor:[UIColor grayColor]];
    [self.ymTxtCodeTwo setPlaceholder:@"确认密码"];
    [self.ymTxtCodeTwo setSecureTextEntry:YES];
    [self.ymTxtCodeTwo setAlpha:0.7];
    [self.ymTxtCodeTwo setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self.ymTxtCodeTwo.layer setCornerRadius:5];
    [self.view addSubview:self.ymTxtCodeTwo];
    
        //注册按钮
    UIButton *tempbutLogin = [[UIButton alloc] initWithFrame:CGRectMake(240, 200, 51, 30)];
    [tempbutLogin setTitle:@"注册" forState:UIControlStateNormal];
    [tempbutLogin.layer setCornerRadius:5];
    [tempbutLogin setAlpha:0.6];
    [tempbutLogin setBackgroundColor:[UIColor redColor]];
    [tempbutLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tempbutLogin addTarget:self action:@selector(gmLoginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tempbutLogin];
}
//注册按钮
-(void)gmLoginButtonAction:(id)sender{
    //用户实例声明
    if(![self.ymTxtEmail.text isEqualToString:@""]&&![self.ymTxtCodeOne.text isEqualToString:@""]&&[self.ymTxtCodeOne.text isEqualToString:self.ymTxtCodeTwo.text]){
   
            if(!self.ymUserModelLogin){
                self.ymUserModelLogin = [[DMUserModel alloc] initMail:self.ymTxtEmail.text andPassword:self.ymTxtCodeOne.text];
            }
            //达到注册条件
            NSString *str = [DMJSONCreate gmJSONWithModel:self.ymUserModelLogin];
            NSString *strPostPath = @"http://192.168.0.43:8080/WebServices/StaffWebService.asmx/AddStaff";
        //NSString类型如何转换为字典
            NSString *strPost = [ggHttpFounction synHttpPost:strPostPath ParamName:@"bodyParam" ParamValue:str];
        NSString *strOne = [strPost substringWithRange:NSMakeRange(12, 5)];
 
            if([strOne intValue] == 10000){
                //提示用户注册成功
                UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"注册" message:@"注册成功" delegate:self cancelButtonTitle:@"返回登陆" otherButtonTitles:Nil, nil];
                [alertV show];
            }else{
                //提示用户注册成功
                UIAlertView *alertVFailed = [[UIAlertView alloc] initWithTitle:@"注册" message:@"邮箱已注册或输入错误" delegate:nil cancelButtonTitle:@"返回修改" otherButtonTitles:Nil, nil];
            
                [alertVFailed show];
            
            }
    }else{
        //提示用户输入格式不对
        UIAlertView *alertVOne = [[UIAlertView alloc] initWithTitle:@"注册" message:@"注册信息格式错误" delegate:nil cancelButtonTitle:@"返回修改" otherButtonTitles:Nil, nil];
        
        [alertVOne show];
    
    }
    
    
}

#pragma mark UIAlertViewDelegate
 //代理，跳转到登陆界面
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    if(buttonIndex == 0){
        [UIView animateWithDuration:0.2 animations:^{
            [self.view setFrame:CGRectMake(320, 0, 320, 460)];
        } completion:^(BOOL finished){
            [self.view removeFromSuperview ];
        }];
        
    }


} 


@end
