//
//  DMTailorCommend.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-2.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMTailorCommend.h"

@interface DMTailorCommend ()

@end

@implementation DMTailorCommend

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
    //视图设置
    [self gmTailoraCommendSetBasic];
    
    //导航标题录入
    if(!self.ymLeftTitleArr){
        self.ymLeftTitleArr = [[NSMutableArray alloc] initWithObjects:@"推荐",@"财经",@"频道",@"原创",@"报刊",@"专栏",@"资讯",@"漫画",@"视觉",@"时尚",@"家居",@"笑话",@"美食",@"旅游",@"生活",@"情感",@"星座",@"人文",@"历史",@"娱乐",@"科技",@"体育",@"校刊",@"汽车",@"游戏",@"育儿", nil];
    }
    //左侧ScrollView
    [self gmLeftTitleTV];
    
    //右侧导航内容
    if(!self.ymRightTitleDict){
        self.ymRightTitleDict = [[NSMutableDictionary alloc] init];
    }
    //数据准备
    [self gmDataPrepare];
    
    
    //右侧ScrollView
    [self gmRightTitleTV];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//视图设置
-(void)gmTailoraCommendSetBasic{
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
    
    UIImageView *tempIVOne = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 280, 40)];
    [tempIVOne setImage:[UIImage imageNamed:@"searchUp22.jpg"]];
    [self.view addSubview:tempIVOne];
    
    //返回添加订阅
    UIButton *tempButOne = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [tempButOne setImage:[UIImage imageNamed:@"displayUpLeft111.jpg"] forState:UIControlStateNormal];
    [tempButOne addTarget:self action:@selector(gmCommentReturnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tempButOne];
    
    //搜索阅读
    UIButton *tempButTwo = [[UIButton alloc] initWithFrame:CGRectMake(280, 0, 40, 40)];
    [tempButTwo setImage:[UIImage imageNamed:@"searchUp111.jpg"] forState:UIControlStateNormal];
    [tempButTwo addTarget:self action:@selector(gmInterestCommentSearch:) forControlEvents:UIControlEventTouchUpInside];
    
  
    [self.view addSubview:tempButTwo];



}
//返回添加订阅
-(void)gmCommentReturnAction:(id)sender{
    [UIView animateWithDuration:0.2 animations:^{
         [self.view setFrame:CGRectMake(320, 0, 320, 460)];
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
    
   
    
}
//搜索阅读
-(void)gmInterestCommentSearch:(id)sender{


}
//左侧标题Button建立
-(void)gmLeftCommentTitle:(id)sender{

}
//左侧UITableView
-(void)gmLeftTitleTV{
    //左侧UITableView
    if(!self.ymLeftTitleTV){
        self.ymLeftTitleTV = [[UITableView alloc] init];
        [self.ymLeftTitleTV setBackgroundColor:[UIColor blackColor]];
        [self.ymLeftTitleTV setFrame:CGRectMake(0, 40, 80, 420)];
        self.ymLeftTitleTV.alpha = 0.8;
        self.ymLeftTitleTV.bounces = NO;
        [self.view addSubview:self.ymLeftTitleTV];
        self.ymLeftTitleTV.tag = 3100;
        [self.ymLeftTitleTV setShowsVerticalScrollIndicator:NO];
    }
    self.ymLeftTitleTV.delegate = self;
    self.ymLeftTitleTV.dataSource = self;
    
    
    
    
}
//右侧UITableView
-(void)gmRightTitleTV{
    if(!self.ymRightTitleTV){
        self.ymRightTitleTV = [[UITableView alloc] initWithFrame:CGRectMake(83, 40, 237, 420)];
        [self.ymRightTitleTV setBackgroundColor:[UIColor blackColor]];
        [self.ymRightTitleTV setAlpha:0.8];
        self.ymRightTitleTV.bounces = NO;
        
        [self.view addSubview:self.ymRightTitleTV];
        self.ymRightTitleTV.tag = 3101;
    }
    self.ymRightTitleTV.delegate = self;
    self.ymRightTitleTV.dataSource = self;
    
}

//数据准备
-(void)gmDataPrepare{
    NSMutableArray *arr0 = [[NSMutableArray alloc] initWithObjects:@"冷兔", @"华尔街见闻",@"煮机网",@"车云网",@"豆瓣读书",@"涨姿势",@"译言每日精品",@"视觉中国",@"情感精选",@"网易深度",@"生活周刊",@"海外摄影",@"萝卜网",@"绘本家居",@"美食杰",@"家庭医生在线",@"这才是美国",@"科学公园",@"IBTimes中文网",@"妈咪宝贝传媒",nil];
    [self.ymRightTitleDict setObject:arr0 forKey:@"0"];
    


    NSMutableArray *arr1 = [[NSMutableArray alloc] initWithObjects:@"网易国内", @"网易国际",@"网易探索",@"网易深度",@"网易评论",@"网易航空",@"网易明星网易电视",@"网易音乐",@"网易服饰",@"网易美容",@"网易股票",@"网易足彩",@"网易英超",@"网易西甲",@"网易意甲",@"网易德甲",@"网易双色球",@"网易君子",@"网易养生",nil];
    [self.ymRightTitleDict setObject:arr1 forKey:@"1"];

    NSMutableArray *arr2 = [[NSMutableArray alloc] initWithObjects:@"另一面", @"今日之声",@"今日环球俖客",@"易百科",@"看客",@"微历史",@"娱乐BigBang",@"独家解读",@"数读",@"娱乐连环画",@"一周车坛囧事",@"视野",@"应用一勺烩",@"历史七日谈",@"科技万有瘾力",@"一周媒体速递",@"一周军情观察",@"一周人物",nil];
    [self.ymRightTitleDict setObject:arr2 forKey:@"2"];
    
    NSMutableArray *arr3 = [[NSMutableArray alloc] initWithObjects:@"南方都市报", @"三联生活周刊",@"彭博商业周刊",@"南都娱乐周刊",@"Vista看天下",@"凤凰周刊",@"南都周刊",@"中国新闻周刊",@"新京报",@"21世纪经济报道",@"壹读",@"南方日报",@"商业价值",@"环球人文地理",@"华夏地理",@"参考消息",@"每日经济新闻",@"中国国家地理",@"南方人物周刊",@"经济观察报",@"环球企业家",@"创业邦",@"文艺生活周刊",@"IT时代周刊",@"知音",@"生活周刊",@"财经国家周刊",@"互联网周刊",@"文汇报人民日报",@"华西都市报",@"东南早报",@"《求是》杂志",@"京华时报",@"数字商业时代",@"财经天下周刊",@"周末画报",@"婚姻与家庭",@"环球科学",@"新快报",@"华南报",@"证券时报",@"第一财经日报",@"中国证券报",@"北京晚报",@"东方早报",@"晶报",@"羊城晚报",@"成都晚报",@"金陵晚报",@"武汉晚报",@"海峡都市报",@"钱江晚报",@"齐鲁晚报",@"重庆晚报",@"大河报",@"潇湘晨报",@"金华晚报",@"新闻晚报",@"华商晨报",@"中国青年报",@"北京漫步",@"经济日报",@"重庆青年报",@"江淮晨报",@"先锋居周刊",@"华声月报",@"中国国家天文",@"锐校园",@"成功营销",nil];
    [self.ymRightTitleDict setObject:arr3 forKey:@"3"];
    
    NSMutableArray *arr4 = [[NSMutableArray alloc] initWithObjects:@"新闻杂谈", @"新闻漫画",@"读写客",@"科学现场调查",@"读报",@"每周观察",@"罗辑思维",@"打铁记",@"爱解析",@"亲历死亡",@"理中客",@"大国小民",@"热历史",@"你醒醒吧",@"亦捂亦拾",@"没有回家的士兵",@"权典",@"军事控",@"8点1氪",@"《知乎日报》",@"隔洋观花",nil];
    [self.ymRightTitleDict setObject:arr4 forKey:@"4"];
    
    NSMutableArray *arr5 = [[NSMutableArray alloc] initWithObjects:@"头条新闻", @"煎蛋",@"中国新闻网",@"军事精选",@"人民网",@"喷嚏网",@"中国日报网",@"中国日报精选",@"爱新闻iNews",@"中国台湾网",@"文汇网",@"中国网",@"大公网",@"东方网军事",@"青年参考",@"铁血军事网",@"法制网",@"杨恒均说中国",@"每日外媒精选",@"大旗网",@"大旗网军事",@"没品新闻",@"光明网",@"大洋网",@"麦格时光网",@"海外网",@"新华炫闻",@"成都全搜索",@"抽屉新热榜",@"蛮子文摘",@"iWeekly全球头条",@"音乐人攻略",@"西陆网",@"反洗脑指南",@"标尺自媒体",@"芸思享.彭晓芸",@"坏闻网",@"摩酷新闻",@"风青杨时评",@"今日热点",@"黄瓜网",@"沪江网",@"温州佳才网",@"新闻眼",@"映象网",@"齐鲁网",@"黔讯网",@"求是理论网",@"中华军事",@"外滩Daily",@"军报记者网",@"超市周刊",@"多知网",@"美财社",@"巴中在线",@"氧分子网", @"铁血讲武堂",@"军品志",@"中国LED在线",@"观点中国",@"中顾法制新闻网",@"中国LED网",@"销售技巧",@"一览薪闻",@"中国电子银行网",@"十万个冷知识",@"中国外包网",@"图片新闻",nil];
    [self.ymRightTitleDict setObject:arr5 forKey:@"5"];
    
    NSMutableArray *arr6 = [[NSMutableArray alloc] initWithObjects:@"冷兔", @"张小盒漫画",@"蔡志中漫画",@"阿狸",@"大嘴泉的体育漫画",@"刀刀狗",@"长颈鹿但丁",@"小破孩",@"麦拉风",@"暴走漫画",@"郭斯特",@"想念熊",@"沪江CC猫",@"彼尔德Billd",@"小矛漫画",@"哩哩的抽抽地盘",@"胖兔子粥粥",@"Ben旦旦",@"皮端子漫画",@"想太多的猪",@"我是“白骨精”",@"Nonopanda",@"莫小森",@"PP殿下",@"天朝羽",@"铅笔贼",@"培根君",@"肥仔志",@"Mocmoc摩丝摩丝",@"鸡小德",@"阿哆",@"南南西",@"旋转虾米",@"D6原创漫画",@"炮炮兵",@"恐龟龟",@"虞为",@"罗罗布家族",@"戴福气",@"张朵拉德涂鸦本子",@"夏包纸",@"猫面洛洛", @"fan`s illustration",@"阿汤",@"海洲狮子肉",@"丛林",@"河豚的小宅窝",@"米程程",@"发条猪",@"大红机器的更衣室",@"皮蛋女",@"路猫",@"天忧的恶搞生活",@"许小咩",@"火柴盒子",@"巴萨小马",@"STAN.",@"崇子&潘斯特",@"朱森林漫画",@"BIG*TOY",@"盗儿",@"虎川",@"小呆猫",@"diamond",@"RAY~武汉*涂鸦",@"小野猪毛豆",@"国王殿夏",@"dirtyiron", @"文轩Emi",@"茉小花",@"锄头漫画",@"依平平平",@"营销王",@"混沌之理",@"我的jj不见了",@"我与不可思议的少女们",@"修罗",@"末日流浪",@"剑巫",@"打饭少年",@"作弊艺术",@"BloodRose",@"王者I迷途将军",@"馒头日记",@"桃花缘",@"我不想说我是只鸡",@"暴走星",@"虐斋",@"丽姝猎人",@"替代人异闻",@"熊猫手札",@"守护者传说",@"十万个冷笑话",@"我，女机器人1+2部", @"虎x鹤妖师录",@"约克逊是个郡",@"稚蜂",@"镇魂街",@"女屌丝的幸福大学生活",@"古艳诗",@"萌主嫁到（爆笑）",@"我们都有病",@"青春的照相簿子",@"不是四格的四格",@"与猫相恋",@"口丁",@"考文猫",@"上班了没？",@"养猫日记",@"傻了吧记",@"星座联盟FL",@"魔王日记",@"后宫日常",@"女生小雷",@"MTjj多格杂集",@"柠檬小鸡",@"哈哈江湖",@"混合宿舍的故事",@"你懂滴",@"腐女笔记",@"落在非洲草原的狗",@"戈特",@"失控的Saner",@"司大葱",@"小仙Miko",@"胡辛束",@"潘潘达",@"极品霏",@"赵小白",@"咸鱼老师",@"小草的耳朵",@"Veles",@"安糍喵Annchi", @"那个闲",@"糖糖妹纸",@"小蜗系哇_Wo",@"JONJON囧囧",@"囧爱",nil];
    [self.ymRightTitleDict setObject:arr6 forKey:@"6"];
    
    NSMutableArray *arr7 = [[NSMutableArray alloc] initWithObjects:@"蜂鸟网", @"色影无忌",@"图虫网",@"PPLock",@"UI中国",@"优秀网页设计",@"Leica中文摄影杂志",@"UI设计",@"萌宠趣图",@"500px",@"图片精选",@"米堆摄影网",@"美空网",@"PADMAG视觉杂志",@"视觉中国",@"猫舍",@"视觉同盟",@"菲林胶片小镇",@"海外摄影",@"新摄影",@"摄影之友",@"纪实摄影",@"NASA每日地球大观",@"一图一世界",@"Hi艺术",@"imgii在线视觉杂志",@"1416教室", @"每日一图精选",@"旅途中的风景",@"CCIUP中国动漫插画",@"设计联",@"全球性感街拍",@"工业设计小站",@"猎奇的禁果",@"全球摄影人档案",@"秀设计",@"小清新",@"摄影巴士",@"创意视觉秀",@"琅沐创意年代",@"创意悠悠花园",@"爱午茶创意坊",@"静影沉壁",@"蓝天红柳",@"永荣视界",@"老哥蓝海",@"原生泰",@"张誌聪",@"傻老头/张根震",@"逸小宏",@"严建设",@"随风飞扬",nil];
    [self.ymRightTitleDict setObject:arr7 forKey:@"7"];
    
//    NSMutableArray *arr2 = [[NSMutableArray alloc] initWithObjects:@"1416", @"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",@"<#string#>",nil];
//    [self.ymRightTitleDict setObject:arr2 forKey:@"1"];
    
    NSMutableArray *arr8 = [[NSMutableArray alloc] initWithObjects:@"蜂鸟网", @"色影无忌",@"图虫网",@"PPLock",@"UI中国",@"优秀网页设计",@"Leica中文摄影杂志",@"UI设计",@"萌宠趣图",@"500px",@"图片精选",@"米堆摄影网",@"美空网",@"PADMAG视觉杂志",@"视觉中国",@"猫舍",@"视觉同盟",@"菲林胶片小镇",@"海外摄影",@"新摄影",@"摄影之友",@"纪实摄影",@"NASA每日地球大观",@"一图一世界",@"Hi艺术",@"imgii在线视觉杂志",@"1416教室", @"每日一图精选",@"旅途中的风景",@"CCIUP中国动漫插画",@"设计联",@"全球性感街拍",@"工业设计小站",@"猎奇的禁果",@"全球摄影人档案",@"秀设计",@"小清新",@"摄影巴士",@"创意视觉秀",@"琅沐创意年代",@"创意悠悠花园",@"爱午茶创意坊",@"静影沉壁",@"蓝天红柳",@"永荣视界",@"老哥蓝海",@"原生泰",@"张誌聪",@"傻老头/张根震",@"逸小宏",@"严建设",@"随风飞扬",nil];
    [self.ymRightTitleDict setObject:arr8 forKey:@"8"];
    
    
    NSMutableArray *arr9 = [[NSMutableArray alloc] initWithObjects:@"蜂鸟网", @"色影无忌",@"图虫网",@"PPLock",@"UI中国",@"优秀网页设计",@"Leica中文摄影杂志",@"UI设计",@"萌宠趣图",@"500px",@"图片精选",@"米堆摄影网",@"美空网",@"PADMAG视觉杂志",@"视觉中国",@"猫舍",@"视觉同盟",@"菲林胶片小镇",@"海外摄影",@"新摄影",@"摄影之友",@"纪实摄影",@"NASA每日地球大观",@"一图一世界",@"Hi艺术",@"imgii在线视觉杂志",@"1416教室", @"每日一图精选",@"旅途中的风景",@"CCIUP中国动漫插画",@"设计联",@"全球性感街拍",@"工业设计小站",@"猎奇的禁果",@"全球摄影人档案",@"秀设计",@"小清新",@"摄影巴士",@"创意视觉秀",@"琅沐创意年代",@"创意悠悠花园",@"爱午茶创意坊",@"静影沉壁",@"蓝天红柳",@"永荣视界",@"老哥蓝海",@"原生泰",@"张誌聪",@"傻老头/张根震",@"逸小宏",@"严建设",@"随风飞扬",nil];
    [self.ymRightTitleDict setObject:arr9 forKey:@"9"];
    
    NSMutableArray *arr10 = [[NSMutableArray alloc] initWithObjects:@"蜂鸟网", @"色影无忌",@"图虫网",@"PPLock",@"UI中国",@"优秀网页设计",@"Leica中文摄影杂志",@"UI设计",@"萌宠趣图",@"500px",@"图片精选",@"米堆摄影网",@"美空网",@"PADMAG视觉杂志",@"视觉中国",@"猫舍",@"视觉同盟",@"菲林胶片小镇",@"海外摄影",@"新摄影",@"摄影之友",@"纪实摄影",@"NASA每日地球大观",@"一图一世界",@"Hi艺术",@"imgii在线视觉杂志",@"1416教室", @"每日一图精选",@"旅途中的风景",@"CCIUP中国动漫插画",@"设计联",@"全球性感街拍",@"工业设计小站",@"猎奇的禁果",@"全球摄影人档案",@"秀设计",@"小清新",@"摄影巴士",@"创意视觉秀",@"琅沐创意年代",@"创意悠悠花园",@"爱午茶创意坊",@"静影沉壁",@"蓝天红柳",@"永荣视界",@"老哥蓝海",@"原生泰",@"张誌聪",@"傻老头/张根震",@"逸小宏",@"严建设",@"随风飞扬",nil];
    [self.ymRightTitleDict setObject:arr10 forKey:@"10"];
    
    NSMutableArray *arr11 = [[NSMutableArray alloc] initWithObjects:@"蜂鸟网", @"色影无忌",@"图虫网",@"PPLock",@"UI中国",@"优秀网页设计",@"Leica中文摄影杂志",@"UI设计",@"萌宠趣图",@"500px",@"图片精选",@"米堆摄影网",@"美空网",@"PADMAG视觉杂志",@"视觉中国",@"猫舍",@"视觉同盟",@"菲林胶片小镇",@"海外摄影",@"新摄影",@"摄影之友",@"纪实摄影",@"NASA每日地球大观",@"一图一世界",@"Hi艺术",@"imgii在线视觉杂志",@"1416教室", @"每日一图精选",@"旅途中的风景",@"CCIUP中国动漫插画",@"设计联",@"全球性感街拍",@"工业设计小站",@"猎奇的禁果",@"全球摄影人档案",@"秀设计",@"小清新",@"摄影巴士",@"创意视觉秀",@"琅沐创意年代",@"创意悠悠花园",@"爱午茶创意坊",@"静影沉壁",@"蓝天红柳",@"永荣视界",@"老哥蓝海",@"原生泰",@"张誌聪",@"傻老头/张根震",@"逸小宏",@"严建设",@"随风飞扬",nil];
    [self.ymRightTitleDict setObject:arr11 forKey:@"11"];
    NSMutableArray *arr12 = [[NSMutableArray alloc] initWithObjects:@"蜂鸟网", @"色影无忌",@"图虫网",@"PPLock",@"UI中国",@"优秀网页设计",@"Leica中文摄影杂志",@"UI设计",@"萌宠趣图",@"500px",@"图片精选",@"米堆摄影网",@"美空网",@"PADMAG视觉杂志",@"视觉中国",@"猫舍",@"视觉同盟",@"菲林胶片小镇",@"海外摄影",@"新摄影",@"摄影之友",@"纪实摄影",@"NASA每日地球大观",@"一图一世界",@"Hi艺术",@"imgii在线视觉杂志",@"1416教室", @"每日一图精选",@"旅途中的风景",@"CCIUP中国动漫插画",@"设计联",@"全球性感街拍",@"工业设计小站",@"猎奇的禁果",@"全球摄影人档案",@"秀设计",@"小清新",@"摄影巴士",@"创意视觉秀",@"琅沐创意年代",@"创意悠悠花园",@"爱午茶创意坊",@"静影沉壁",@"蓝天红柳",@"永荣视界",@"老哥蓝海",@"原生泰",@"张誌聪",@"傻老头/张根震",@"逸小宏",@"严建设",@"随风飞扬",nil];
    [self.ymRightTitleDict setObject:arr12 forKey:@"12"];
    NSMutableArray *arr13 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr13 forKey:@"13"];
    
    NSMutableArray *arr14 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr14 forKey:@"14"];
    NSMutableArray *arr15 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr15 forKey:@"15"];
    NSMutableArray *arr16 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr16 forKey:@"16"];
    NSMutableArray *arr17 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr17 forKey:@"17"];
    NSMutableArray *arr18 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr18 forKey:@"18"];
    NSMutableArray *arr19 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr19 forKey:@"19"];
    NSMutableArray *arr20 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr20 forKey:@"20"];
    NSMutableArray *arr21 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr21 forKey:@"21"];
    NSMutableArray *arr22 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr22 forKey:@"22"];
    
    
    
    NSMutableArray *arr23 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr23 forKey:@"23"];
    
    NSMutableArray *arr24 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr24 forKey:@"24"];
    NSMutableArray *arr25 = [[NSMutableArray alloc] initWithObjects:@"舒立时间",@"笑话精选",@"任玩堂",@"华夏地理",@"译言每日精品",@"周末画报",@"网易花田",@"时拾史事",@"菁城子",@"网易君子",@"另一面",@"罗辑思维",@"每日外媒精选",@"外滩Daily",@"色影无忌",@"小清新",@"乐不思蜀",@"Bestfood美食中国",@"VOICER",@"新知精选",@"雷锋网",@"手机之家",@"科技边角料", nil];
    [self.ymRightTitleDict setObject:arr25 forKey:@"25"];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *tempA =[self.ymRightTitleDict objectForKey:[NSString stringWithFormat:@"%d",self.ymFloat]];
    
    return [tempA count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    DMTailReadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //关键的一步，每次赋值时先清空cell
    cell = nil;
    if (cell == nil) {
        cell = [[DMTailReadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //左侧TableView
    if(tableView.tag == 3100){
    
        [cell gmTailorReadCellWidth:80 andHight:60 andTitle:[self.ymLeftTitleArr objectAtIndex:indexPath.row] andTxtColor:0];
    }
    //右侧TableView
    if(tableView.tag == 3101){
        NSMutableArray *tempA =[self.ymRightTitleDict objectForKey:[NSString stringWithFormat:@"%d",self.ymFloat]];
        
         [cell gmTailorReadCellWidth:237 andHight:60 andTitle:[tempA objectAtIndex:indexPath.row] andTxtColor:1];
    }
    
    
    
    return cell;
}

//点击Cell 方法响应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //左侧TableView
    if(tableView.tag == 3100){
        self.ymFloat = indexPath.row;
        
        [self.ymRightTitleTV reloadData];
        [self.ymRightTitleTV setContentOffset:CGPointMake(0, 0)];
       
    }
    //右侧TableView
    if(tableView.tag == 3101){
        
        
    }
    
}



@end
