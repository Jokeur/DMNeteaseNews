//
//  DMPublishNews.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMPublishNews.h"

@interface DMPublishNews ()

@end

@implementation DMPublishNews

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
    //图片上传
    if(!self.ymPictureUploading){
        self.ymPictureUploading = [[ggPicOperation alloc] init];
    }
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];

    //修理标题栏
    UIImageView *tempIVThree = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 0, 278, 42.5)];
    [tempIVThree setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:tempIVThree];
    
    UILabel *tempLabbb = [[UILabel alloc] initWithFrame:CGRectMake(42.5, 0, 278, 42.5)];
    [tempLabbb setText:@" 新闻爆料"];
    [tempLabbb setFont:[UIFont systemFontOfSize:22]];
    [tempLabbb setBackgroundColor:[UIColor redColor]];
    [tempLabbb setTextColor:[UIColor whiteColor]];
    [tempLabbb setAlpha:0.5];
    [self.view addSubview:tempLabbb];
    
    //返回按钮
    UIButton *leftUpBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42.5, 42.5)];
    [leftUpBut addTarget:self action:@selector(gmLeftUpBut) forControlEvents:UIControlEventTouchUpInside];
    [leftUpBut setImage:[UIImage imageNamed:@"displayUpLeft111.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:leftUpBut];
    
    //视图设置
    [self gmSetViewPublish];
    
    //爆料按钮
    [self.ymButton.layer setCornerRadius:5];
    [self.ymButton setBackgroundColor:[UIColor redColor]];
    [self.ymButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ymButton setAlpha:0.6];

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
//设置视图
-(void)gmSetViewPublish{
    //标题，模式，分类，图片，内容
    [self.ymTxtTitle setBackgroundColor:[UIColor grayColor]];
    [self.ymTxtModelid setBackgroundColor:[UIColor grayColor]];
    [self.ymTxtCatid setBackgroundColor:[UIColor grayColor]];
    [self.ymTxtThumb setBackgroundColor:[UIColor grayColor]];
    [self.ymTextVContent setBackgroundColor:[UIColor grayColor]];
    self.ymTxtTitle.alpha = 0.8;
    self.ymTxtModelid.alpha = 0.8;
    self.ymTxtCatid.alpha = 0.8;
    self.ymTxtThumb.alpha = 0.8;
    self.ymTextVContent.alpha = 0.8;
    [self.ymTxtTitle setTextColor:[UIColor whiteColor]];
    [self.ymTxtModelid setTextColor:[UIColor whiteColor]];
    [self.ymTxtCatid setTextColor:[UIColor whiteColor]];
    [self.ymTxtThumb setTextColor:[UIColor whiteColor]];
    [self.ymTextVContent setTextColor:[UIColor whiteColor]];
    [self.ymTextVContent setFont:[UIFont fontWithName:@"Arial" size:14]];
    self.ymTextVContent.delegate = self;
    
    [self.ymTxtTitle setPlaceholder:@"标题名称"];
    [self.ymTxtModelid setPlaceholder:@"模式"];
    [self.ymTxtCatid setPlaceholder:@"分类"];
    [self.ymTxtThumb setPlaceholder:@"选择图片"];
    self.ymTextVContent.text = @"";
    //选择图片
    [self.ymTxtThumb addTarget:self action:@selector(gmChoicePicture:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    [self.ymTxtTitle setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self.ymTxtModelid setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self.ymTxtCatid setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self.ymTxtThumb setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self.ymTextVContent setKeyboardAppearance:UIKeyboardAppearanceDark];

}
//选择图片
-(void)gmChoicePicture:(id)sender{
    //选择图片
    [self pickImageFromAlbum];

}

- (IBAction)ymButPublish:(id)sender {
    //图片准备

        [self gmTsukkomlNewsImgArr:self.ymUploadingPic];

}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0, 20, 320, 460)];
    } completion:^(BOOL finished){
    }];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
//    float hight = [self gmTextHightFromWidth:300 andFontSize:14 andString:self.ymTextVContent.text];
    float hight = [DMJSONWonderfulComment gmTextHightFromWidth:300 andFontSize:14 andString:self.ymTextVContent.text];
    
    if(hight < 150){
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0, -hight, 320, 460)];
    } completion:^(BOOL finished){
    }];
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
#pragma mark UIImagePickerControllerDelegate
//完成图片选择后执行
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
   
    //图片缩放
//    UIImage *lowImage = [self imageWithImageSimple:img scaledToSize:CGSizeMake(120.0, 120.0)];

    
    //随机名字
    NSMutableString *strName = [[NSMutableString alloc] init];
    for(int j = 0 ;j < 10;j ++){
        NSInteger tempInt = arc4random()%10;
        [strName insertString:[NSString stringWithFormat:@"%d",tempInt] atIndex:j ];
        
    }
    //图片保存
    if(!self.ymUploadingPic){
        self.ymUploadingPic = [[NSMutableArray alloc] init];
    }
    [self.ymUploadingPic addObject:[NSString stringWithFormat:@"%@%@",strName,@"salesImage.jpg"]];

    [self saveImage:img WithName:[NSString stringWithFormat:@"%@%@",strName,@"salesImage.jpg"]] ;
    
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
    //UI上显示图片名
    self.ymTxtThumb.text = [NSString stringWithFormat:@"选择了%d张图片",[self.ymUploadingPic count]];
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
- (void)upLoadSalesBigImage{
    self.ymResult = NO;
    for(int i = 0; i < [self.ymUploadingPic count]; i ++){
        NSString *strPathOne = [NSString stringWithFormat:@"%@/%@", [self documentFolderPath],[self.ymUploadingPic  objectAtIndex:i]];
        UIImage *imgTemp = [UIImage imageWithContentsOfFile:strPathOne];
        
        self.ymPictureUploading.theImage = imgTemp;
        
        NSString *str = [self.ymPictureUploading UpLoading:[self.ymUploadingPic objectAtIndex:i]];
        
        if(!str){
            NSLog(@"上传成功");
            self.ymResult = YES;
        }
        
    }
   
 
}
//新闻爆料
-(void)gmTsukkomlNewsImgArr:(NSMutableArray *)imgArr{
    DMPictureNewsModel *tempPictureModel = [[DMPictureNewsModel alloc] init];
    //用户ID
    NSString *strUserId = [DMJSONParse gmPassValue:@""];
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
                                       andDescription:self.ymTxtTitle.text andFrid:[strTopid intValue]
                                             andFrURL:[imgArr objectAtIndex:j]
                                         andPublished:[DMNowTime gmAcquireNowTime]];
        
        [tempImageArr addObject:tempImageInfoModel];
    }
    
    if(![self.ymTxtTitle.text isEqualToString:@""] &&![self.ymTxtModelid.text isEqualToString:@""] &&![self.ymTxtCatid.text isEqualToString:@""]){
        
        //图片上传
       
        [self upLoadSalesBigImage];
    
        
        [tempPictureModel setContentid:@"" andTitle:self.ymTxtTitle.text andModelid:self.ymTxtModelid.text andCatid:self.ymTxtCatid.text andPublished:strTime andSource:strUserId andDescription:self.ymTextVContent.text andContent:self.ymTextVContent.text andThumb:[self.ymUploadingPic objectAtIndex:0] andVideo:@"" andPlaytime:@"0" andTopicid:strTopid andComments:@"0"];
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

@end
