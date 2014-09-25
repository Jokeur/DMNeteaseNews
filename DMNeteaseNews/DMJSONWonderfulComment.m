//
//  DMJSONWonderfulComment.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-8.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMJSONWonderfulComment.h"

@implementation DMJSONWonderfulComment
static NSMutableArray *sharedJSONNewsWonderful;//精彩跟帖
static NSMutableArray *sharedJSONNewsToday;//今日排行
static NSMutableDictionary *sharedJSONNewsPicture;//存储图片新闻，新闻ID
static NSMutableArray *sharedNewsBoardTitle;//传递新闻版块标题名
static NSMutableArray *sharedMyJoinComment;//我参与的评论
static NSMutableArray *sharedCallMeComment;//回复我的评论

//单例初始化
+(void)sharedCommentMethod{


}
//网络监测
+(BOOL)gmNetWorkJsonComment{
    DMNetWork *netWork = [[DMNetWork alloc] init];
    
    return [netWork gmNetWork];
    
}
//精彩跟帖
+(NSMutableArray *)gmSharedJSONNewsWonderful{

    return sharedJSONNewsWonderful;
}
//今日排行
+(NSMutableArray *)gmSharedJSONNewsToday{

    return sharedJSONNewsToday;
}
//我参与的评论
+(NSMutableArray *)gmSharedMyJoinComment{
    
    return sharedMyJoinComment;
}
//回复我的评论
+(NSMutableArray *)gmSharedCallMeComment{
    
    return sharedCallMeComment;
}
//我参与的评论
+(void)gmSharedMyJoinNIL{
    sharedMyJoinComment = nil;
}
//回复我的评论
+(void)gmSharedCallMeNIL{
    sharedCallMeComment = nil;
}
//传递新闻版块标题名
+(void)gmNewsBoardTitleChangeValue:(NSMutableArray *)theArr{
    sharedNewsBoardTitle = theArr;

}
//传递新闻版块标题名
+(NSMutableArray *)gmAcquireNewsBoardTitleValue{
    return sharedNewsBoardTitle;
}

//请求新闻
+(void)gmRequestNewsFromURL:(NSURL*)url{
    if([self gmNetWorkJsonComment]){
    
    if(!sharedJSONNewsWonderful){
        sharedJSONNewsWonderful = [[NSMutableArray alloc] init];
    }
    if(!sharedJSONNewsToday){
        sharedJSONNewsToday = [[NSMutableArray alloc] init];
    }
    if(!sharedMyJoinComment){
        sharedMyJoinComment = [[NSMutableArray alloc] init];
    }
    if(!sharedCallMeComment){
        sharedCallMeComment = [[NSMutableArray alloc] init];
    }
    if(!sharedJSONNewsPicture){
        sharedJSONNewsPicture = [[NSMutableDictionary alloc] init];
    }
    
    NSData *newsData = [NSData dataWithContentsOfURL:url];
    //JSON解析
    NSError *error = [[NSError alloc] init];
    NSDictionary *newsDictOne = [NSJSONSerialization JSONObjectWithData:newsData options:NSJSONReadingMutableContainers error:&error];
 

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
                    
                    ////我参与的跟帖、、、、、、、、、、、
                    
                    NSString *strPath =[NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetDiscussRecordListByContentid?contentid=%d",[[newsDictThree objectForKey:@"ContentId"] intValue]];
                    NSURL *urlPath = [NSURL URLWithString:strPath];
                    //评论列表
                    NSMutableArray *commentArr = [DMJSONParse gmJSONCommentList:urlPath];
                    for(int d = 0;d < [commentArr count];d ++){
                        DMCommentModel *tempModel = [commentArr objectAtIndex:d];
                        //若与本用户的ID相同则取出
                        if([[NSString stringWithFormat:@"%d",tempModel.ymStfId] isEqualToString:[DMJSONParse gmPassValue:@""]] ){
                            
                            //判断是否是第一次存储
                            BOOL result = YES;
                            for(int d = 0; d < [sharedMyJoinComment count];d ++){
                                DMNewsDataModel *tempddd = [sharedMyJoinComment objectAtIndex:d];
                                
                                if([tempddd.ymContentid intValue] == [newsDataModelJOSN.ymContentid intValue]){
                                    result = NO;
                                }
                            }
                            if(result){
                                [sharedMyJoinComment addObject:newsDataModelJOSN];
                           
                            
                            }
                        }
                    }
                    //我爆料的新闻、、、、、、、、、、、、、、、、、、、、、

                    if([newsDataModelJOSN.ymSource intValue] == [[DMJSONParse gmPassValue:@""] intValue] && ![[DMJSONParse gmPassValue:@""] isEqualToString:@""]){
                        //判断是否是第一次存储
                        BOOL result = YES;
                        for(int d = 0; d < [sharedCallMeComment count];d ++){
                            DMNewsDataModel *tempddd = [sharedCallMeComment objectAtIndex:d];
                            
                            if([tempddd.ymTopicid intValue] == [newsDataModelJOSN.ymTopicid intValue]){
                                result = NO;
                            }
                        }
                        if(result){
                         
                            [sharedCallMeComment addObject:newsDataModelJOSN];
                            
                        }
                    
                    }
                    
                    
                    
                     /////////////////////////////////////////
                    //大于10条评论的新闻这里才收集
                    if([[newsDictThree objectForKey:@"Comments"] intValue] > 1){
                        NSInteger commentsNum = [[newsDictThree objectForKey:@"Comments"] intValue];
                        
                        NSString *newsDate = [newsDictThree objectForKey:@"Published"];
                        NSString *todayDate = [DMNowTime gmAcquireNowTime];
                    
                        NSString *strNews = [newsDate substringToIndex:10];
                        NSString *strToday = [todayDate substringToIndex:10];
                        //而今日发表的新闻，这里收集
                        if([strNews isEqualToString:strToday]){
                           
                            BOOL result = YES;
                            NSInteger tempNum = [sharedJSONNewsToday count];
                            if(tempNum != 0){
                                for(int i = 0;i < tempNum;i ++){
                                    if([[[sharedJSONNewsToday objectAtIndex:i] ymComments] intValue] < commentsNum){
                                        
                                        [sharedJSONNewsToday insertObject:newsDataModelJOSN atIndex:i];
                                        result = NO;
                                    }
                                    if(!result){
                                        break;//若插入一次后就跳出循环
                                    }
                                }
                            }
                            if(result){
                                [sharedJSONNewsToday addObject:newsDataModelJOSN];
                            } 
                        }else{

                                [sharedJSONNewsWonderful addObject:newsDataModelJOSN];
                        }
                    }
                    ////////////////////////
                    //存储图片新闻iD
                    if([[newsDictThree objectForKey:@"Modelid"] intValue] == 2){
                        
                        //存储图片新闻 数组
                        NSMutableArray *pictureArr = [[NSMutableArray alloc] init];
                        
                        NSString *catidKey = [newsDictThree objectForKey:@"Catid"];
                        NSString *tempContenid = [newsDictThree objectForKey:@"ContentId"];
   
                        
                        NSMutableArray *tempMarrPic = (NSMutableArray *)[sharedJSONNewsPicture objectForKey:[NSString stringWithFormat:@"%d",[catidKey intValue]]];
                        if(tempMarrPic){
                            [tempMarrPic addObject:tempContenid];
                            [sharedJSONNewsPicture setObject:tempMarrPic forKey:[NSString stringWithFormat:@"%d",[catidKey intValue]]];
                        }else{
                            [pictureArr addObject:tempContenid];
                            [sharedJSONNewsPicture setObject:pictureArr forKey:[NSString stringWithFormat:@"%d",[catidKey intValue]]];
                        
                        }
                    
                    }
                
                    //程序到了这里，相当于数据已经请求回来了
                }else{
                    //若TempTwo是数组
                }
            }
        }else{
            //tempOne若是字典，进入此部分
        }
    }

    }
    //
}
//图片新闻，新闻ID
+(NSMutableDictionary *)gmSharedJSONNewsPicture{
    return sharedJSONNewsPicture;

}

//判断TextView中文本高度
+(float)gmTextHightFromWidth:(float)width andFontSize:(float)size andString:(NSString *)string{
    UILabel *labTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, width,60)];
    [labTitle setNumberOfLines:0];
    [labTitle setText:string];
    UIFont *font = [UIFont systemFontOfSize:size];
    labTitle.font = font;
    labTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    //获取当前文本属性
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    //文本需要的Size限制宽度
    CGSize sizeOne = [labTitle.text boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return sizeOne.height;
}

@end
