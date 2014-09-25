//
//  DMUserManager.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-14.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMUserManager.h"

@interface DMUserManager ()

@end

@implementation DMUserManager

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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
    
    //标题栏
    UIImageView *tempIVThree = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 280, 40)];
    [tempIVThree setImage:[UIImage imageNamed:@"myNumber1.jpg"]];
    [self.view addSubview:tempIVThree];
    
    UIButton *leftUpBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftUpBut addTarget:self action:@selector(gmLeftUpBut) forControlEvents:UIControlEventTouchUpInside];
    [leftUpBut setImage:[UIImage imageNamed:@"displayUpLeft111.jpg"] forState:UIControlStateNormal];
    
    [self.view addSubview:leftUpBut];

    //我的账号页面设置
    [self gmMyCenterSet];
    
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
        
    }];
}
//我的账号页面设置
-(void)gmMyCenterSet{
    if(!self.ymHeadImg){
        self.ymHeadImg = [[UIImageView  alloc] initWithFrame:CGRectMake(160-54, 45, 108, 108)];
        [self.ymHeadImg setImage:[UIImage imageNamed:@"head108_108.jpg"]];
        self.ymHeadImg.layer.masksToBounds = YES;
        [self.ymHeadImg.layer setCornerRadius:54];
        [self.view addSubview:self.ymHeadImg];

    }
    //头像
    NSString *startPath = @"http://192.168.0.43:8080/UpLoad/";
    NSString *strPath = [NSString stringWithFormat:@"%@%@",startPath,self.ymUserModelManager.ymPhoto];
    NSURL *url = [NSURL URLWithString:strPath];
    UIImage *imgtempdd = [DMJSONParse gmRequestImageNews:url];
    [self.ymHeadImg setImage:imgtempdd];
    
    
    //更换头像
    UIButton *butChange = [UIButton buttonWithType:UIButtonTypeSystem];
    [butChange setFrame:CGRectMake(60-35, 160, 70, 20)];
    [butChange setTitle:@"更换头像" forState:UIControlStateNormal];
    [butChange.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [butChange setBackgroundColor:[UIColor brownColor]];
    [butChange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butChange.layer setCornerRadius:5];
    [butChange setAlpha:0.6];
    [butChange addTarget:self action:@selector(gmChangeHearPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butChange];
    
    //确定更换头像
    UIButton *butChangeYES = [UIButton buttonWithType:UIButtonTypeSystem];
    [butChangeYES setFrame:CGRectMake(260-35, 160, 70, 20)];
    [butChangeYES setTitle:@"确定更换" forState:UIControlStateNormal];
    [butChangeYES.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [butChangeYES setBackgroundColor:[UIColor brownColor]];
    [butChangeYES setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butChangeYES.layer setCornerRadius:5];
    [butChangeYES setAlpha:0.6];
    [butChangeYES addTarget:self action:@selector(gmChangeYESHearPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butChangeYES];
    
    //退出登录
    UIButton *butDismissLogin = [UIButton buttonWithType:UIButtonTypeSystem];
    [butDismissLogin setFrame:CGRectMake(160-35, 420, 70, 20)];
    [butDismissLogin setTitle:@"退出登录" forState:UIControlStateNormal];
    [butDismissLogin.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [butDismissLogin setBackgroundColor:[UIColor redColor]];
    [butDismissLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butDismissLogin.layer setCornerRadius:5];
    [butDismissLogin setAlpha:0.6];
    [butDismissLogin addTarget:self action:@selector(gmbutDismissLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butDismissLogin];

    //用户信息
    [self gmUserInfoSet];
}
//用户信息
-(void)gmUserInfoSet{
//用户ID
    self.ymStfId = [[UILabel alloc] init];
    self.ymNickName = [[UILabel alloc] init];
    self.ymGender = [[UILabel alloc] init];
    self.ymMobilePhone = [[UILabel alloc] init];
    self.ymMail = [[UILabel alloc] init];
    NSMutableArray *infoArr = [[NSMutableArray alloc] initWithObjects:self.ymStfId,self.ymNickName,self.ymGender,self.ymMobilePhone,self.ymMail, nil];
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithObjects:@"I D:",@"昵称:",@"性别:",@"电话:",@"邮箱:", nil];
    
    NSString *strGender;
    if([self.ymUserModelManager.ymGender intValue] == 0){
        strGender = @"女";
    }
    if([self.ymUserModelManager.ymGender intValue] == 1){
        strGender = @"男";
    }

    NSMutableArray *tempUserInfo = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",[self.ymUserModelManager.ymStfId intValue] ],self.ymUserModelManager.ymNickName,strGender,self.ymUserModelManager.ymMobilePhone,self.ymUserModelManager.ymMail, nil];
    
    for(int i = 0;i < [tempArr count]; i ++){
        UILabel *tempLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 200+i*30, 40, 20 )];
        [tempLab setText:[tempArr objectAtIndex:i]];
        [tempLab setBackgroundColor:[UIColor clearColor]];
        [tempLab setFont:[UIFont systemFontOfSize:16]];
        [tempLab setTextColor:[UIColor grayColor]];
        [self.view addSubview:tempLab];
        
        //info
        UILabel *tempInfo = [infoArr objectAtIndex:i];
        [tempInfo setFrame:CGRectMake(55, 200+i*30, 245, 20 )];
        [tempInfo setTextAlignment:NSTextAlignmentLeft];
        [tempInfo setBackgroundColor:[UIColor clearColor]];
        [tempInfo setFont:[UIFont systemFontOfSize:16]];
        [tempInfo setTextColor:[UIColor grayColor]];
        [tempInfo setText:[tempUserInfo objectAtIndex:i]];
        
        [self.view addSubview:tempInfo];
    
    }

}
//更换头像
-(void)gmChangeHearPhoto:(id)sender{
    //从相册中选择
    [self pickImageFromAlbum];
    

}
//确定更换头像
-(void)gmChangeYESHearPhoto:(id)sender{
    //上传服务器
    if([self upLoadSalesImage]){
        //往服务器发送指令修改用户信息
        self.ymUserModelManager.ymPhoto = [self.ymUploadingPic lastObject];
        NSString *strPath = @"http://192.168.0.43:8080/WebServices/StaffWebService.asmx/ModifyStaff";
        
        //转化JSON数据
        NSString *strJSON = [DMJSONCreate gmJSONWithModel:self.ymUserModelManager];
        //往服务器Post指令
        NSString *strReturnPost = [ggHttpFounction synHttpPost:strPath ParamName:@"bodyParam" ParamValue:strJSON];
        NSString *judgeStr = [strReturnPost substringWithRange:NSMakeRange(12, 5)];
        
        if([judgeStr intValue] == 10000){
        //修改成功
            //通知用户中心更改头像
            UIImage *imgTemp = [self gmAcquireImage];
            NSNotification *managerNFOne = [[NSNotification alloc] initWithName:@"gmHeadPhotoChange" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys:imgTemp,@"headPhoto", nil]];
            [[NSNotificationCenter defaultCenter] postNotification:managerNFOne];
            
            UIAlertView *alertOne = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更改头像成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertOne show];
            
        }else if([judgeStr intValue] == 10001){
        //修改失败
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更改头像失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
//退出登录
-(void)gmbutDismissLogin:(id)sender{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(320, 20, 320, 460)];
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
  
    //清空登录数据记录
    [DMJSONParse gmDismissPassValue];
    
    //响应通知
    NSNotification *managerNF = [[NSNotification alloc] initWithName:@"gmLandingLabel" object:nil userInfo:[[NSDictionary alloc] initWithObjectsAndKeys:@"",@"StfId",nil]];
    [[NSNotificationCenter defaultCenter] postNotification:managerNF];
}



//#pragma mark 从用户相册获取活动图片
/*　　我们来看看上面的从相册获取图片，我们首先要实例化UIImagePickerController对象，然后设置imagePicker对象为当前对象，设置imagePicker的图片来源为UIImagePickerControllerSourceTypePhotoLibrary，表明当前图片的来源为相册，除此之外还可以设置用户对图片是否可编辑。
 */
- (void)pickImageFromAlbum{
    self.ymImagePickerAlbum = nil;
    self.ymImagePickerAlbum = [[UIImagePickerController alloc] init];
    self.ymImagePickerAlbum.delegate =self;
    self.ymImagePickerAlbum.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.ymImagePickerAlbum.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.ymImagePickerAlbum.allowsEditing =YES;
    [self presentViewController:self.ymImagePickerAlbum animated:YES completion:^{
    }];
   
}
#pragma mark UIImagePickerControllerDelegate
//完成图片选择后执行
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
   
    //随机名字
    NSMutableString *strName = [[NSMutableString alloc] init];
    for(int j = 0 ;j < 10;j ++){
        NSInteger tempInt = arc4random()%10;
        [strName insertString:[NSString stringWithFormat:@"%d",tempInt] atIndex:j ];
        
    }
    NSString *picName = [NSString stringWithFormat:@"%@%@",strName,@".jpg"];
    //图片保存
    if(!self.ymUploadingPic){
        self.ymUploadingPic = [[NSMutableArray alloc] init];
    }
    [self.ymUploadingPic addObject:picName];
    
    [self saveImage:img WithName:[self.ymUploadingPic lastObject]] ;
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
    //获取图片,预览
    UIImage *imgTemp = [self gmAcquireImage];
    
    [self.ymHeadImg setImage:imgTemp];
   

}
//压缩图片
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    // 创建绘图上下文
    UIGraphicsBeginImageContext(newSize);
    // 新尺寸
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

//点击取消后执行
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
}
/*存储图像
 　　在上面我们获取到了图片并对图片进行了压缩，通过之前的小知识了解到，将应用需要的一些图片存入沙盒是个不错的选择，而且应用程序可以直接通过路径去方法沙盒中的图片，在这里我们将图片存入沙盒中的Documents目录下。
 */

#pragma mark 保存图片到document
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
    
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
    
}
/*从Documents目录下获取图片
 　　要从Documents下面获取图片，我们首先需要获取Documents目录的路径。
 */
#pragma mark 从文档目录下获取Documents路径

- (NSString *)documentFolderPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
}
//获取图片
-(UIImage *)gmAcquireImage{
    NSString *strPathOne = [NSString stringWithFormat:@"%@/%@", [self documentFolderPath],[self.ymUploadingPic  lastObject]];
    UIImage *imgTemp = [UIImage imageWithContentsOfFile:strPathOne];
    return imgTemp;
}


/*上传图片
 　项目中我们使用了ASIFormHttpRequest的开源框架，http请求的部分代码如下，http返回以及相关回调方法略去。
 
 */
- (BOOL)upLoadSalesImage{

    BOOL result = NO;
    //获取图片
    UIImage *imgTemp = [self gmAcquireImage];
    
        self.ymPictureUploading.theImage = imgTemp;
        
        NSString *str = [self.ymPictureUploading UpLoading:[self.ymUploadingPic lastObject]];
        
        if(!str){
            NSLog(@"上传成功");
            result = YES;
        }
    
    //图片上传成功后修改用户信息
    if(result){

    }
    return result;
}




@end
