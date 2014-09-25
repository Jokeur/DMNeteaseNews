//
//  DMGroupPicture.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-10.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMGroupPicture.h"

@implementation DMGroupPicture
//网络监测
+(BOOL)gmNetWorkPicture{
    DMNetWork *netWork = [[DMNetWork alloc] init];
    
    return [netWork gmNetWork];
    
}


//新闻数据准备，新闻ID
+(void)gmPrepareNewsDataCatid:(NSInteger)catid andPageSize:(NSInteger)pageSize andPage:(NSInteger)page{
    if([self gmNetWorkPicture]){
    
    //数据准备
    for(int i = 1; i < catid; i ++){
        for(int j = 1; j < page; j ++){
            NSString *urlInput = [NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetNewsListByCatidAndPagesizeAndPage?catid=%d&pagesize=%d&page=%d",i,pageSize,j];
            
            NSURL *urlNews = [NSURL URLWithString:urlInput];
            [DMJSONWonderfulComment gmRequestNewsFromURL:urlNews];
        }
    }
    }
}

//准备数据-图片
+(NSMutableArray *)gmPreparePictureData:(NSInteger)contentid{
    //返回数组，里面存储着UIImage
    NSMutableArray *tempReturnMarr = [[NSMutableArray alloc] init];
 if([self gmNetWorkPicture]){

    NSString *str = [NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetImageNewsByContentId?contentid=%d",contentid ];
    NSURL *tempURL = [NSURL URLWithString:str];
    
    NSMutableDictionary *dictImg = [DMJSONParse gmJSONPictureParse:tempURL andKey:[NSString stringWithFormat:@"%d",contentid]];
    DMPictureNewsModel *PictureNewsModel = [dictImg objectForKey:[NSString stringWithFormat:@"%d",contentid]];
    
    NSMutableArray *tempImageModelArr = PictureNewsModel.ymImageList;
    
    for(int i = 0;i< [tempImageModelArr count]; i++){
        DMImageInfoModel *tempImageModel  = [tempImageModelArr objectAtIndex:i];
        NSURL *url = [NSURL URLWithString:tempImageModel.ymFrURL];
        
        UIImage *image = [DMJSONParse gmRequestImageNews:url];
        
        if(image){
            [tempReturnMarr addObject:image];
        }
        
        
    }
//    NSMutableArray *returnArr = [[NSMutableArray alloc] init];
//    [returnArr addObject:PictureNewsModel];
//    [returnArr addObject:tempReturnMarr];
 }
    return tempReturnMarr;
}
//准备数据-图组Model
+(DMPictureNewsModel *)gmPictureNewsData:(NSInteger)contentid{
    DMPictureNewsModel *PictureNewsModel;
    if([self gmNetWorkPicture]){
        
        NSString *str = [NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetImageNewsByContentId?contentid=%d",contentid ];
        NSURL *tempURL = [NSURL URLWithString:str];
        
        NSMutableDictionary *dictImg = [DMJSONParse gmJSONPictureParse:tempURL andKey:[NSString stringWithFormat:@"%d",contentid]];
        
        PictureNewsModel = [dictImg objectForKey:[NSString stringWithFormat:@"%d",contentid]];
        
        
    }
    return PictureNewsModel;
}


@end
