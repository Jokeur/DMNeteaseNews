
//  DMTsukkomlVC.m
//  DMNeteaseNews
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMTsukkomlVC.h"

@interface DMTsukkomlVC()

@end

@implementation DMTsukkomlVC


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
    
    //退出点击Button时弹出View
    [self gmDismissView];
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //图片上传
    
    if(!self.ymPictureUploading){
        self.ymPictureUploading = [[ggPicOperation alloc] init];
    }
    
    
    if(!self.ymArrTsukkoml){
        self.ymArrTsukkoml = [[NSArray alloc] initWithObjects:@"tsukkoml1.jpg", @"tsukkoml2.jpg", @"tsukkoml3.jpg", @"tsukkoml4.jpg",@"tsukkoml5.jpg",@"tsukkoml6.jpg", nil];
    }

    
    //实例化一个UIImageView
      self.ymTempIV = nil;
    if(!self.ymTempIV){
        self.ymTempIV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0 , 320, 460)];
        [self.ymTempIV setImage:[UIImage imageNamed:@"tsukkoml1.jpg"]];
       [self.view addSubview:self.ymTempIV];
        
        
    }
  
    //手势，避开遮挡
    UISwipeGestureRecognizer *sgrTemp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gmSGRAction)];
    [sgrTemp setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:sgrTemp];
    //延时方法处理//动画实现
     for(int i = 0 ;i < [self.ymArrTsukkoml count];i ++){
   
         [self performSelector:@selector(gmPromptNureadOne) withObject:self afterDelay:0.15*i+0.15];
     }
    
    //输入框初始化，和设置，
   
    if(!self.ymInputName){
        self.ymInputName = [[UITextField alloc] initWithFrame:CGRectMake(30, 318, 260, 44)];
        [self.ymInputName setBackgroundColor:[UIColor whiteColor]];
        [self.ymInputName setPlaceholder:@"填写你的名字"];
        //修改颜色
        [self.ymInputName setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        //键盘风格设置
        self.ymInputName.keyboardAppearance = UIKeyboardAppearanceAlert;
        //光标颜色设置
        [self.ymInputName setTintColor:[UIColor grayColor]];
   
        
        [self.view addSubview:self.ymInputName];
    }

    //输入框关联事件
    //编辑开始事件
    [self.ymInputName addTarget:self action:@selector(gmInputNameAction) forControlEvents:UIControlEventEditingDidBegin];
    //编辑结束事件
     [self.ymInputName addTarget:self action:@selector(gmEndInputNameAction) forControlEvents: UIControlEventEditingDidEnd ];
   
    //来一发 ，Button声明和设置
    if(!self.ymInputButton){
        self.ymInputButton =[[UIButton alloc] initWithFrame:CGRectMake(30, 368, 260, 44)];
    }
    [self.ymInputButton addTarget:self action:@selector(gmInputButtonAction) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:self.ymInputButton];
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//动画实现方法
-(void)gmPromptNureadOne{

    [self.ymTempIV setImage:[UIImage imageNamed:[self.ymArrTsukkoml objectAtIndex:self.ymNum]]];
    self.ymNum ++;

}
//事件关联方法
-(void)gmSGRAction{

    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(320, 20, 320, 460)];
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
   
}
//输入框关联事件
-(void)gmInputNameAction{
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0, -100, 320, 460)];
    } completion:^(BOOL finished){
        
    }];
}

//编辑结束事件
-(void)gmEndInputNameAction
{
    [UIView animateWithDuration:0.1 animations:^{
        [self.view setFrame:CGRectMake(0, 20, 320, 460)];
    } completion:^(BOOL finished){
       
    }];
}

//来一发 ，Button连接事件
-(void)gmInputButtonAction{
    
if([self.ymInputName.text length] != 0){
    
    
    if(!self.ymInputView){
        self.ymInputView = [[UIView alloc] initWithFrame:CGRectMake(0, 460, 320, 150)] ;
    }
    [self.ymInputView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.ymInputView];
    
    //设置ymInputView透明
    [self.ymInputView setAlpha:0.8];
    
    
        //在Button点击后弹出View上加入3个Button
    NSArray *tempArr = [[NSArray alloc] initWithObjects:@"照相",@"图片库",@"取消", nil];
    for(int i = 0 ;i < 3 ; i++){
        
//        UIButton *tempBut = [[UIButton alloc] initWithFrame:CGRectMake(20, 6+i*48, 280, 42)];
        //设置圆角
        UIButton *tempBut = [UIButton buttonWithType:UIButtonTypeCustom];
        
        tempBut.frame = CGRectMake(20, 6+i*48, 280, 42);
//        [tempBut.layer setMasksToBounds:YES];
        //设置半径
        [tempBut.layer setCornerRadius:10];
        
        //边框宽度
        [tempBut.layer setBorderWidth:1.0];
        
        //边框颜色
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){1,1,1,1});
        
        [tempBut.layer setBorderColor:colorref];

        //属性设置
        tempBut.tag = 2000+i;
        [tempBut setBackgroundColor:[UIColor blackColor]];
        [tempBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tempBut setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal] ;
        
        //点击手势
        UITapGestureRecognizer *tgrTemp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gmTRGAction:)];
        
               
        tgrTemp.delegate = self;

        [tempBut addGestureRecognizer:tgrTemp];
        
        //Button关联事件
        [tempBut addTarget:self action:@selector(gmInputSendAction:) forControlEvents:UIControlEventTouchDown ];
        
        [self.ymInputView addSubview:tempBut];
        
    }

 

    [UIView animateWithDuration:0.2 animations:^{
       [ self.ymInputView setFrame:CGRectMake(0, 310, 320, 150)] ;
    } completion:^(BOOL finished){
    
    }];
    
}
    
}
//取消点击Button时弹出View
-(void)gmDismissView{
    [UIView animateWithDuration:0.5 animations:^{
        [ self.ymInputView setFrame:CGRectMake(0, 460, 320, 150)] ;
    } completion:^(BOOL finished){
    
    }];

}
//点击手势
-(void)gmTRGAction:(id)sender{
    //    NSLog(@"dddd");
    UITapGestureRecognizer *tempGesture = (UITapGestureRecognizer *)sender;
    UIButton *tempButton = (UIButton *)tempGesture.view ;
    [tempButton setBackgroundColor:[UIColor blackColor]];
    //  NSLog(@"点击Button松手后，就立即执行改方法");
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //    NSLog(@"点击Button松手后，先执行代理中这个方法，在点击手势响应连接方法之前执行");
    
    return YES;
}
//新闻爆料
-(void)gmTsukkomlNewsImgArr:(NSMutableArray *)imgArr{
    DMPictureNewsModel *tempPictureModel = [[DMPictureNewsModel alloc] init];
    //用户ID
//    NSString *strUserId = [DMJSONParse gmPassValue:@""];
    //时间
    NSString *strTime = [DMNowTime gmAcquireNowTime];
    //话题ID,6个随机数
    NSMutableString *strTopid = [[NSMutableString alloc] init];
    for(int i = 0; i < 6; i ++){
        NSInteger random = arc4random()%10;
        [strTopid appendFormat:@"%d",random ];
    }
    NSMutableArray *tempImageArr = [[NSMutableArray alloc] init];
    
    for(int j = 0;j < [imgArr count]; j++){
        DMImageInfoModel *tempImageInfoModel = [[DMImageInfoModel alloc] init];
        [tempImageInfoModel gmImageInfoModelContentid:0
                                       andDescription:self.ymInputName.text andFrid:[strTopid intValue]
                                        andFrURL:[imgArr objectAtIndex:j]
                                         andPublished:[DMNowTime gmAcquireNowTime]];
        
        [tempImageArr addObject:tempImageInfoModel];//[NSString stringWithFormat:@"201437112_%d.jpg",j+1]];
   
    }
    
    //判断不为空
    if(![self.ymInputName.text isEqualToString:@""]){
        
        [tempPictureModel setContentid:@"" andTitle:@"每日一槽" andModelid:@"2" andCatid:@"11" andPublished:strTime andSource:self.ymInputName.text andDescription:@"小编让你上头条" andContent:@"新闻爆料" andThumb:[imgArr objectAtIndex:0] andVideo:@"" andPlaytime:@"0" andTopicid:strTopid andComments:@"0"];
        [tempPictureModel setYmImageList:tempImageArr];
        
        //转换为JSON数据
        
        NSString *strResultJSON = [DMJSONCreate gmJSONPictureNewsWithModel:tempPictureModel];
        
        NSString *strPath = @"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/AddImageNews";
        //网络请求后返回的数据
        NSString *netReturnStr = [ggHttpFounction synHttpPost:strPath ParamName:@"bodyParam" ParamValue:strResultJSON];;
        //爆料成功
        if(![netReturnStr isEqualToString:@""]&&[[netReturnStr substringWithRange:NSMakeRange(12, 5)] intValue] == 10000){
            UIAlertView *alertTsukkomlSuccess = [[UIAlertView alloc] initWithTitle:@"爆料" message:@"成功爆料" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:Nil, nil];
            [alertTsukkomlSuccess show];
            
        }else{
            //爆料失败
            UIAlertView *alertTsukkomlFailed = [[UIAlertView alloc] initWithTitle:@"爆料" message:@"爆料失败" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:Nil, nil];
            [alertTsukkomlFailed show];
        }
        
    }else{
        //爆料失败
        UIAlertView *alertTsukkomlFailed = [[UIAlertView alloc] initWithTitle:@"爆料" message:@"请按照提示填写信息" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:Nil, nil];
        [alertTsukkomlFailed show];
    }
    
    
}

//在Button点击后弹出View上加入3个Button,关联方法
-(void)gmInputSendAction:(id)sender{
    UIButton *tempButton = (UIButton *)sender;
    
        [tempButton setBackgroundColor:[UIColor grayColor]];
    
        if(tempButton.tag == 2000){
            NSLog(@"获取照相机操作");
            [self gmDismissView];
            //相机获取图片
            
            [self pickImageFromCamera];
        }
        if(tempButton.tag == 2001){
            NSLog(@"获取图片库操作");
            [self gmDismissView];
            
            //相册获取图片
            [self pickImageFromAlbum];
            
        }//取消
        if(tempButton.tag == 2002){
            [self gmDismissView];
            
        }
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
//    [self presentModalViewController:self.ymImagePicker animated:YES];
}
#pragma mark 从摄像头获取活动图片

- (void)pickImageFromCamera{
    self.ymImagePickerCamera = nil;
    self.ymImagePickerCamera = [[UIImagePickerController alloc] init];
    self.ymImagePickerCamera.delegate = self;
    self.ymImagePickerCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.ymImagePickerCamera.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.ymImagePickerCamera.allowsEditing = YES;
    [self presentViewController:self.ymImagePickerCamera animated:YES completion:^{
    }];
   
}
#pragma mark UIImagePickerControllerDelegate
//完成图片选择后执行
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //若是从相机取图片
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
//        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);

    }
    //图片缩放
    UIImage *lowImage = [self imageWithImageSimple:img scaledToSize:CGSizeMake(120.0, 120.0)];
    UIImage *midImage = [self imageWithImageSimple:img scaledToSize:CGSizeMake(210.0, 210.0)];
    UIImage *bigImage = [self imageWithImageSimple:img scaledToSize:CGSizeMake(440.0, 440.0)];
    
    //随机名字
    NSMutableString *strName = [[NSMutableString alloc] init];
    for(int j = 0 ;j < 10;j ++){
        NSInteger tempInt = arc4random()%10;
        [strName insertString:[NSString stringWithFormat:@"%d",tempInt] atIndex:j ];// stringByAppendingString:[NSString stringWithFormat:@"%d",tempInt]];
        
    }
    //图片保存
    self.ymUploadingPic = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@",strName,@"salesImageMid.jpg"],[NSString stringWithFormat:@"%@%@",strName,@"salesImageMid.jpg"],[NSString stringWithFormat:@"%@%@",strName,@"salesImageBig.jpg"], nil];
    
    [self saveImage:lowImage WithName:[self.ymUploadingPic objectAtIndex:0]] ;  //@"salesImageLow.jpg"];
    [self saveImage:midImage WithName:[self.ymUploadingPic objectAtIndex:1]];
    [self saveImage:bigImage WithName:[self.ymUploadingPic objectAtIndex:2]];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
    
    //图片上传
    [self upLoadSalesBigImage:@"salesImageLow.jpg" MidImage:@"salesImageMid.jpg" SmallImage:@"salesImageBig.jpg"];

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
    //偏移归位
    [self gmEndInputNameAction];
    
}
/*存储图像
　　在上面我们获取到了图片并对图片进行了压缩，通过之前的小知识了解到，将应用需要的一些图片存入沙盒是个不错的选择，而且应用程序可以直接通过路径去方法沙盒中的图片，在这里我们将图片存入沙盒中的Documents目录下。
*/

#pragma mark 保存图片到document
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
    
  NSData* imageData = UIImagePNGRepresentation(tempImage);
    
  NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
   NSString* documentsDirectory = [paths objectAtIndex:0];
    
 // Now we get the full path to the file
  NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
  // and then we write it out
    
   [imageData writeToFile:fullPathToFile atomically:NO];
    
}
/*从Documents目录下获取图片
　　要从Documents下面获取图片，我们首先需要获取Documents目录的路径。
*/
#pragma mark 从文档目录下获取Documents路径

- (NSString *)documentFolderPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
}

/*上传图片
　项目中我们使用了ASIFormHttpRequest的开源框架，http请求的部分代码如下，http返回以及相关回调方法略去。

*/
- (void)upLoadSalesBigImage:(NSString *)bigImage MidImage:(NSString *)midImage SmallImage:(NSString *)smallImage{
//    NSString *strPath = [NSHomeDirectory() stringByAppendingString:@"/picture"];
//  NSURL *url = [NSURL URLWithString:strPath];
//  ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    
//  [request setPostValue:@"photo" forKey:@"type"];
//    
//   [request setFile:bigImage forKey:@"file_pic_big"];
//    
//   [request buildPostBody];
//    
//   [request setDelegate:self];
//    
//   [request setTimeOutSeconds:TIME_OUT_SECONDS];
//    
//   [request startAsynchronous];
    
    BOOL result = NO;
    for(int i = 0; i < [self.ymUploadingPic count]; i ++){
        NSString *strPathOne = [NSString stringWithFormat:@"%@/%@", [self documentFolderPath],[self.ymUploadingPic  objectAtIndex:i]];
        UIImage *imgTemp = [UIImage imageWithContentsOfFile:strPathOne];
        
        self.ymPictureUploading.theImage = imgTemp;
       
         NSString *str = [self.ymPictureUploading UpLoading:[self.ymUploadingPic objectAtIndex:i]];
        
        if(!str){
            NSLog(@"上传成功");
            result = YES;
        }
        
    }
    //图片上传成功后发表新闻
    if(result){
        [self gmTsukkomlNewsImgArr:self.ymUploadingPic];
    }

    //偏移归位
    [self gmEndInputNameAction];
}






@end
