//  吐槽版块
//  DMTsukkomlVC.h
//  DMNeteaseNews
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ggPicOperation.h"
#import "DMPictureNewsModel.h"
#import "DMJSONParse.h"
#import "DMNowTime.h"
#import "DMJSONCreate.h"
#import "ggHttpFounction.h"
//#import "DMAlbumCamera.h"
@interface DMTsukkomlVC : UIViewController<UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic)NSArray *ymArrTsukkoml;
@property (strong, nonatomic)UIImageView *ymTempIV;
@property (strong, nonatomic)UITextField *ymInputName;
@property (nonatomic) NSInteger ymNum;
//Button，关联
@property (strong, nonatomic)UIButton *ymInputButton;
@property (strong, nonatomic)UIView *ymInputView;

//从相册获取图片
@property (strong, nonatomic)UIImagePickerController *ymImagePickerAlbum;
//从相机获取图片
@property (strong, nonatomic)UIImagePickerController *ymImagePickerCamera;

@property (strong, nonatomic)ggPicOperation *ymPictureUploading;//图片上传
@property (strong, nonatomic)NSMutableArray *ymUploadingPic;

//图片上传
//@property (strong, nonatomic)DMAlbumCamera *ymAlbumCamera;

@end
