//
//  DMLeaveLine.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-9.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMLeaveLine.h"

@implementation DMLeaveLine
//网络监测
+(BOOL)gmNetWorkLeaveLine{
    DMNetWork *netWork = [[DMNetWork alloc] init];
    
    return [netWork gmNetWork];
    
}
//请求新闻
+(void)gmRequestLeaveLinePageSize:(NSInteger)size andCatidNum:(NSInteger)catid{
   
    if([self gmNetWorkLeaveLine]){
//    //创建队列
//    dispatch_queue_t curQueueSev = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
//    dispatch_async(curQueueSev, ^{

    //数据存储地址
    NSString *strPath = saveData_Path;

    NSMutableDictionary *allModelDict;
    
    for(int i = 0; i < catid; i ++){
        //按照新闻内容分类
        NSString *urlInput = [NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetNewsListByCatidAndPagesizeAndPage?catid=%d&pagesize=%d&page=%d",i+1,size,1];
        NSURL *urlNews = [NSURL URLWithString:urlInput];
        
        //调用解析类中的方法，返回字典
//         [allModelDict objectForKey:[NSString stringWithFormat:@"%d",i +1]];
        
        allModelDict = [DMJSONParse gmRequestNewsFromCatid:i + 1 andURL:urlNews];
        
    }
    //存储到沙盒
    NSFileManager *fm = [NSFileManager defaultManager];
    NSData *tempData = [NSKeyedArchiver archivedDataWithRootObject:allModelDict];
    
    [fm createFileAtPath:strPath contents:tempData attributes:nil];

    }
}



@end
