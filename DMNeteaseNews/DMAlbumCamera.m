//
//  DMAlbumCamera.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-12.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMAlbumCamera.h"

@interface DMAlbumCamera ()

@end

@implementation DMAlbumCamera

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
	// Do any additional setup after loading the view.
    //图片上传
    
    if(!self.ymPictureUploading){
        self.ymPictureUploading = [[ggPicOperation alloc] init];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 从用户相册获取活动图片
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
    
    //图片保存
    [self saveImage:lowImage WithName:@"salesImageLow.jpg"];
    [self saveImage:midImage WithName:@"salesImageMid.jpg"];
    [self saveImage:bigImage WithName:@"salesImageBig.jpg"];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
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
    
    //上传图片
//    NSString *str = [self.ymPictureUploading UpLoading:@"2014311000.jpg"];
    //
    
}


@end
