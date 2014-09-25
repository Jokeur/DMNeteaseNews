//
//  DMMainFrame.m
//  CopyNeteaseNews
//
//  Created by Geimin on 14-2-18.
//  Copyright (c) 2014年 Geimin. All rights reserved.
// mark

#import "DMMainFrame.h"

@interface DMMainFrame ()

@end

@implementation DMMainFrame
@synthesize ymSecondName = _ymSecondName;
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

    //数据存储地址
    self.ymNewsSavePath = saveData_Path;
  
    //获得缓存中的数据
    self.ymAllModelDict = [self gmAcquireSaveNewsData];
    //清空缓存
//    [self gmRemoveSaveNewsData];

    
    //组，行
    self.ymSection = 2;
    self.ymRow = 6;
    
    //请求默认分类的20条新闻
    self.ymPageSize = 10;

    //注册一个通知，通知TableView更新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gmModelNoticicationCenterMethod:) name:@"modelNCOne" object:Nil];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"nightBackground.png"]]];
  
    //二级菜单名 定义
    if(!self.ymSecondName){
        self.ymSecondName = [[NSMutableArray alloc] initWithObjects:@"财经",@"科技",@"军事",@"数码",@"手机",@"移动互联",@"国际",@"国内",@"探索",@"深度",@"汽车",@"房产", nil];
    }
    //未选择菜单
    if(!self.ymDownTitleArr){
        self.ymDownTitleArr = [[NSMutableArray alloc] initWithObjects:@"论坛",@"博客",@"微博",@"听新闻",@"社会",@"电影",@"彩票",@"NBA",@"中超",@"国际足球",@"CBA",@"原创",@"家居",@"旅游",@"教育",@"酒香",@"情感",@"游戏",@"重庆",@"真话",@"历史",@"聚合阅读", nil];
    }
    

       //WiFi网络继续操作
        [self gmHaveNetWork];
    
   
    //新闻版块标题栏 数据刷新
    [self gmNewsBoardTitleRefresh];
    
    
}
//新闻版块标题栏 数据刷新
-(void)gmNewsBoardTitleRefresh{
    //菜单设置
    [self gmSecondTitle];
    
    //与菜单关联的 ScrollView，ContentSize设置，Xib中拖出的
    [self.ymScrollView setContentSize:CGSizeMake([self.ymSecondName count]*320, 390)];
    //默认是yes,滚动超过边界会反弹,NO,滚动到边界会连忙停止
    self.ymScrollView.bounces = NO;
    
    //整页翻动
    [self.ymScrollView setPagingEnabled:YES];
    self.ymScrollView.delegate = self;
    self.ymScrollView.alwaysBounceHorizontal = YES;
    self.ymScrollView.showsHorizontalScrollIndicator = NO;
    self.ymScrollView.showsVerticalScrollIndicator = NO;

    //在Scrollview上添加Table
    [self gmAddTableViewToSV];
    
    //刷新最后更新日期
    for(int i = 0 ;i < [self.ymTitleScrollArr count];i ++){
        EGORefreshTableHeaderView *tempRHV = [self.ymRefreshViewArr objectAtIndex:i];
        [tempRHV refreshLastUpdatedDate];
    }
    
    //下拉菜单
    [self gmRightRoll];
    
    //判断未读栏目数目
    if(!self.ymJudgeTitle){
        self.ymJudgeTitle = [[NSMutableArray alloc] init];
        [self.ymJudgeTitle addObject:[self.ymSecondName objectAtIndex:0]];
    }

}

//需要有网络才执行的操作写入这个方法
-(void)gmHaveNetWork{
    [self gmRequestPicture:1 andPageSize:self.ymPageSize andPage:1];

    //请求图组数据
    //创建队列
    dispatch_queue_t curQueueSix = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(curQueueSix, ^{
        [DMJSONParse sharedJSONParseMethod];//解析初始化
        [DMCollectionSave sharedCollection];//收藏初始化
        [self gmRequestGroupPictureArr];//图组请求
        
    });
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//二级菜单
-(void)gmSecondTitle{
    //设置二级菜单
    self.ymSecondSV = nil;
    if(!self.ymSecondSV){
        self.ymSecondSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 280, 30)];

        [self.ymSecondSV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayFour.jpg"]]];
    }
    if(!self.ymScrollView){
        self.ymScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, 320, 390)];
    }
    [self.view addSubview:self.ymScrollView];
    //默认是yes,会反弹有反弹,假如是 NO,那么滚动到达边界,那么会连忙停止
    self.ymSecondSV.bounces = NO;
    
    //设置右侧下拉按键
    [self.view addSubview:self.ymSecondSV];
    self.ymRightViewDown = nil;
    if(!self.ymRightViewDown){
        self.ymRightViewDown = [[UIScrollView alloc] initWithFrame:CGRectMake(280, 40, 40, 30)];
         [self.ymRightViewDown setAlpha:0.8];
    }
    
    [self.ymRightViewDown setContentSize:CGSizeMake(40, 120)];
    [self.ymRightViewDown setShowsHorizontalScrollIndicator:NO];
    [self.ymRightViewDown setShowsVerticalScrollIndicator:NO];

    [self.view addSubview:self.ymRightViewDown];
    [self.ymRightViewDown setBackgroundColor:[UIColor grayColor]];
    
    //可变数组初始化
    self.ymTitleName = nil;
    if(!self.ymTitleName){
        self.ymTitleName = [[NSMutableArray alloc] init];
    }
    //下划线
    self.ymDownLine = nil;
    if(!self.ymDownLine){
        self.ymDownLine = [[NSMutableArray alloc] init];
        
    }
    
    //往图片版块传输数据
    [DMJSONWonderfulComment gmNewsBoardTitleChangeValue:self.ymSecondName];
    
    //创建一组|Button,新闻版块菜单栏
    int count = 0;
    self.ymNum = 0;
    for(int i = 0 ; i < [self.ymSecondName count];i ++){
        
        NSString *tempStr = [self.ymSecondName objectAtIndex:i];
        
        int strCount= [tempStr length];
        count = count + strCount;
        
        //这里+10可以保证 ，二级菜单前边与后边同距
        UIButton *svButton = [[UIButton alloc] initWithFrame:CGRectMake(self.ymNum+10, 0, strCount*18 , 28)];
        UIButton *buttonLine = [[UIButton alloc] initWithFrame:CGRectMake(self.ymNum+5, 28, strCount*18+10, 2)];
        
        //将创建的Button放入数组
        [self.ymTitleName addObject:svButton];
        [self.ymDownLine addObject:buttonLine];
        //设置Tag
        [svButton setTag:10000+i];
        [buttonLine setTag:(10000+i)*2];
        
        //设置默认参数
        if(i == 0){
            [svButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [buttonLine setBackgroundColor:[UIColor redColor]];
        }
        
        //二级菜单，关联响应函数
        [svButton addTarget:self action:@selector(gmMainFrameSVButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.ymSecondSV addSubview:buttonLine ];
        self.ymNum = self.ymNum + strCount*18 +20;
        [self.ymSecondSV setContentSize:CGSizeMake(self.ymNum, 30)];
        [svButton setTitle:[self.ymSecondName objectAtIndex:i] forState:UIControlStateNormal];
        
        //设置字体 和大小
        [svButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:18.0f]];
        [svButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [self.ymSecondSV addSubview:svButton];
    }
}

//右侧下拉控件 的伸缩
-(void)gmRightViewUp:(id)sender{
    UIButton *tempBut = (UIButton *)sender;
    //右侧下拉控件
    if(!self.ymDownUpSC){
        self.ymDownUpSC = [[UIScrollView alloc ] init];
        [self.ymDownUpSC setFrame:CGRectMake(0, 70, 320, 0)];
        [self.ymDownUpSC setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
        [self.view addSubview:self.ymDownUpSC];
    }
    //上侧的UIScrollView
    [self gmRightUpSVSet];
    //下侧的UIScrollView
    [self gmRightDownSVSet];
    
       //使用UILabel覆盖菜单栏
    if(!self.ymTitleLabel){
        self.ymTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 280, 30)];
        [self.ymTitleLabel setBackgroundColor:[UIColor blackColor]];
        [self.ymTitleLabel setTextColor:[UIColor whiteColor]];
    }
    
    self.ymTitleLabel.text = [NSString stringWithFormat:@"%d个未读栏目点击进入",([self.ymSecondName count] - [self.ymJudgeTitle count])];
    [self.ymTitleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.ymTitleLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:self.ymTitleLabel];
  
    //右侧下拉控件 显示未读项目数目
    if(tempBut.isSelected){
        [self.ymTitleLabel setHidden:NO];
          [tempBut setSelected:NO];
        [self performSelector:@selector(gmPromptNureadThree) withObject:self afterDelay:0];
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.ymDownUpSC setFrame:CGRectMake(0, 70, 320, 390)];
        } completion:^(BOOL finished){
        }];
      
    }else{

        [self performSelector:@selector(gmPromptNureadZero) withObject:self afterDelay:0];
            [UIView animateWithDuration:0.2   animations:^{
                [self.ymDownUpSC setFrame:CGRectMake(0,70, 320, 0)];
                
                //新闻版块标题栏 数据刷新
                [self gmNewsBoardTitleRefresh];
                
            }];
            [self.ymTitleLabel setHidden:YES];
        }
    [tempBut setSelected:YES];
}
//右侧下拉控件 初始化
-(void)gmymDownUpSCSet{
    //右侧下拉控件
    if(!self.ymDownUpSC){
        self.ymDownUpSC = [[UIScrollView alloc ] init];
        [self.ymDownUpSC setFrame:CGRectMake(0, 70, 320, 0)];
        [self.ymDownUpSC setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
        [self.view addSubview:self.ymDownUpSC];
        
    }
}

//上侧的UIScrollView
-(void)gmRightUpSVSet{
    [self.ymDownUpSC reloadInputViews];
    
    //上侧的UIScrollView
    self.ymUpScrollV = nil;
    if(!self.ymUpScrollV){
        self.ymUpScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    }
  
    [self.ymDownUpSC addSubview:self.ymUpScrollV];
    for(int i = 0;i < [self.ymSecondName count]/4 +1;i ++ ){
        int tempNum =4;
        int tempJ = [self.ymSecondName count]%4;
        if(i == [self.ymSecondName count]/4){
            tempNum = tempJ;
        }
        
        
        for(int j = 0;j < tempNum ;j ++ ){
            UIButton *tempButDown = [UIButton buttonWithType:UIButtonTypeSystem];
            [tempButDown setFrame:CGRectMake(78*j+8, 35*i+5, 70, 30)];
            [tempButDown.layer setCornerRadius:5];
            [tempButDown setBackgroundColor:[UIColor whiteColor]];
            [tempButDown setTitle:[self.ymSecondName objectAtIndex:i*4+j] forState:UIControlStateNormal];
            [tempButDown setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted ];
            
            //重复点击删除
            [tempButDown addTarget:self action:@selector(gmButtonUpTitle:) forControlEvents:UIControlEventTouchDown];
            
            tempButDown.tag = 30000 + i*4+j;
            [tempButDown setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tempButDown.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [self.ymUpScrollV addSubview:tempButDown];
        }
        [self.ymUpScrollV setContentSize:CGSizeMake(320, (i+1)*40)];
    }
    //UIlabel说明
    UILabel *upLabEnd = [[UILabel alloc] initWithFrame:CGRectMake(0, 162, 320, 10)];
    [self.ymDownUpSC addSubview:upLabEnd];
    [upLabEnd setText:@"点击后删除"];
    [upLabEnd setFont:[UIFont systemFontOfSize:12]];
    [upLabEnd setTextAlignment:NSTextAlignmentRight];
    [upLabEnd setTextColor:[UIColor grayColor]];
    
[self.ymUpScrollV reloadInputViews];
}
//下侧的UIScrollView
-(void)gmRightDownSVSet{
   
   [self.ymDownUpSC reloadInputViews];
  
    //下侧的UIScrollView
    self.ymDownScrollV = nil;
  
    if(!self.ymDownScrollV){
       self.ymDownScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 195, 320, 195)];
    }

    [self.ymDownUpSC addSubview:self.ymDownScrollV];
    [self.ymDownScrollV setBackgroundColor:[UIColor blackColor]];
    [self.ymDownScrollV setAlpha:0.7];
    [self.ymDownScrollV setBounces:NO];
    [self.ymDownScrollV setShowsVerticalScrollIndicator:NO];
    
    //UIlabel标题
    UILabel *downLabTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 175, 320, 20)];
    [self.ymDownUpSC addSubview:downLabTitle];
    [downLabTitle setText:@"点击添加"];
    [downLabTitle setFont:[UIFont systemFontOfSize:14]];
    [downLabTitle setTextAlignment:NSTextAlignmentLeft];
    [downLabTitle setTextColor:[UIColor whiteColor]];
    [downLabTitle setBackgroundColor:[UIColor blackColor]];
    [downLabTitle setAlpha:0.7];
    
    for(int i = 0;i < [self.ymDownTitleArr count]/4 +1;i ++ ){
        int tempNum =4;
        int tempJ = [self.ymDownTitleArr count]%4;
        if(i == [self.ymDownTitleArr count]/4){
            tempNum = tempJ;
        }
        
        for(int j = 0;j < tempNum ;j ++ ){
            UIButton *tempButDown = [UIButton buttonWithType:UIButtonTypeSystem];
            [tempButDown setFrame:CGRectMake(78*j+8, 35*i+5, 70, 30)];
            [tempButDown.layer setCornerRadius:5];
            [tempButDown setBackgroundColor:[UIColor whiteColor]];
            [tempButDown setTitle:[self.ymDownTitleArr objectAtIndex:i*4+j] forState:UIControlStateNormal];
            [tempButDown setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted ];
            
            //单击添加
            [tempButDown addTarget:self action:@selector(gmButtonDwonTitle:) forControlEvents:UIControlEventTouchDown];
            
            tempButDown.tag = 40000 + i*4+j;
            [tempButDown setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [tempButDown.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [self.ymDownScrollV addSubview:tempButDown];

        }
        [self.ymDownScrollV setContentSize:CGSizeMake(320, (i+1)*40)];
    }
[self.ymDownScrollV reloadInputViews];

}
//重复点击删除
-(void)gmButtonUpTitle:(id)sender{
    UIButton *tmepBut = (UIButton *)sender;
    [tmepBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [tmepBut setBackgroundColor:[UIColor grayColor]];
    
    NSString *strName = tmepBut.titleLabel.text;
    
    //从显示目录删除
    [self.ymSecondName removeObject:strName];
    
    //添加到另一个目录
        [self.ymDownTitleArr addObject:strName];
        

   
        //下侧的UIScrollView
        [self gmRightDownSVSet];
        //上侧的UIScrollView
        [self gmRightUpSVSet];
 
}
//单击添加
-(void)gmButtonDwonTitle:(id)sender{
    
//ymDownTitleArr
    UIButton *tmepBut = (UIButton *)sender;
    
    NSString *strName = tmepBut.titleLabel.text;
    
    //从显示目录删除
    [self.ymDownTitleArr removeObject:strName];
    
    //添加到另一个目录,先查找有无这个对象

        [self.ymSecondName addObject:strName];


        //下侧的UIScrollView
        [self gmRightDownSVSet];
        //上侧的UIScrollView
        [self gmRightUpSVSet];
 
}

//二级菜单，关联响应函数
-(void)gmMainFrameSVButton:(id)sender{
    UIButton *but = (UIButton *)sender;
    
    //唯一显示标题背景
    [self gmTitle_button:but];
    
    //唯一Line显示红色
    UIButton *tempBut = (UIButton *)[self.view viewWithTag:but.tag*2];
    [self gmLine_button:tempBut];

    //关联上Button 和Tableview
    UIScrollView *tempSV = (UIScrollView *)[self.view viewWithTag:but.tag*3];
    [UIView animateWithDuration:0 animations:^{} completion:^(BOOL finished){
        [self.ymScrollView setContentOffset:CGPointMake(tempSV.frame.origin.x, tempSV.frame.origin.y) ];
    }];
    
    //数据请求
    [self gmRequestNewsData:but.tag];
    
}
//数据请求,点击二级菜单，和滑动视图都是经过此方法请求
-(void)gmRequestNewsData:(NSInteger)theTag{

    for(int i = 0; i < [self.ymSecondName count];i ++){
        if(theTag == 10000+i){
            [self gmRequestNetData:i + 1];
        }
    }
}
////清空缓存
//-(void)gmRemoveSaveNewsData{
//    NSError *error = nil;
//    NSFileManager *fmOne = [NSFileManager defaultManager];
// 
//    [fmOne removeItemAtPath:self.ymNewsSavePath error:&error];
//    
//}
//获得缓存中的数据
-(NSMutableDictionary *)gmAcquireSaveNewsData{
    //逆归档
    NSData *deCodeData = [NSData dataWithContentsOfFile:self.ymNewsSavePath];
    NSMutableDictionary *tempAcquireDict = nil;
    if(deCodeData){
       tempAcquireDict = [NSKeyedUnarchiver unarchiveObjectWithData:deCodeData];
    }
   

    return tempAcquireDict;
}

//请求新闻
-(void)gmRequestPicture:(NSInteger)theCatid andPageSize:(NSInteger)thePageSize andPage:(NSInteger)thePage{
    //接收Model，使用字典，存储一个分类的所有新闻集合，即上面的数组
    if(!self.ymAllModelDict){
        self.ymAllModelDict = [[NSMutableDictionary alloc] init];
    }

    //通知返回消息，存储分类标号，判断应该刷新哪一个分类
    NSDictionary *tempCategory = [[NSDictionary alloc ] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",theCatid - 1],@"theCategroy", nil];
    
    //网络请求数据之前，先判断沙盒里面有没有当前网络请求的数据
    NSArray *decodeNewsArr = [self.ymAllModelDict objectForKey:[NSString stringWithFormat:@"%d",theCatid]];
    NSInteger lastIndex = [decodeNewsArr indexOfObject:[decodeNewsArr lastObject]];
    if(lastIndex + 1 < thePageSize*thePage){
        //按照新闻内容分类
        NSString *urlInput = [NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetNewsListByCatidAndPagesizeAndPage?catid=%d&pagesize=%d&page=%d",theCatid,thePageSize,thePage];
        NSURL *urlNews = [NSURL URLWithString:urlInput];
        
        //调用解析类中的方法，返回字典
        
           self.ymAllModelDict = [DMJSONParse gmRequestNewsFromCatid:theCatid andURL:urlNews];
       
    }
    //通知TableView更新数据，同时使用Dictionary传回该跟新的分类，theCategroy
    NSNotification *endData = [NSNotification notificationWithName:@"modelNCOne" object:nil userInfo:tempCategory];
    [[NSNotificationCenter defaultCenter] postNotification:endData];
}
//请求图组
-(void)gmRequestGroupPictureArr{
    //按照分类使用字典存储 图组
    NSMutableDictionary *catidDict = [[NSMutableDictionary alloc] init];
    
    //数据准备
    [DMGroupPicture gmPrepareNewsDataCatid:[self.ymSecondName count]+1 andPageSize:20 andPage:6];
    //取得图组新闻iD
   self.ymPictureDict = [DMJSONWonderfulComment gmSharedJSONNewsPicture];
    
    for(int i = 0 ; i < [self.ymSecondName count];i ++){
        NSMutableArray *pictArr = [self.ymPictureDict objectForKey:[NSString stringWithFormat:@"%d",i +1]];
        //把一个分类的所有图组存储到一个数组中
        NSMutableArray *catidArr = [[NSMutableArray alloc] init];
        for(int j = 0; j < [pictArr count]; j ++){
            NSInteger contentID = [[pictArr objectAtIndex:j] intValue];
            //返回图组
            NSMutableArray *pictCatid = [DMGroupPicture gmPreparePictureData:contentID];
            
            if([pictCatid count]){
                [catidArr addObject:pictCatid];
            }
            
        }
        
        
        [catidDict setObject:catidArr forKey:[NSString stringWithFormat:@"%d",i+1] ];
    
    }
    //取得各分类的图组
    self.ymCatidDict = catidDict;

}



//多线程,数据请求，自动判断该请求第几页
-(void)gmRequestNetData:(NSInteger)theModelid{
    //创建队列
    dispatch_queue_t curQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(curQueue, ^{
        NSArray *tempModelDictData = [self.ymAllModelDict objectForKey:[NSString stringWithFormat:@"%d",theModelid]];
        
        [self gmRequestPicture:theModelid andPageSize:self.ymPageSize andPage:[tempModelDictData count]/self.ymPageSize +1 ];
        
    });
    
}
//使用主线程给，TableView传值
-(void)gmTransferDataToTableView:(NSInteger)theCategory{
   //主线程，先只请求第 index=0的分类
    dispatch_queue_t curQueueTwo = dispatch_get_main_queue();
  
    dispatch_async(curQueueTwo, ^{
        [[self.ymTitleScrollArr objectAtIndex:theCategory] reloadData];
    });
}

//注册一个通知，通知TableView更新数据
-(void)gmModelNoticicationCenterMethod:(id)sender{
    //判断是哪一个新闻分类需要更新
    NSInteger theCategroy = [[[sender userInfo] objectForKey:@"theCategroy"] intValue];
    
    //更新TableView 数据
    [self gmTransferDataToTableView:theCategroy];
    
    //注销 通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loserInfo" object:nil];
    
    //使用其它线程对数据存档
    if(self.ymAllModelDict){
    dispatch_queue_t curQueueFour = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(curQueueFour, ^{
        NSData *saveData = [NSKeyedArchiver archivedDataWithRootObject:self.ymAllModelDict];
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm createFileAtPath:self.ymNewsSavePath contents:saveData attributes:nil];
    });
    }
    
}

//菜单栏 字体变色
-(void)gmTitle_button:(UIButton *)theButton{
    BOOL result = YES;
    for(int j = 0 ;j < [self.ymTitleName count];j ++){
        [[self.ymTitleName objectAtIndex:j] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [theButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    //右侧下拉控件判断
    for(int i = 0; i <[self.ymJudgeTitle count];i ++){
        if([[self.ymJudgeTitle objectAtIndex:i] isEqualToString:theButton.titleLabel.text]){
            result = NO;
        }
    }
    if(result){
        [self.ymJudgeTitle addObject:theButton.titleLabel.text];
        //这里是添加未读的菜单Title，所以每点击到一个未读菜单时，控制右侧弹出数量提示
        [UIView animateWithDuration:0 animations:^{} completion:^(BOOL finished){
             [self.ymRightViewDown setContentOffset:CGPointMake(0, 0)];
        }];
       
        //延时方法处理
        [self performSelector:@selector(gmPromptNureadOne) withObject:self afterDelay:0];
        [self performSelector:@selector(gmPromptNureadTwo) withObject:self afterDelay:1];
        [self performSelector:@selector(gmPromptNureadZero) withObject:self afterDelay:1.5];
        
    }
    //自动 Title 居中
    if(theButton.center.x > 100 && theButton.center.x < self.ymNum-90){
        
        [UIView animateWithDuration:0.2 animations:^{
             [self.ymSecondSV setContentOffset:CGPointMake(theButton.center.x-150, 0)];
        }];
    }
}

//延时处理 调用方法0
-(void)gmPromptNureadZero{
    [UIView animateWithDuration:0 animations:^{
    } completion: ^(BOOL finished){
        [self.ymRightViewDown setContentOffset:CGPointMake(0, 0)];
    }];
}
//延时处理 调用方法1
-(void)gmPromptNureadOne{
    [UIView animateWithDuration:0.2 animations:^{
        [self.ymRoll_But setTitle:[NSString stringWithFormat:@"%d",([self.ymSecondName count] - [self.ymJudgeTitle count])] forState:UIControlStateNormal];
        [self.ymRightViewDown setContentOffset:CGPointMake(0, -30)];
    } completion: ^(BOOL finished){
        
    }];
}
//延时处理 调用方法2
-(void)gmPromptNureadTwo{
    [UIView animateWithDuration:0.2 animations:^{
        [self.ymRightViewDown setContentOffset:CGPointMake(0, -60)];
    } completion: ^(BOOL finished){
        
    }];
}
//延时处理 调用方法3
-(void)gmPromptNureadThree{
    [UIView animateWithDuration:0 animations:^{
    } completion: ^(BOOL finished){
          [self.ymRightViewDown setContentOffset:CGPointMake(0, -90)];
    }];
}
//右侧下拉控件的人性化滚动
-(void)gmRightRoll{
    if(!self.ymLeftRoll){
        self.ymLeftRoll = [[UIView alloc] initWithFrame:CGRectMake(1, -90, 40, 120)];
    }
    NSArray *arr = [[NSArray alloc] initWithObjects:@"upOne.jpg",@"downOne.jpg",@"rightDown2222.jpg",@"downOne.jpg", nil];
    for(int i = 0 ; i < 4; i ++){
        UIButton *tempBut = [[UIButton alloc] initWithFrame:CGRectMake(0, i*30, 39, 30)];
        
        [tempBut setImage:[UIImage imageNamed:[arr objectAtIndex:i]] forState:UIControlStateNormal];
        
        //全部都关联同一个方法
        [tempBut addTarget:self action:@selector(gmRightViewUp:) forControlEvents:UIControlEventTouchUpInside ];
        [tempBut setSelected:YES];
        tempBut.tag = 100000+i;
        if(i == 0){
          [tempBut setSelected:NO];
        }
        
         if(i == 2){
         self.ymRoll_But = [UIButton buttonWithType:UIButtonTypeSystem];
             
             //  self.ymRoll_But = [UIButton buttonWithType:UIButtonTypeCustom];
           
             self.ymRoll_But.frame = CGRectMake(5, 2, 26, 26);
             [self.ymRoll_But.layer setMasksToBounds:YES];
             //设置半径
             [self.ymRoll_But.layer setCornerRadius:13];
             [self.ymRoll_But setBackgroundImage:[UIImage imageNamed:@"rightRed.jpg"] forState:UIControlStateNormal];
        
             [self.ymRoll_But setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             [tempBut addSubview:self.ymRoll_But];
         }
         [self.ymLeftRoll addSubview:tempBut];
     }
    [self.ymRightViewDown addSubview:self.ymLeftRoll];
}

//菜单栏 下划线
-(void)gmLine_button:(UIButton *)theButton{
    for(int i = 0 ;i < [self.ymDownLine count];i ++){
        [(UIButton *)[self.ymDownLine objectAtIndex:i] setBackgroundColor:[UIColor clearColor]];

    }
    [theButton setBackgroundColor:[UIColor redColor]];

}
//在Scrollview上添加Table
-(void)gmAddTableViewToSV{
    //存储TableView
    if(!self.ymTitleScrollArr){
        self.ymTitleScrollArr = [[NSMutableArray alloc] init];
    }
    [self.ymTitleScrollArr removeAllObjects];

    //下拉刷新存储
    if(!self.ymRefreshViewArr){
        self.ymRefreshViewArr = [[NSMutableArray alloc] init];
    }
    [self.ymRefreshViewArr removeAllObjects];
    for(int i = 0;i < [self.ymSecondName count];i ++){
        //声明Table
        UITableView *tempTableV = [[UITableView alloc] initWithFrame:CGRectMake(i*320, 0, 320, 390)];
 
        [tempTableV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"nightBackground.png"]]];
        
        [tempTableV setTag:(10000+i)*3];
        //设置代理
        tempTableV.dataSource = self;
        tempTableV.delegate = self;
        
        //下拉刷新
        self.ymRefreshHeaderView = [[EGORefreshTableHeaderView alloc] init];
        self.ymRefreshHeaderView.tag = (10000+i)*4;
        [self.ymRefreshHeaderView setFrame:CGRectMake(0, 0, 320, 0)];
        [self.ymRefreshHeaderView setBackgroundColor:[UIColor blueColor]];
        [self.ymRefreshHeaderView setDelegate:self];
        [self.ymRefreshViewArr addObject:self.ymRefreshHeaderView];
        [tempTableV addSubview:self.ymRefreshHeaderView];
        [self.ymTitleScrollArr addObject:tempTableV];
        [self.ymScrollView addSubview:tempTableV];
       
    }
}

//更新数据
-(void)refreshData{
    //判断ScrollView 的偏移，决定应该解析什么类的新闻
    CGPoint thePoint = [self.ymScrollView contentOffset];
    NSInteger theModelid = thePoint.x/320 +1;
    //网络请求
    [self gmRequestNetData:theModelid];
}
#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	self.ymLoading = YES;
    [self refreshData];
}
- (void)doneLoadingTableViewData{
	//  model should call this when its done loading
	self.ymLoading = NO;
    
    for(int i = 0 ;i < [self.ymTitleScrollArr count];i ++){
       UITableView *tempTV = [self.ymTitleScrollArr objectAtIndex:i];
        EGORefreshTableHeaderView *tempRHV = [self.ymRefreshViewArr objectAtIndex:i];

        [tempRHV egoRefreshScrollViewDataSourceDidFinishedLoading:tempTV];
    }
	
}
#pragma mark EGORefreshTableHeaderDelegate
//刷新表标题并触发刷新
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}
//刷新表标题数据并加载
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return self.ymLoading;
}
//刷新表标题数据最后更新源
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}
- (void)viewDidUnload {
    //下拉刷新
    for(int i = 0 ;i < [self.ymTitleScrollArr count];i ++){
        EGORefreshTableHeaderView *tempRHV = [self.ymRefreshViewArr objectAtIndex:i];
        tempRHV  = nil;
    }
	//[self doneLoadingTableViewData];
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for(int i = 0 ;i < [self.ymTitleScrollArr count];i ++){
        EGORefreshTableHeaderView *tempRHV = [self.ymRefreshViewArr objectAtIndex:i];
        [tempRHV egoRefreshScrollViewDidScroll:scrollView];
    }
}
//开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.ymStartDragPoint = scrollView.contentOffset;//开始点
}
//结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.ymEndDragPoint = scrollView.contentOffset;//结束点
    
    //下拉刷新
    for(int i = 0 ;i < [self.ymTitleScrollArr count];i ++){
        EGORefreshTableHeaderView *tempRHV = [self.ymRefreshViewArr objectAtIndex:i];
        
        [tempRHV egoRefreshScrollViewDidEndDragging:scrollView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   //二级菜单
//这里使用ScrollView 有Bug，下拉刷新时会跳转到第一个菜单去
//    //CGPoint tempPoint = scrollView.contentOffset;
    
    CGPoint tempPoint = self.ymScrollView.contentOffset;
    for(int i = 0; i < [self.ymTitleScrollArr count] ; i ++){
        
        UITableView *tempTV = [self.ymTitleScrollArr objectAtIndex:i];
        
       if(tempTV.frame.origin.x  == tempPoint.x && tempTV.frame.origin.y == tempPoint.y){
            UIButton *tempBut = (UIButton *)[self.view viewWithTag:tempTV.tag / 3];
            UIButton *tempLineBut = (UIButton *)[self.view viewWithTag:tempTV.tag/3 *2];
     
            [self gmTitle_button:tempBut];
            [self gmLine_button:tempLineBut];
           
         //跟新数据，要去数据请求
           [self gmRequestNewsData:tempBut.tag];
        }
    }
    //判断开始拖动，和结束拖动 的位置偏移都是一样的
    if(self.ymStartDragPoint.x == 0 && self.ymStartDragPoint.y == 0 && self.ymEndDragPoint.x == 0 && self.ymEndDragPoint.y == 0){
       [_delegate gmLeftRightViewDisplay:YES andLeft:NO];
  
    }
    if ((self.ymStartDragPoint.x == [self.ymSecondName count]*320 - 320) && self.ymStartDragPoint.y == 0 && (self.ymEndDragPoint.x  == [self.ymSecondName count]*320 - 320) && self.ymEndDragPoint.y  == 0 ) {
        
          [_delegate gmLeftRightViewDisplay:YES andRight:NO];

    }
}


#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

      static NSString *CellIdentifier = @"Cell";
    DMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //关键的一步，每次赋值时先清空cell
    cell = nil;
    if (cell == nil) {
        cell = [[DMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   int m = indexPath.section * (self.ymRow-1) -1 + indexPath.row;
   

    //保留每组的第一行，用作图片显示
    if(indexPath.section == 0 && indexPath.row == 0){
        
        for(int i = 0;i < [self.ymSecondName count];i ++){
            if(tableView.tag == (10000 +i)*3){
                if(self.ymCatidDict){
                    //设置Cell默认格式topic_post_back_large2.png
                    [cell gmSectionZeroRowZero:[[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"topic_post_back_large2.png"], nil]  andHight:150 andTarget:self];
                    
                   NSMutableArray *catidArr = [self.ymCatidDict objectForKey:[NSString stringWithFormat:@"%d",i+1]];
             
                    if([catidArr count]){
                        NSMutableArray *tempImgArr = [catidArr objectAtIndex:0] ;
                        [cell gmSectionZeroRowZero:tempImgArr andHight:150 andTarget:self];
                    }
                }
            }
        }
    }
    else if(indexPath.section != 0 && indexPath.row == 0){
        
        for(int i = 0;i < [self.ymSecondName count];i ++){
            if(tableView.tag == (10000 +i)*3){
                if(self.ymCatidDict){
                    //先设置默认格式topic_post_back_small.png
                    [cell gmSectionRowZero:NO andIVOne:[UIImage imageNamed:@"topic_post_back_small.png"] andIVTwo:[UIImage imageNamed:@"topic_post_back_small.png"] andIVThree:[UIImage imageNamed:@"topic_post_back_small.png"] andHight:80];
                    
                    
                    NSMutableArray *catidArr = [self.ymCatidDict objectForKey:[NSString stringWithFormat:@"%d",i+1]];
                    
                    if([catidArr count]){
                        if([catidArr count] > indexPath.section  ){
                            NSMutableArray *tempImgArr = [catidArr objectAtIndex:indexPath.section] ;
                            if([tempImgArr count] > 2){
                                [cell gmSectionRowZero:NO andIVOne:[tempImgArr objectAtIndex:0] andIVTwo:[tempImgArr objectAtIndex:1] andIVThree:[tempImgArr objectAtIndex:2] andHight:80];
                            }else{
                                [cell gmSectionRowZero:NO andIVOne:[tempImgArr objectAtIndex:0] andIVTwo:[tempImgArr objectAtIndex:0] andIVThree:[tempImgArr objectAtIndex:0] andHight:80];
                                
                            }
                        }
                    }
                    
                }
            }
        }
    }
    else if(indexPath.section == self.ymEndCell*self.ymSection-1 && indexPath.row == self.ymRow-1){
        for(int i = 0;i < [self.ymSecondName count];i ++){
            if(tableView.tag == (10000 +i)*3){
                [cell gmFootLabel:@"点击加载更多" andHight:30];
            }
        }
    }else{
        
        //分类操作不同的TableView
        for(int i = 0;i < [self.ymSecondName count];i ++){
            if(tableView.tag == (10000 +i)*3){
                if(self.ymAllModelDict){
                
                    NSArray *cellArr = [self.ymAllModelDict objectForKey:[NSString stringWithFormat:@"%d",i+1]];
                    if(cellArr){
                     
                        if(m < [cellArr count]){
                            DMNewsDataModel *tempCellModel =  [cellArr objectAtIndex:m];
                        
                            //获取数据
                            NSURL *tempURL = [NSURL URLWithString:tempCellModel.ymThumb];

                            [cell gmLeftIV:[DMJSONParse gmRequestImageNews:tempURL] andModelid:[tempCellModel.ymModelid intValue]andCommentsNum:tempCellModel.ymComments andTitle:tempCellModel.ymTitle andInfo:tempCellModel.ymDescription andHight:60];
                        }
                    }
                }
            }
        }
    }
    

    
    
    return cell;
}

//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    self.ymEndCell = 1;
    for(int i = 0;i < [self.ymSecondName count];i ++){
        if(tableView.tag == (10000 +i)*3){
            if(self.ymAllModelDict){
                
                NSArray *cellArr = [self.ymAllModelDict objectForKey:[NSString stringWithFormat:@"%d",i+1]];
                if([cellArr count] > self.ymPageSize &&[cellArr count]%self.ymPageSize>0 ){
                    self.ymEndCell = [cellArr count]/self.ymPageSize +1;
                }else {
                    self.ymEndCell = [cellArr count]/self.ymPageSize;
                
                }
            }
        }
    }
 
    
   return self.ymEndCell*self.ymSection;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.ymRow;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        return 150;
    }
    else if (indexPath.section != 0 && indexPath.row == 0){
        return 80;
    }
    else if(indexPath.section == self.ymEndCell*self.ymSection-1 && indexPath.row == self.ymRow-1){
        return 30;
    }
    else{
        return 60;
    }
}
//点击Cell 方法响应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
     
    
     //点击加载更多
     if(indexPath.section == self.ymEndCell*self.ymSection-1 && indexPath.row == self.ymRow-1){
         for(int i = 0;i < [self.ymSecondName count];i ++){
             if(tableView.tag == (10000 +i)*3){
                //自动判断，网络请求页数
                 [self gmRequestNetData:i + 1 ];
             }
         }
     
     }else{
     //跳转后到另一个方法中去判断，图集，专题，视频
         if(indexPath.row != 0){
            for(int i = 0;i < [self.ymSecondName count];i ++){
                if(tableView.tag == (10000 +i)*3){
                    [self gmLookThroughNews:i +1 andLocation:indexPath.section * (self.ymRow - 1) + indexPath.row-1];
                }
           }
         }
         else if(indexPath.row == 0){
        
             for(int i = 0;i < [self.ymSecondName count];i ++){
                 if(tableView.tag == (10000 +i)*3){
                     [self gmLookGroupPicCatid: i +1  andLocation:indexPath.section];
                 }
             }
            
         }
     }
}
//indext row = 0 跳转
-(void)gmLookGroupPicCatid:(NSInteger )theCatid andLocation:(NSInteger)theLocation{
    //取得图组新闻iD
    
    if(self.ymPictureDict){
        NSMutableArray *tempArr = [self.ymPictureDict objectForKey:[NSString stringWithFormat:@"%d",theCatid]];
        if(tempArr){
             NSInteger contentid = [[tempArr objectAtIndex:theLocation] intValue];
            
            if(contentid){
            //图集
                DMPictureNewsModel *tempPicModel = [[DMPictureNewsModel alloc] init];
                tempPicModel.ymContentid = [NSString stringWithFormat:@"%d",contentid];
                
                    self.ymPictureNews = nil;
                    if(!self.ymPictureNews){
                        self.ymPictureNews = [[DMPictureNews alloc] init];
                        
                        self.ymPictureNews.ymPictureModel = tempPicModel;
                        [self.ymPictureNews.view setFrame:CGRectMake(320, 0, 320, 460)];
                        
                    }
                    [self.view addSubview:self.ymPictureNews.view];
              
                [UIView animateWithDuration:0.2 animations:^{
                    [self.ymPictureNews.view setFrame:CGRectMake(0, 0, 320, 460)];
                } completion:^(BOOL finished){}];
            }
        }
    }
}

//跳转后到另一个方法中去判断，图集，专题，视频
-(void)gmLookThroughNews:(NSInteger)theCatid andLocation:(NSInteger)theLocation{
    if(self.ymAllModelDict){
        NSArray *tempArr = [self.ymAllModelDict objectForKey:[NSString stringWithFormat:@"%d",theCatid]];
        if(tempArr){
            DMNewsDataModel *dataModel = [tempArr objectAtIndex:theLocation];
            if(dataModel){
                if([dataModel.ymModelid intValue] == 2){
                //图集
                    self.ymPictureNews = nil;
                    if(!self.ymPictureNews){
                        self.ymPictureNews = [[DMPictureNews alloc] init];
                        self.ymPictureNews.ymPictureModel = (DMPictureNewsModel *)dataModel;
                         [self.ymPictureNews.view setFrame:CGRectMake(320, 0, 320, 460)];
                    }
                    [self.view addSubview:self.ymPictureNews.view];
                    [UIView animateWithDuration:0.2 animations:^{
                        [self.ymPictureNews.view setFrame:CGRectMake(0, 0, 320, 460)];
                    } completion:^(BOOL finished){}];
                
                }else if([dataModel.ymModelid intValue] == 4){
                //视频
                    self.ymVideoNews = nil;
                    if(!self.ymVideoNews){
                        self.ymVideoNews = [[DMVideoNews alloc] init];
                        self.ymVideoNews.ymVideoModel = dataModel;
                        [self.ymVideoNews.view setFrame:CGRectMake(320, 0, 320, 460)];
                    }
                    [self.view addSubview:self.ymVideoNews.view];
                    
                    [UIView animateWithDuration:0.2 animations:^{
                        [self.ymVideoNews.view setFrame:CGRectMake(0, 0, 320, 460)];
                    } completion:^(BOOL finished){}];
                    
                }else if([dataModel.ymModelid intValue] == 9){
                //推荐
                    self.ymRecommendNews = nil;
                    if(!self.ymRecommendNews){
                        self.ymRecommendNews = [[DMRecommendNews alloc] init];
                        self.ymRecommendNews.ymRecommendModel = dataModel;
                         [self.ymRecommendNews.view setFrame:CGRectMake(320, 0, 320, 460)];
                    }
                    [self.view addSubview:self.ymRecommendNews.view];
                   
                    [UIView animateWithDuration:0.2 animations:^{
                        [self.ymRecommendNews.view setFrame:CGRectMake(0, 0, 320, 460)];
                    } completion:^(BOOL finished){}];
                    
                }else if([dataModel.ymModelid intValue] == 10){
                //专题
                    self.ymProjectNews = nil;
                    if(!self.ymProjectNews){
                        self.ymProjectNews = [[DMProjectNews alloc] init];
                        self.ymProjectNews.ymProjectModel = dataModel;
                        [self.ymProjectNews.view setFrame:CGRectMake(320, 0, 320, 460)];
                    }
                    [self.view addSubview:self.ymProjectNews.view];
                   
                    [UIView animateWithDuration:0.2 animations:^{
                        [self.ymProjectNews.view setFrame:CGRectMake(0, 0, 320, 460)];
                    } completion:^(BOOL finished){}];
                }else {
                    self.ymBasicNews = nil;
                    if(!self.ymBasicNews){
                        self.ymBasicNews = [[DMBasicNews alloc] init];
                        self.ymBasicNews.ymBasicModel = dataModel;
                        [self.ymBasicNews.view setFrame:CGRectMake(320, 0, 320, 460)];
                    }
                    [self.view addSubview:self.ymBasicNews.view];

                    [UIView animateWithDuration:0.2 animations:^{
                        [self.ymBasicNews.view setFrame:CGRectMake(0, 0, 320, 460)];
                    } completion:^(BOOL finished){}];
                }
                
            }
            
        }
    
    }
  
}



@end
