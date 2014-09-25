//  点击Cell后，跳转至 视频显示
//  DMVideoNews.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-28.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMComments.h"//跟帖界面
#import "DMNewsDataModel.h"
#import "DMJSONParse.h"
#import "DMCollectionSave.h"
//#import <FFmpegDecoder/FrameExtractor.h>//引入此解析类


@interface DMVideoNews : UIViewController<UIWebViewDelegate>{//,CGImageBufferDelegate>{
    NSTimer* timer;//计时器控制播放
	float lastFrameTime;//最后一帧
}
@property(nonatomic,strong)UIImageView *imageView;
//@property (nonatomic, retain) FrameExtractor *video;

@property float ymVideoZeroHight;//视频原点高度位置
@property (strong, nonatomic)UIView *ymVideoTitleUpV;
@property (strong, nonatomic)UIImageView *ymDownImgComments;//下方，写跟帖
@property (strong, nonatomic)UIView *ymDownV;
@property (strong, nonatomic)UITextField *ymTxtDownUpBut;
@property (strong, nonatomic)UIScrollView *ymScrollV;//scrollView
@property (strong, nonatomic)UIWebView *ymWebV;//web View
@property (strong, nonatomic)UIScrollView *ymSubViewUp;//弹出子View
@property (strong, nonatomic)DMComments *ymCommentsVideo;
@property (strong, nonatomic)DMNewsDataModel *ymVideoModel;
@property (strong, nonatomic)DMJSONParse *ymVideoPictureParse;//图片解析
@property (strong, nonatomic)UIActivityIndicatorView *activityIndicatorV;
@property (strong, nonatomic)UIWebView *webV;

-(void)displayNextFrame:(NSTimer *)timer;
@end
