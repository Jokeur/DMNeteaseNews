//  从相机，相册获取图片
//  DMAlbumCamera.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-12.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ggPicOperation.h"
@interface DMAlbumCamera : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//从相册获取图片
@property (strong, nonatomic)UIImagePickerController *ymImagePickerAlbum;
//从相机获取图片
@property (strong, nonatomic)UIImagePickerController *ymImagePickerCamera;

@property (strong, nonatomic)ggPicOperation *ymPictureUploading;//图片上传
@end
