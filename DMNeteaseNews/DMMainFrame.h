//  主体部分
//  新闻版块
//  DMMainFrame.h
//  CopyNeteaseNews
//
//  Created by Geimin on 14-2-18.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMLeftRightViewDisplay.h"
#import "EGORefreshTableHeaderView.h"
#import "DMTableViewCell.h"//cell
#import "DMNewsDataModel.h"//Data Model
#import "DMPictureNewsModel.h"
#import "DMBasicNews.h"//点击Cell后页面跳转
#import "DMProjectNews.h"
#import "DMVideoNews.h"
#import "DMRecommendNews.h"
#import "DMPictureNews.h"
#import "DMJSONParse.h"//JSON解析
#import "DMPictureNewsModel.h"
#import "DMGroupPicture.h"//图组数据准备
#import "DMJSONWonderfulComment.h"//取得图组新闻ID
#import "DMCollectionSave.h"//新闻收藏
@interface DMMainFrame : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,EGORefreshTableHeaderDelegate>{
    id delagate;
}
@property (strong, nonatomic) id <DMLeftRightViewDisplay> delegate;//委托
@property (strong, nonatomic) Reachability *ymNetworkMainFrame;//网络监测
@property (strong, nonatomic)UIScrollView *ymScrollView;//与菜单关联的 ScrollView
@property (strong, nonatomic) NSMutableArray *ymTitleScrollArr;//存储TableView
@property (strong, nonatomic)NSMutableArray *ymTitleSVArr;//存储ScrollView

@property (nonatomic) NSInteger ymSection;//section,row
@property (nonatomic) NSInteger ymRow;
@property (nonatomic)CGPoint ymStartDragPoint;//滑动开始点
@property (nonatomic)CGPoint ymEndDragPoint;//滑动结束点
@property (strong, nonatomic)UIScrollView *ymSecondSV;//二级菜单
@property (strong, nonatomic)NSMutableArray *ymSecondName;
@property (strong, nonatomic)NSMutableArray *ymDownTitleArr;//存储为选择对象
@property (nonatomic) float ymNum;
@property (strong, nonatomic)NSMutableArray *ymTitleName;//下划线
@property (strong, nonatomic)NSMutableArray *ymDownLine;
@property (strong, nonatomic)UIScrollView *ymDownUpSC;//下拉控件
@property (strong, nonatomic)UIScrollView *ymUpScrollV;//下拉控件，上侧的UIScrollView
@property (strong, nonatomic)UIScrollView *ymDownScrollV;//下拉控件，下侧的UIScrollView
@property (strong, nonatomic)UILabel *ymTitleLabel;//下拉控件,覆盖标题栏
@property (nonatomic)NSInteger ymUnread;//下拉控件，未读新闻分类个数
@property (strong, nonatomic) UIView *ymLeftRoll;//下拉控件，人性化滚动
@property (strong, nonatomic)UIScrollView *ymRightViewDown;
@property (strong, nonatomic)UIButton *ymRoll_But;
@property (strong, nonatomic)NSMutableArray *ymJudgeTitle;//判断未读栏目数目
@property (strong, nonatomic)EGORefreshTableHeaderView *ymRefreshHeaderView;//下拉刷新
@property (nonatomic)BOOL ymLoading;//下拉刷新判断
@property (strong, nonatomic)NSMutableArray *ymRefreshViewArr;//存储下拉刷新视图
@property (strong, nonatomic)NSMutableArray *ymAllModel;//数据处理
@property (nonatomic)NSInteger ymPageSize;//UIPageViewControl
@property (strong, nonatomic)DMNewsDataModel *ymNewsDataModel;//Data Model
@property (strong, nonatomic)NSMutableArray *ymNewsDataModelArr;
@property (strong, nonatomic)NSMutableDictionary *ymAllModelDict;//存储一个分类的所有新闻集合
@property (strong, nonatomic)NSString *ymNewsSavePath;//数据存档
@property (strong, nonatomic) NSArray *ymArrFristCell;//Cell第一行
@property (nonatomic)NSInteger ymEndCell;//解决最后一行始终在最下方
@property (strong, nonatomic)DMJSONParse *ymJSONParse; //JSON解析
@property (strong, nonatomic)DMBasicNews *ymBasicNews;//点击Cell后页面跳转
@property (strong, nonatomic)DMProjectNews *ymProjectNews;//专题新闻
@property (strong, nonatomic)DMVideoNews *ymVideoNews;//视频新闻
@property (strong, nonatomic)DMRecommendNews *ymRecommendNews;//推荐新闻
@property (strong, nonatomic)DMPictureNews *ymPictureNews;//图组新闻
@property (strong, nonatomic)NSMutableDictionary *ymCatidDict;//取得各分类的图组
@property (strong, nonatomic)NSMutableDictionary *ymPictureDict;//取得图组新闻iD
@end
