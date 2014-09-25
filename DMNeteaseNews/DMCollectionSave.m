//
//  DMCollectionSave.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-9.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMCollectionSave.h"

@implementation DMCollectionSave

static DMCollectionSave *sharedCollectionSave;
static NSMutableArray *sharedNewsCollection;//新闻收藏
static NSMutableArray *sharedCommentCollection;//跟帖收藏
static NSMutableArray *sharedPictureCollection;//图片收藏

//单例初始化
+(void)sharedCollection{
    if(!sharedCollectionSave){
        sharedCollectionSave = [[DMCollectionSave alloc] init];
        sharedNewsCollection = [[NSMutableArray alloc] init];
        sharedCommentCollection = [[NSMutableArray alloc] init];
        sharedPictureCollection = [[NSMutableArray alloc] init];
    }
    


}
//网络监测
+(BOOL)gmNetWorkCollection{
    DMNetWork *netWork = [[DMNetWork alloc] init];
    
    return [netWork gmNetWork];
    
}
//赋值
+(void)gmSharedNews:(DMNewsDataModel *)news{
   [self gmAcquireCollectDataPath:collectPath_save];
    BOOL result = YES;
    for(int i = 0;i < [sharedNewsCollection count];i ++){
        DMNewsDataModel *tempModel = [sharedNewsCollection objectAtIndex:i ];
        if([tempModel.ymContentid intValue] == [news.ymContentid intValue]){
            result = NO;
        }
    }
    if(result){
        [sharedNewsCollection addObject:news];
        //存档
        [self gmSaveDataShared];
    }
}
//跟帖收藏
+(void)gmSharedComment:(DMCommentModel *)comment{
[self gmAcquireCollectDataPath:collectPath_save];
    BOOL result = YES;
    for(int i = 0;i < [sharedCommentCollection count];i ++){
        DMCommentModel *tempModel = [sharedCommentCollection objectAtIndex:i ];
        if(tempModel.ymContentId  == comment.ymContentId ){
            result = NO;
        }
    }
    if(result){
        [sharedCommentCollection addObject:comment];
        //存档
        [self gmSaveDataShared];
    }
}
//图片收藏
+(void)gmSharedPicture:(DMPictureNewsModel *)picture{
    [self gmAcquireCollectDataPath:collectPath_save];
    BOOL result = YES;
    for(int i = 0;i < [sharedPictureCollection count];i ++){
        DMNewsDataModel *tempModel = [sharedPictureCollection objectAtIndex:i ];
        if([tempModel.ymContentid intValue] == [picture.ymContentid intValue]){
            result = NO;
        }
    }
    if(result){
        
        [sharedPictureCollection addObject:picture];
        //存档
        [self gmSaveDataShared];
    }
}

//取值
//新闻收藏
+(NSMutableArray *)gmSharedNewsCollection{

    return sharedNewsCollection;
}
//跟帖收藏
+(NSMutableArray *)gmSharedCommentCollection{
    return sharedCommentCollection;
}
//图片收藏
+(NSMutableArray *)gmSharedPictureCollection{
    return sharedPictureCollection;

}

//返回文本新闻，标题
+(NSString *)gmTextNewsTitleFromContent:(NSInteger)contentid{
    NSString *tempReturnStr;
    if([self gmNetWorkCollection]){
    NSString *str = [NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetNewsByContentId?contentid=%d",contentid];
    NSURL *url = [NSURL URLWithString:str];
    
    NSData *newsData = [NSData dataWithContentsOfURL:url];
    
    
    //JSON解析
    NSError *error = [[NSError alloc] init];
    NSDictionary *newsDictOne = [NSJSONSerialization JSONObjectWithData:newsData options:NSJSONReadingMutableContainers error:&error];
    
       //errorMsg等于success时才执行解析操作
    if([[newsDictOne objectForKey:@"errorMsg"] isEqualToString:@"success"]){
        NSDictionary *tempOne = [newsDictOne objectForKey:@"data"];
       
                tempReturnStr = [tempOne objectForKey:@"Title"];
    
    }
    }
    return tempReturnStr;

}
//存档
+(void)gmSaveDataShared{

    

    //存储数据
        NSMutableArray *collectArr = [[NSMutableArray alloc] init];
        [collectArr addObject:sharedNewsCollection];
        [collectArr addObject:sharedCommentCollection];
        [collectArr addObject:sharedPictureCollection];
    
        NSData *collectData = [NSKeyedArchiver archivedDataWithRootObject:collectArr];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm createFileAtPath:collectPath_save contents:collectData attributes:Nil];

 
}
//从沙盒获取数据
+(NSMutableArray *)gmAcquireCollectDataPath:(NSString *)strPath{
    
    NSData *collectData = [NSData dataWithContentsOfFile:strPath];
    NSMutableArray *collectArr = [NSKeyedUnarchiver unarchiveObjectWithData:collectData];
    
    if([collectArr count]){
        sharedNewsCollection = [collectArr objectAtIndex:0];
        sharedCommentCollection = [collectArr objectAtIndex:1];
        sharedPictureCollection = [collectArr objectAtIndex:2];
    }
    return collectArr;
}
@end
