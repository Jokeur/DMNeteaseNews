//  项目入口
//  文本新闻版块
//  DMMainEnter.h
//  CopyNeteaseNews
//
//  Created by Geimin on 14-2-18.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMLeftRightViewDisplay.h"
#import "DMMainFrame.h"
#import "DMEdition.h"
#import "DMEnterLand.h"
#import "DMCollectVC.h"
#import "DMWeather.h"
#import "DMSearchVC.h"
#import "DMTsukkomlVC.h"
#import "DMPublishNews.h"
#import "DMFollowUpVC.h"
#import "DMNightDayVC.h"
#import "DMMessageVC.h"
#import "DMSetRight.h"
#import "DMBallot.h"
#import "DMUserModel.h"
#import "DMUserManager.h"
#import "DMFollowPaste.h"
#import "DMPictureTitle.h"
#import "DMTailorRead.h"
#import "DMJSONParse.h"
#import "DMLeaveLine.h"//离线
#import "Reachability.h"
@interface DMMainEnter : UIViewController<DMLeftRightViewDisplay,UIAlertViewDelegate>
@property (strong, nonatomic)Reachability *ymNetwork;//网络监测
@property (strong, nonatomic)DMMainFrame *ymMainFrame;//新闻主体版块
@property (strong, nonatomic)UIView *ymLeftView;//左侧一级导航
@property (strong, nonatomic)NSMutableArray *ymMArrLeft;//存储导航Button
@property (strong, nonatomic)UIView *ymRightView;//右侧用户中心
@property (strong, nonatomic)NSMutableArray *ymLeftButton;//存储用户中心功能Button
@property (strong, nonatomic)UIView *ymLeftEnd;
@property (nonatomic)float ymLeftF;//左侧一级导航宽度
@property (nonatomic)float ymRightF;//右侧用户中心宽度
@property (strong, nonatomic)UIView *ymTitleView;//状态栏
@property (strong, nonatomic)UIImageView *ymTitleImg;//title中间UIImageview
@property (strong, nonatomic)UIView *ymTopView;//左侧右侧弹出时，用View遮住self.ymMainFrame
@property (strong, nonatomic)UILabel *ymLandingLab; //立即登陆Button
@property (strong, nonatomic) NSMutableArray *ymMarkLeftBuTArr;//右侧标签Button列表
@property (strong, nonatomic)DMEdition *ymEditionVC;//版本控件
@property (strong, nonatomic)DMEnterLand *ymEnterLand;//注册登录
@property (strong, nonatomic)DMUserManager *ymUserManeger;//用户信息管理
@property (strong, nonatomic)DMUserModel *ymUserModel;//用户登录返回信息
@property (strong, nonatomic)UIButton *ymHeadPhoto;    //用户中心，头像
@property (strong, nonatomic)DMCollectVC *ymCollectVC;//收藏
@property (strong, nonatomic)DMWeather *ymWeatherVC;//天气
@property (strong, nonatomic)DMSearchVC *ymSearchVC;//搜索
@property (strong, nonatomic)DMTsukkomlVC *ymTsukkomlVC;//吐槽
@property (strong, nonatomic)DMPublishNews *ymPublishNews;//爆料功能
@property (strong, nonatomic)DMFollowUpVC *ymFollowUpVC;//跟帖
@property (strong, nonatomic)DMNightDayVC *ymNightDayVC;//日/夜
@property (strong, nonatomic)DMMessageVC *ymMessageVC;//消息
@property (strong, nonatomic)DMSetRight *ymSetRightVC;//设置
@property (strong, nonatomic)DMBallot *ymBallot;//投票
@property (strong, nonatomic)DMFollowPaste *ymFollowPaste;//跟帖
@property (strong, nonatomic)DMPictureTitle *ymPictureTitle;//图片
@property (strong, nonatomic)DMTailorRead *ymTailorRead;//订阅
@property (nonatomic)NSInteger ymJudgeFirstTitle;//判断，不能重复选择同一选项
@property (strong, nonatomic)id ymTakeOver;//代理，调整frame


@end
