//  用户管理，登录，更换头像，更改用户信息
//  DMUserManager.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-14.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMUserModel.h"
#import "DMJSONParse.h"
#import "DMJSONCreate.h"
#import "ggPicOperation.h"
#import "ggHttpFounction.h"
@interface DMUserManager : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic)DMUserModel *ymUserModelManager;//用户返回信息

@property (strong, nonatomic)UIImageView *ymHeadImg;//用户头像
@property (strong, nonatomic)UILabel *ymStfId;//用户ID
@property (strong, nonatomic)UILabel *ymNickName;//用户昵称
@property (strong, nonatomic)UILabel *ymGender;//用户性别
@property (strong, nonatomic)UILabel *ymMobilePhone;//用户电话
@property (strong, nonatomic)UILabel *ymMail;//电子邮箱

//从相册获取图片
@property (strong, nonatomic)UIImagePickerController *ymImagePickerAlbum;
@property (strong, nonatomic)ggPicOperation *ymPictureUploading;//图片上传
@property (strong, nonatomic)NSMutableArray *ymUploadingPic;
@end
