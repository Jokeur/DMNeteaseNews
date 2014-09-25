//
//  DMPictureTitle.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-24.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMPictureTitle.h"

@interface DMPictureTitle ()

@end

@implementation DMPictureTitle
@synthesize delegate = _delegate;
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

    self.ymPictureTitle = [DMJSONWonderfulComment gmAcquireNewsBoardTitleValue];
    //菜单设置
    [self gmSecondTitle];
    
    //手势
    UISwipeGestureRecognizer *pictureGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gmPictureGRAction)];
    [pictureGR setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:pictureGR];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//手势
-(void)gmPictureGRAction{
    [UIView animateWithDuration:0.2 animations:^{
        [_delegate gmFristTitleDisplay];
    } completion:^(BOOL finished){
       
    }];
}
//准备数据-图片
-(NSMutableArray *)gmPreparePictureData:(NSInteger)contentid{
    //返回数组，里面存储着UIImage
    NSMutableArray *tempReturnMarr = [[NSMutableArray alloc] init];

    NSString *str = [NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetImageNewsByContentId?contentid=%d",contentid ];
    NSURL *tempURL = [NSURL URLWithString:str];
    
    NSMutableDictionary *dictImg = [DMJSONParse gmJSONPictureParse:tempURL andKey:[NSString stringWithFormat:@"%d",contentid]];
    self.ymPictureNewsModel = [dictImg objectForKey:[NSString stringWithFormat:@"%d",contentid]];
    
    NSMutableArray *tempImageModelArr = self.ymPictureNewsModel.ymImageList;

    for(int i = 0;i< [tempImageModelArr count]; i++){
        DMImageInfoModel *tempImageModel  = [tempImageModelArr objectAtIndex:i];
        NSURL *url = [NSURL URLWithString:tempImageModel.ymFrURL];
        
        UIImage *image = [DMJSONParse gmRequestImageNews:url];
        if(image){
            [tempReturnMarr addObject:image];
        }
    }
    return tempReturnMarr;
}


//二级菜单
-(void)gmSecondTitle{
    //设置二级菜单
    if(!self.ymPictureTitleSV){
        self.ymPictureTitleSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        
        [self.ymPictureTitleSV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayFour.jpg"]]];
    }
    //默认是yes,就是滚动超过边界,会反弹有反弹回来的效果,假如是 NO,那么滚动到达边界,那么会连忙停止
    self.ymPictureTitleSV.bounces = NO;
    
       [self.view addSubview:self.ymPictureTitleSV];
    
    //可变数组初始化
    if(!self.ymTitleName){
        self.ymTitleName = [[NSMutableArray alloc] init];
    }
    //下划线
    if(!self.ymDownLine){
        self.ymDownLine = [[NSMutableArray alloc] init];
    }
    
    //TableView
    self.ymTableViewArr = [[NSMutableArray alloc] init];
    //下拉刷新
    self.ymRefreshViewArr = [[NSMutableArray alloc]init];
    //先建立横向ScrollView
    self.ymTempScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 320, 390)];
    self.ymTempScrollV.delegate = self;
    [self.view addSubview:self.ymTempScrollV];
    self.ymTempScrollV.bounces = NO;
    self.ymTempScrollV.showsHorizontalScrollIndicator = NO;
    self.ymTempScrollV.showsVerticalScrollIndicator = NO;
    self.ymTempScrollV.pagingEnabled = YES;
    

    //创建一组|Button
    int count = 0;
    self.ymNum = 0;
    for(int i = 0 ; i < [self.ymPictureTitle count];i ++){
        
        NSString *tempStr = [self.ymPictureTitle objectAtIndex:i];
        
        int strCount= [tempStr length];
        count = count + strCount;
        
        //这里+10可以保证 ，二级菜单前边与后边同距
        UIButton *svButton = [[UIButton alloc] initWithFrame:CGRectMake(self.ymNum+10, 0, strCount*25+8 , 28)];
        UIButton *buttonLine = [[UIButton alloc] initWithFrame:CGRectMake(self.ymNum+15, 28, strCount*25-4, 2)];
        
        //将创建的Button放入数组
        [self.ymTitleName addObject:svButton];
        [self.ymDownLine addObject:buttonLine];
        
        
        //Tableview
        UITableView *tempTavleV = [[UITableView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 390) style:UITableViewStylePlain];
        
        [tempTavleV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
        tempTavleV.delegate = self;
        tempTavleV.dataSource = self;

        
        
        [self.ymTempScrollV setContentSize:CGSizeMake(320*(i+1), 390)];
        [self.ymTempScrollV addSubview:tempTavleV];
        
        //下拉刷新
        
        EGORefreshTableHeaderView *refreshView = [[EGORefreshTableHeaderView alloc] init];
        refreshView.tag = (10000+i)*4;
        [refreshView setFrame:CGRectMake(0, 0, 320, 0)];
        [refreshView setBackgroundColor:[UIColor blueColor]];
        [refreshView setDelegate:self];//委托
        [self.ymRefreshViewArr addObject:refreshView];
        [tempTavleV addSubview:refreshView];
        [refreshView refreshLastUpdatedDate];//刷新时间
        
        [self.ymRefreshViewArr addObject:refreshView];
        [self.ymTableViewArr addObject:tempTavleV];
        
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
        [svButton addTarget:self action:@selector(gmPictureSVButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.ymPictureTitleSV addSubview:buttonLine ];
        
        self.ymNum = self.ymNum + strCount*18 +25;
        
        [self.ymPictureTitleSV setContentSize:CGSizeMake(self.ymNum, 30)];
        
        [svButton setTitle:[self.ymPictureTitle objectAtIndex:i] forState:UIControlStateNormal];
        
        //设置字体 和大小
        [svButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:18.0f]];
        [svButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [self.ymPictureTitleSV addSubview:svButton];
        
    }
}
//二级菜单，关联响应函数
-(void)gmPictureSVButton:(id)sender{
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
            [self.ymPictureTitleSV setContentOffset:CGPointMake(theButton.center.x-150, 0)];
            
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
}

- (void)reloadTableViewDataSource{
	self.ymReloading = YES;
    [self refreshData];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	self.ymReloading = NO;
    
    for(int i = 0;i <[self.ymPictureTitle count]; i ++ ){
        [[self.ymRefreshViewArr objectAtIndex:i] egoRefreshScrollViewDataSourceDidFinishedLoading:[self.ymTableViewArr objectAtIndex:i]];
    }
	
}
//下拉刷新
- (void)viewDidUnload {
    //下拉刷新
    for(int i = 0 ;i < [self.ymPictureTitle count];i ++){
        EGORefreshTableHeaderView *tempRHV = [self.ymRefreshViewArr objectAtIndex:i];
        tempRHV  = nil;
    }
}

#pragma mark EGORefreshTableHeaderDelegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return self.ymReloading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint tempPoint = self.ymTempScrollV.contentOffset;
    UIButton *tempBut = (UIButton *)[self.view viewWithTag:tempPoint.x/320+10000];
    [self gmPictureSVButton:tempBut];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for(int i = 0;i <[self.ymPictureTitle count]; i ++ ){
        [[self.ymRefreshViewArr objectAtIndex:i]  egoRefreshScrollViewDidScroll:scrollView];
    }

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    for(int i = 0;i <[self.ymPictureTitle count]; i ++ ){
        [[self.ymRefreshViewArr objectAtIndex:i] egoRefreshScrollViewDidEndDragging:scrollView];
        
    }

}
#pragma mark  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger tempint = 0;
    for(int i = 0 ; i < [self.ymPictureTitle count]; i ++){
        if(tableView.tag == (10000+i)*3){
            NSMutableDictionary *mDict = [DMJSONWonderfulComment gmSharedJSONNewsPicture];
            NSMutableArray *catidArr = [mDict objectForKey:[NSString stringWithFormat:@"%d",i+1]];
            tempint = [catidArr count];
    
        }
    }
    return tempint;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    DMPictureBoardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //关键的一步，每次赋值时先清空cell
    cell = nil;
    if (cell == nil) {
        cell = [[DMPictureBoardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for(int i = 0 ; i < [self.ymPictureTitle count]; i ++){
        if(tableView.tag == (10000+i)*3){
            NSMutableDictionary *mDict = [DMJSONWonderfulComment gmSharedJSONNewsPicture];
        

            NSMutableArray *catidArr = [mDict objectForKey:[NSString stringWithFormat:@"%d",i+1]];
            
            NSString *strId = [catidArr objectAtIndex:indexPath.row];
            NSMutableArray *tempArr = [self gmPreparePictureData:[strId intValue]];
            
            [cell gmPictureTitleCellImage:tempArr andTitle:self.ymPictureNewsModel.ymTitle andComment:self.ymPictureNewsModel.ymComments];
        }
    }
    
    return cell;
}
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 250;
}
//点击Cell 方法响应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for(int i = 0 ; i < [self.ymPictureTitle count]; i ++){
        if(tableView.tag == (10000+i)*3){
            NSMutableDictionary *mDict = [DMJSONWonderfulComment gmSharedJSONNewsPicture];
            NSMutableArray *catidArr = [mDict objectForKey:[NSString stringWithFormat:@"%d",i+1]];
            NSString *strId = [catidArr objectAtIndex:indexPath.row];
            
            DMPictureNewsModel *tempModel = [DMGroupPicture gmPictureNewsData:[strId intValue]];
            self.ymPictureNews = nil;
            if(!self.ymPictureNews){
                self.ymPictureNews = [[DMPictureNews alloc] init];
                self.ymPictureNews.ymPictureModel = tempModel;
                [self.ymPictureNews.view setFrame:CGRectMake(320, 0, 320, 460)];
            }
            [[self.view superview] addSubview:self.ymPictureNews.view];
            
            [UIView animateWithDuration:0.2 animations:^{
                [self.ymPictureNews.view setFrame:CGRectMake(0, 0, 320, 460)];
            } completion:^(BOOL finished){}];
        }
    }
  
    
    
}


@end
