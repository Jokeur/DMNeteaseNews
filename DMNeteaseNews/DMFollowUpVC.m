//
//  DMFollowUpVC.m
//  DMNeteaseNews
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMFollowUpVC.h"

@interface DMFollowUpVC ()

@end

@implementation DMFollowUpVC

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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
    
    

    [DMJSONWonderfulComment gmSharedMyJoinNIL ];
    [DMJSONWonderfulComment gmSharedCallMeNIL];
    if(![[DMJSONParse gmPassValue:@""] isEqualToString:@""]){
        //创建队列
        dispatch_queue_t curQueueddd = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(curQueueddd, ^{
            //数据准备
            [DMGroupPicture gmPrepareNewsDataCatid:[[DMJSONWonderfulComment gmAcquireNewsBoardTitleValue] count]+1 andPageSize:20 andPage:6];
            
        });

    }
    
    //取出本用户的评论
//    self.ymCommentMarr = nil;
    if(!self.ymCommentMarr){
        self.ymCommentMarr = [[NSMutableArray alloc] init];
    }
    //新闻爆料评论
//    self.ymCommentCellMe = nil;
    if(!self.ymCommentCellMe){
        self.ymCommentCellMe = [[NSMutableArray alloc] init];
    }
    
    
    //修理标题栏
    UIImageView *tempIVThree = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 0, 276.5, 42.5)];
    [tempIVThree setImage:[UIImage imageNamed:@"myComments1.jpg"]];
    [self.view addSubview:tempIVThree];
    
    UIButton *leftUpBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42.5, 42.5)];
    [leftUpBut addTarget:self action:@selector(gmLeftUpBut) forControlEvents:UIControlEventTouchUpInside];
    [leftUpBut setImage:[UIImage imageNamed:@"displayUpLeft111.jpg"] forState:UIControlStateNormal];
    
    [self.view addSubview:leftUpBut];


    //二级菜单名 定义
    if(!self.ymFollowPaste){
        self.ymFollowPaste = [[NSMutableArray alloc] initWithObjects:@"我的跟帖",@"回复我的", nil];
    }
    //菜单设置
    [self gmSecondTitle];
    
    //手势，让避左侧视图
    UISwipeGestureRecognizer *followGRMy = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gmFollowGRAction)];
    [followGRMy setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:followGRMy];
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
//        [self.view removeFromSuperview];
    }];
}
//手势
-(void)gmFollowGRAction{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(320, 20, 320, 460)];
    } completion:^(BOOL finished){}];
    
}
//二级菜单
-(void)gmSecondTitle{
    //设置二级菜单
    if(!self.ymFollowPasteSV){
        self.ymFollowPasteSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, 30)];
        
        [self.ymFollowPasteSV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayFour.jpg"]]];
    }
    self.ymFollowPasteSV.bounces = NO;
    [self.ymFollowPasteSV setContentOffset:CGPointMake(0, 0)];
    [self.view addSubview:self.ymFollowPasteSV];
    
    //可变数组初始化
    if(!self.ymTitleName){
        self.ymTitleName = [[NSMutableArray alloc] init];
    }
    //下划线
    if(!self.ymDownLine){
        self.ymDownLine = [[NSMutableArray alloc] init];
    }
    //ArrTableView
    self.ymTableViewArr = [[NSMutableArray alloc] init];
    //下拉刷新
    self.ymRefreshViewArr = [[NSMutableArray alloc]init];
    
    //先建立横向ScrollView
    self.ymTempScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30+40, 320, 390)];
    self.ymTempScrollV.delegate = self;
    [self.view addSubview:self.ymTempScrollV];
    self.ymTempScrollV.bounces = NO;
    self.ymTempScrollV.showsHorizontalScrollIndicator = NO;
    self.ymTempScrollV.showsVerticalScrollIndicator = NO;
    self.ymTempScrollV.pagingEnabled = YES;
    
    //创建一组|Button
    int count = 0;
    self.ymNum = 0;
    for(int i = 0 ; i < [self.ymFollowPaste count];i ++){
        NSString *tempStr = [self.ymFollowPaste objectAtIndex:i];
        int strCount= [tempStr length];
        count = count + strCount;
        //菜单Button
        UIButton *svButton = [[UIButton alloc] initWithFrame:CGRectMake(i*(320/[self.ymFollowPaste count]), 0,  (320/[self.ymFollowPaste count]), 28)];
        //下划线Button
        UIButton *buttonLine = [[UIButton alloc] initWithFrame:CGRectMake(i*(320/[self.ymFollowPaste count])+40, 28,(320/[self.ymFollowPaste count])-80 , 2)];
        //Tableview
        UITableView *tempTavleV = [[UITableView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 390) style:UITableViewStylePlain];
        [tempTavleV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
        [self.ymTableViewArr addObject:tempTavleV];
        
        tempTavleV.delegate = self;
        tempTavleV.dataSource = self;
        
        
        [self.ymTempScrollV setContentSize:CGSizeMake(320*(i+1), 390)];
        [self.ymTempScrollV addSubview:tempTavleV];
        //将创建的Button放入数组
        [self.ymTitleName addObject:svButton];
        [self.ymDownLine addObject:buttonLine];
        //设置Tag
        [svButton setTag:10000+i];
        [buttonLine setTag:(10000+i)*2];
        [tempTavleV setTag:(10000+i)*3];
        
        
        //设置默认参数
        if(i == 0){
            [svButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [buttonLine setBackgroundColor:[UIColor redColor]];
        }
        //二级菜单，关联响应函数
        [svButton addTarget:self action:@selector(gmSVButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.ymNum = self.ymNum + strCount*18 +20;
        [self.ymFollowPasteSV setContentSize:CGSizeMake(self.ymNum, 30)];
        [svButton setTitle:[self.ymFollowPaste objectAtIndex:i] forState:UIControlStateNormal];
        
        //设置字体 和大小
        [svButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:18.0f]];
        [svButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [self.ymFollowPasteSV addSubview:buttonLine ];
        [self.ymFollowPasteSV addSubview:svButton];
        
        //下拉刷新
        EGORefreshTableHeaderView *refreshView = [[EGORefreshTableHeaderView alloc] init];
        refreshView.tag = (10000+i)*4;
        [refreshView setFrame:CGRectMake(0, 0, 320, 0)];
        [refreshView setBackgroundColor:[UIColor blueColor]];
        [refreshView setDelegate:self];//委托
        [self.ymRefreshViewArr addObject:refreshView];
        [tempTavleV addSubview:refreshView];
        [refreshView refreshLastUpdatedDate];//刷新时间
    }
}

//二级菜单，关联响应函数
-(void)gmSVButton:(id)sender{
    UIButton *but = (UIButton *)sender;
    
    //唯一显示标题背景
    [self gmTitle_button:but];
    
    //唯一Line显示红色
    UIButton *tempBut = (UIButton *)[self.view viewWithTag:but.tag*2];
    [self gmLine_button:tempBut];
    
    //唯一关联一个Tableview
    UITableView *tempTV = (UITableView *)[self.view viewWithTag:but.tag*3];
    CGPoint tvPoint = tempTV.frame.origin;
    //横向ScrollView偏移
    [self.ymTempScrollV setContentOffset:tvPoint ];
    
}


//菜单栏 字体变色
-(void)gmTitle_button:(UIButton *)theButton{
    for(int j = 0 ;j < [self.ymTitleName count];j ++){
        [[self.ymTitleName objectAtIndex:j] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [theButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //自动 Title 居中
    if(theButton.center.x > 100 && theButton.center.x < self.ymNum-90){
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.ymFollowPasteSV setContentOffset:CGPointMake(theButton.center.x-150, 0)];
        }];
    }
}
//菜单栏 下划线
-(void)gmLine_button:(UIButton *)theButton{
    for(int i = 0 ;i < [self.ymDownLine count];i ++){
        [[self.ymDownLine objectAtIndex:i] setBackgroundColor:[UIColor clearColor]];
    }
    [theButton setBackgroundColor:[UIColor redColor]];
    
}
///下拉刷新
-(void)refreshData{
    NSLog(@"刷新数据");
    
    for(int i = 0; i <2 ;i ++){
        UITableView *tempTV = (UITableView *)[self.view viewWithTag:(10000+i)*3];
        
        [tempTV reloadData];
    }
    
    
}

- (void)reloadTableViewDataSource{
	self.ymReloading = YES;
    [self refreshData];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	self.ymReloading = NO;
    
    for(int i = 0;i <[self.ymRefreshViewArr count]; i ++ ){
        [[self.ymRefreshViewArr objectAtIndex:i] egoRefreshScrollViewDataSourceDidFinishedLoading:[self.ymTableViewArr objectAtIndex:i]];
    }
	
}

- (void)viewDidUnload {
    //下拉刷新
    for(int i = 0 ;i < [self.ymRefreshViewArr count];i ++){
        EGORefreshTableHeaderView *tempRHV = [self.ymRefreshViewArr objectAtIndex:i];
        tempRHV  = nil;
    }
	//[self doneLoadingTableViewData];
}

#pragma mark EGORefreshTableHeaderDelegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return self.ymReloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for(int i = 0;i <[self.ymRefreshViewArr count]; i ++ ){
        [[self.ymRefreshViewArr objectAtIndex:i]  egoRefreshScrollViewDidScroll:scrollView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    for(int i = 0;i <[self.ymRefreshViewArr count]; i ++ ){
        [[self.ymRefreshViewArr objectAtIndex:i] egoRefreshScrollViewDidEndDragging:scrollView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    CGPoint tempPoint = self.ymTempScrollV.contentOffset;
    UIButton *tempBut = (UIButton *)[self.view viewWithTag:tempPoint.x/320+10000];
    [self gmSVButton:tempBut];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView.tag == 10000*3){
        
        return [[DMJSONWonderfulComment gmSharedMyJoinComment] count];
    }else{
        
        return [[DMJSONWonderfulComment gmSharedCallMeComment] count];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    DMFollowCardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //关键的一步，每次赋值时先清空cell
    cell = nil;
    if (cell == nil) {
        cell = [[DMFollowCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(tableView.tag == 10000*3){
        //我的跟帖
        DMNewsDataModel *tempWonder = [[DMJSONWonderfulComment gmSharedMyJoinComment] objectAtIndex:indexPath.row];
        DMCommentModel *tempComment = [self.ymCommentMarr objectAtIndex:indexPath.row];
        
        
        [cell gmEvaluateFromTableViewWithHight:self.ymCellHight+40 andTitle:tempWonder.ymTitle andContent:tempComment.ymContent andSource:tempComment.ymNickName];
        
    }
    
    if(tableView.tag == 10001*3){
        //回复我的跟帖
        DMNewsDataModel *tempToday = [[DMJSONWonderfulComment gmSharedCallMeComment] objectAtIndex:indexPath.row];
       
            DMCommentModel *tempCommentOne = [self.ymCommentCellMe objectAtIndex:indexPath.row];
            
            [cell gmEvaluateFromTableViewWithHight:self.ymCellHight+40 andTitle:tempToday.ymTitle andContent:tempCommentOne.ymContent andSource:tempCommentOne.ymNickName];
        
    }
    return cell;
}
//判断每行高度，
-(float)gmRowHightFromContentid:(NSInteger)contentid{
    NSString *strPath = [NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetDiscussRecordListByContentid?contentid=%d",contentid];
    NSURL *url = [NSURL URLWithString:strPath];
    NSMutableArray *commentArr = [DMJSONParse gmJSONCommentList:url];

    //评论内容
    NSString *contentStr;
    for(int i = 0; i <[commentArr count]; i ++){
        DMCommentModel *tempComModel = [commentArr objectAtIndex:i];
        //若与本用户的ID相同则取出
        if([[NSString stringWithFormat:@"%d",tempComModel.ymStfId] isEqualToString:[DMJSONParse gmPassValue:@""]] ){
            
            [self.ymCommentMarr addObject:tempComModel];
            //评论内容
            contentStr = tempComModel.ymContent;
        }else{
            [self.ymCommentCellMe addObject:[commentArr firstObject]];
            //评论内容
            contentStr = tempComModel.ymContent;
        }
        
    }
 

    
    float hight = [DMJSONWonderfulComment gmTextHightFromWidth:280 andFontSize:14 andString:contentStr];
    self.ymCellHight = hight;
    
    return hight;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(tableView.tag == 10000*3){
        //我的跟帖
        DMNewsDataModel *tempWonder = [[DMJSONWonderfulComment gmSharedMyJoinComment] objectAtIndex:indexPath.row];
        
        float hight = [self gmRowHightFromContentid:[tempWonder.ymContentid intValue]];
        return hight + 40;
    }else{
        //我的爆料
        DMNewsDataModel *tempToday = [[DMJSONWonderfulComment gmSharedCallMeComment] objectAtIndex:indexPath.row];
        
        float hight = [self gmRowHightFromContentid:[tempToday.ymContentid intValue]];
        return hight + 40;
        
    }
    
}
//点击Cell 方法响应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMNewsDataModel *tempWonder;
    if(tableView.tag == 10000*3){
        //我的跟帖
        tempWonder = [[DMJSONWonderfulComment gmSharedMyJoinComment] objectAtIndex:indexPath.row];
    }
    
    if(tableView.tag == 10001*3){
        //回复我的跟帖
        tempWonder = [[DMJSONWonderfulComment gmSharedCallMeComment] objectAtIndex:indexPath.row];
      
    }
    if(tempWonder){
    self.ymBasicNews = nil;
    if(!self.ymBasicNews){
        self.ymBasicNews = [[DMBasicNews alloc] init];
        self.ymBasicNews.ymBasicModel = tempWonder;
        [self.ymBasicNews.view setFrame:CGRectMake(320, 0, 320, 460)];
    }
    [self.view addSubview:self.ymBasicNews.view];
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.ymBasicNews.view setFrame:CGRectMake(0, 0, 320, 460)];
        } completion:^(BOOL finished){}];
    }
}

@end
