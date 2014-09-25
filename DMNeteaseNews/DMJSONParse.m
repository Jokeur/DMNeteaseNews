//
//  DMJSONParse.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMJSONParse.h"

@implementation DMJSONParse
static DMJSONParse *sharedJSONParse;
static NSMutableDictionary *sharedJSONNewsDict;//文本新闻
static NSMutableDictionary *sharedJSONPictureDict;//图片新闻
static NSMutableDictionary *sharedJSONImageInfoDict;//图片属性；
static NSString *sharedJSONStfId;//用户ID

+(id)sharedJSONParseMethod{
    if(!sharedJSONParse){
        sharedJSONParse = [[DMJSONParse alloc] init];
        sharedJSONPictureDict = [[NSMutableDictionary alloc] init];
        sharedJSONNewsDict = [[NSMutableDictionary alloc] init];
        sharedJSONImageInfoDict = [[NSMutableDictionary alloc] init];
        sharedJSONStfId = [[NSString alloc] init];
        sharedJSONStfId = @"";
    }
    
    return sharedJSONParse;
}
//传递数据
+(NSString *)gmPassValue:(NSString *)StfId{
    if([StfId isEqualToString:@""]){
  
    }else{
       sharedJSONStfId = StfId;
    }
    return sharedJSONStfId;
}
//清空登录数据记录
+(void)gmDismissPassValue{
    sharedJSONStfId = @"";
}
//网络监测
+(BOOL)gmNetWorkAction{
    DMNetWork *netWork = [[DMNetWork alloc] init];
 
    return [netWork gmNetWork];
 
}


//请求新闻
+(NSMutableDictionary *)gmRequestNewsFromCatid:(NSInteger)catid andURL:(NSURL*)url{
    if([self gmNetWorkAction]){
        //创建队列
        dispatch_queue_t curQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(curQueue, ^{

        
        NSData *newsData = [NSData dataWithContentsOfURL:url];
    
        //JSON解析
        NSError *error = [[NSError alloc] init];
        NSDictionary *newsDictOne = [NSJSONSerialization JSONObjectWithData:newsData options:NSJSONReadingMutableContainers error:&error];
        
        //将Model存储到数组中去
        NSMutableArray *newsDataModelArr = [[NSMutableArray alloc] init];
        
        //errorMsg等于success时才执行解析操作
        if([[newsDictOne objectForKey:@"errorMsg"] isEqualToString:@"success"]){
            id tempOne = [newsDictOne objectForKey:@"data"];
            Class classType = [tempOne class];
            
            //tempOne若是数组，进入此部分
            if([classType isSubclassOfClass:[NSArray class]]){
                NSArray *newsArrTwo = (NSArray *)tempOne;
                for(int i = 0;i < [newsArrTwo count]; i ++){
                    id tempTwo = [newsArrTwo objectAtIndex:i];
                    
                    //若TempTwo是字典
                    Class classTypeTwo = [tempTwo class];
                    if([classTypeTwo isSubclassOfClass:[NSDictionary class]]){
                        NSDictionary *newsDictThree = (NSDictionary *)tempTwo;
                        
                        //解析到Model中来
                         DMNewsDataModel *newsDataModelJOSN  = [[DMNewsDataModel alloc] init];
                        
                        NSString *thumbStr = [NSString stringWithFormat:@"http://192.168.0.43:8080/UpLoad/%@",[newsDictThree objectForKey:@"Thumb"]];
        
                [newsDataModelJOSN setContentid:[newsDictThree objectForKey:@"ContentId"]
                                                  andTitle:[newsDictThree objectForKey:@"Title"]
                                                andModelid:[newsDictThree objectForKey:@"Modelid"]
                                                  andCatid:[newsDictThree objectForKey:@"Catid"]
                                              andPublished:[newsDictThree objectForKey:@"Published"]
                                                 andSource:[newsDictThree objectForKey:@"Source"]
                                            andDescription:[newsDictThree objectForKey:@"Description"]
                                                andContent:[newsDictThree objectForKey:@"Content"]
                                                  andThumb:thumbStr
                                                  andVideo:[newsDictThree objectForKey:@"Video"]
                                               andPlaytime:[newsDictThree objectForKey:@"Playtime"]
                                                andTopicid:[newsDictThree objectForKey:@"Topicid"]
                                               andComments:[newsDictThree objectForKey:@"Comments"]];
             
                        
                        if([newsDictThree objectForKey:@"Video"]){
                            NSString *videoStr = [NSString stringWithFormat:@"http://192.168.0.43:8080/Video/%@",[newsDictThree objectForKey:@"Video"]];
                            newsDataModelJOSN.ymVideo = videoStr;
                        
                        }
                        
                        
                        
                        [newsDataModelArr addObject:newsDataModelJOSN];
                        
                        //程序到了这里，相当于数据已经请求回来了
                    }else{
                        //若TempTwo是数组
                    }
                }
            }else{
                //tempOne若是字典，进入此部分
            }
        }
        //使用字典，存储一个分类的所有新闻集合，即上面的数组
        NSMutableArray *beforeArr = [sharedJSONNewsDict objectForKey:[ NSString stringWithFormat:@"%d",catid]];
        
        if(beforeArr){
            NSArray *afterArr = [beforeArr arrayByAddingObjectsFromArray:newsDataModelArr];
            [sharedJSONNewsDict setObject:afterArr forKey:[NSString stringWithFormat:@"%d",catid]];
        }else{
            [sharedJSONNewsDict setObject:newsDataModelArr forKey:[NSString stringWithFormat:@"%d",catid]];
        }
            
            
        });
   
  }
    return sharedJSONNewsDict;
}
//图片解析
+(UIImage *)gmRequestImageNews:(NSURL*)url{
    UIImage *img ;
    if([self gmNetWorkAction]){
        NSData *dataThumb = [NSData dataWithContentsOfURL:url];
        img = [UIImage imageWithData:dataThumb];
    }
    return img;
    
}
+(NSMutableDictionary *)gmJSONPictureParse:(NSURL *)url andKey:(NSString *)key{
  if([self gmNetWorkAction]){
    
    //图组新闻
    DMPictureNewsModel *ymPictureNewsModel = [[DMPictureNewsModel alloc] init];
   
    NSData *tempData = [NSData dataWithContentsOfURL:url];
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    
    //JSON解析
    NSError *error = [[NSError alloc] init];
    NSDictionary *newsDictOne = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableContainers error:&error];
    
    NSDictionary *newsDictTwo = [newsDictOne objectForKey:@"data"];
      NSArray *temp = [newsDictTwo objectForKey:@"Imagelist"];
    
    if(temp){
        for(NSMutableDictionary *dict in temp){
            DMImageInfoModel *imgModel = [[DMImageInfoModel alloc] init];
             NSString *FrURLStr = [NSString stringWithFormat:@"http://192.168.0.43:8080/UpLoad/%@",[dict objectForKey:@"FrURL"]];
            [imgModel gmImageInfoModelContentid:[[dict objectForKey:@"ContentId"] intValue]
                                 andDescription:[dict objectForKey:@"Description"]
                                        andFrid:[[dict objectForKey:@"Frid"] intValue]
                                       andFrURL:FrURLStr
                                   andPublished:[dict objectForKey:@"Published"]];
            
            [tempArr addObject:imgModel];
        }
    }
    
    ymPictureNewsModel.ymImageList = tempArr;
    [ymPictureNewsModel setContentid:[newsDictTwo objectForKey:@"ContentId"]
                                 andTitle:[newsDictTwo objectForKey:@"Title"]
                               andModelid:[newsDictTwo objectForKey:@"Modelid"]
                                 andCatid:[newsDictTwo objectForKey:@"Catid"]
                             andPublished:[newsDictTwo objectForKey:@"Published"]
                                andSource:[newsDictTwo objectForKey:@"Source"]
                           andDescription:[newsDictTwo objectForKey:@"Description"]
                               andContent:[newsDictTwo objectForKey:@"Content"]
                                 andThumb:[newsDictTwo objectForKey:@"Thumb"]
                                 andVideo:[newsDictTwo objectForKey:@"Video"]
                              andPlaytime:[newsDictTwo objectForKey:@"Playtime"]
                               andTopicid:[newsDictTwo objectForKey:@"Topicid"]
                              andComments:[newsDictTwo objectForKey:@"Comments"]];
   
    
    if([newsDictTwo objectForKey:@"Video"]){
        NSString *videoStr = [NSString stringWithFormat:@"http://192.168.0.43:8080/Video/%@",[newsDictTwo objectForKey:@"Video"]];
        ymPictureNewsModel.ymVideo = videoStr;
        
    }
    //图片新闻存储到单例
 
    [sharedJSONPictureDict setObject:ymPictureNewsModel forKey:key];
  
  }
    return sharedJSONPictureDict;
}

//获取当前新闻的评论列表
+(NSMutableArray *)gmJSONCommentList:(NSURL *)url{
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
   if([self gmNetWorkAction]){
    
    NSData *tempData = [NSData dataWithContentsOfURL:url];
    //JSON解析
    NSError *error = [[NSError alloc] init];
    NSDictionary *newsDictOne = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableContainers error:&error];
    
    if([[newsDictOne objectForKey:@"errorMsg"] isEqualToString:@"success"]){
    
    NSArray *newsArrOne = [newsDictOne objectForKey:@"data"];
   
    
    for(NSDictionary *tempDict in newsArrOne){
        DMCommentModel *tempCommentModel = [[DMCommentModel alloc] init];
        
        [tempCommentModel gmSetCommentModelValue:[tempDict objectForKey:@"IP"]
                                     andNickName:[tempDict objectForKey:@"NickName"]
                                          andLon:[tempDict objectForKey:@"Longitude"]
                                          andLat:[tempDict objectForKey:@"Latitude"]
                                         andDrid:[[tempDict objectForKey:@"DrId"] intValue]
                                        andStfid:[[tempDict objectForKey:@"StfId"] intValue]
                                    andContentId:[[tempDict objectForKey:@"ContentId"] intValue]
                                    andPublished:[tempDict objectForKey:@"Published"]
                                      andContent:[tempDict objectForKey:@"Content"]];
        
        [mArr addObject:tempCommentModel];
    }
    }
   }
    return mArr;

}
//登陆返回数据
+(id)gmUserLanding:(NSURL *)url{
    DMUserModel *tempUserM;
    if([self gmNetWorkAction]){
    NSData *tempData = [NSData dataWithContentsOfURL:url];
    //JSON解析
    NSError *error = [[NSError alloc] init];
    NSDictionary *newsDictOne = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableContainers error:&error];
    
    if([[newsDictOne objectForKey:@"errorMsg"] isEqualToString:@"success"]){
       
         NSDictionary *newsDictTwo = [newsDictOne objectForKey:@"data"];
        tempUserM = [[DMUserModel alloc] initMail:[newsDictTwo objectForKey:@"Mail"] andPassword:[newsDictTwo objectForKey:@"Password"]];
        tempUserM.ymStfId = [newsDictTwo objectForKey:@"StfId"];
    }
    }
    return tempUserM;
}


@end
