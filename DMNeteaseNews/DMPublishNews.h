//  新闻爆料版块
//  DMPublishNews.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMPictureNews.h"//用于爆料
#import "DMJSONParse.h"//用于获取用户ID
#import "DMNowTime.h"//获得时间
#import "DMPictureNewsModel.h"
#import "DMImageInfoModel.h"
#import "ggHttpFounction.h"
#import "DMJSONWonderfulComment.h"

//图片上传
#import "ggPicOperation.h"

@interface DMPublishNews : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//@property (strong, nonatomic)UIView *ymDownView;
@property (strong, nonatomic) IBOutlet UITextField *ymTxtTitle;
@property (strong, nonatomic) IBOutlet UITextField *ymTxtModelid;
@property (strong, nonatomic) IBOutlet UITextField *ymTxtCatid;
@property (strong, nonatomic) IBOutlet UITextField *ymTxtThumb;
@property (strong, nonatomic) IBOutlet UITextView *ymTextVContent;
@property (strong, nonatomic) IBOutlet UIButton *ymButton;

@property (strong, nonatomic)ggPicOperation *ymPictureUploading;//图片上传

//从相册获取图片
@property (strong, nonatomic)UIImagePickerController *ymImagePickerAlbum;


@property (strong, nonatomic)NSMutableArray *ymUploadingPic;//图片名
@property BOOL ymResult;

- (IBAction)ymButPublish:(id)sender;




@end
