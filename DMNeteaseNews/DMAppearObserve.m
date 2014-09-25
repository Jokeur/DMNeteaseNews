//
//  DMAppearObserve.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMAppearObserve.h"

@interface DMAppearObserve ()

@end

@implementation DMAppearObserve

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//网络监测
+(BOOL)gmNetWorkAppear{
    DMNetWork *netWork = [[DMNetWork alloc] init];
    
    return [netWork gmNetWork];
    
}
//组合成评论Model 在转换成JSON
+(NSString *)gmFromAppearObserveToJSONContentid:(NSString *)contentid andContent:(NSString *)content{
    
    NSString *returnStr;
    if([self gmNetWorkAppear]){
        //得到年月日，时分秒
   
    NSString *timeCur = [DMNowTime gmAcquireNowTime];
    
    //声明Model
    DMAppearObserveModel *tmepAOModel = [[DMAppearObserveModel alloc] init];
    NSString *strStfId = [DMJSONParse gmPassValue:@""];
    
        [tmepAOModel gmAppearObserveContentid:contentid andStfId:strStfId andPublished:timeCur andContent:content];

    //Model转JSON
    NSString *strJSON = [DMJSONCreate gmJSONAppearObserve:tmepAOModel];
    
    
    //发表评论
    NSString *strPath = @"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/AddDiscussRecord";
    returnStr = [ggHttpFounction synHttpPost:strPath ParamName:@"bodyParam" ParamValue:strJSON];
    
    //响应通知，刷新数据
    NSNotification *notifiOne = [[NSNotification alloc] initWithName:@"gmRefreshData" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notifiOne];
    }
    return returnStr;
}
@end
