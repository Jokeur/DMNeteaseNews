//  文本新闻，新闻显示
//  DMBasicNews.h
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-28.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMComments.h"
#import "DMNewsDataModel.h"
#import "DMJSONParse.h"
#import "ggHttpFounction.h"
#import "DMAppearObserve.h"//发表评论
#import "DMCollectionSave.h"//收藏
@interface DMBasicNews : UIViewController
@property (strong, nonatomic)UIView *ymBasicTitleUpV;
//下方，写跟帖
@property (strong, nonatomic)UIImageView *ymDownImgComments;
@property (strong, nonatomic)UIView *ymDownV;
@property (strong, nonatomic)UITextField *ymTxtDownUpBut;
//scrollView
@property (strong, nonatomic)UIScrollView *ymScrollV;
//web View
@property (strong, nonatomic)UIWebView *ymWebV;
//弹出子View
@property (strong, nonatomic)UIScrollView *ymSubViewUp;
@property (strong, nonatomic)DMComments *ymCommentsBasic;
//点击Cell文本新闻显示
@property (strong, nonatomic)DMNewsDataModel *ymBasicModel;

@end
