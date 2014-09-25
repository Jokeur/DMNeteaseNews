//
//  DMJSONCreate.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-5.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMJSONCreate.h"

@implementation DMJSONCreate
//网络监测
+(BOOL)gmNetWorkJsonCreate{
    DMNetWork *netWork = [[DMNetWork alloc] init];
    
    return [netWork gmNetWork];
    
}
//User生成JSON格式
+(NSString *)gmJSONWithModel:(DMUserModel * )theModel{
    NSString *returnStr = nil;
    
    if([self gmNetWorkJsonCreate]){
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                 theModel.ymPassword,@"Password",
                                 theModel.ymNickName,@"NickName",
                                 theModel.ymStfCode,@"StfCode",
                                 theModel.ymUserName,@"UserName",
                                 theModel.ymGender,@"Gender",
                                 theModel.ymDeptId,@"DeptId",
                                 theModel.ymNativePlace,@"NativePlace",
                                 theModel.ymPosId,@"PosId",
                                 theModel.ymSuperId,@"SuperId",
                                 theModel.ymEducation,@"Education",
                                 theModel.ymWorkExp,@"WorkExp",
                                 theModel.ymBornDate,@"BornDate",
                                 theModel.ymJoinDate,@"JoinDate",
                                 theModel.ymCountryId,@"CountryId",
                                 theModel.ymQQ,@"QQ",
                                 theModel.ymBranchId,@"BranchId",
                                 theModel.ymMail,@"Mail",
                                 theModel.ymTelePhone,@"TelePhone",
                                 theModel.ymTelePhoneExt,@"TelePhoneExt",
                                 theModel.ymMobilePhone,@"MobilePhone",
                                 theModel.ymSafeQuestion,@"SafeQuestion",
                                 theModel.ymSafeAnswer,@"SafeAnswer",
                                 theModel.ymZip,@"Zip",
                                 theModel.ymAddress,@"Address",
                                 theModel.ymRemark,@"Remark",
                                 theModel.ymStatusId,@"StatusId",
                                 theModel.ymPhoto,@"Photo",
                                 theModel.ymIdentityCard,@"IdentityCard",
                                 theModel.ymOnlineStatusId,@"OnlineStatusId",
                                 theModel.ymIP,@"IP",
                                 theModel.ymCityId,@"CityId",
                                 theModel.ymTownId,@"TownId",
                                 theModel.ymPowerId,@"PowerId",
                                 theModel.ymPowerStartDate,@"PowerStartDate",
                                 theModel.ymPowerEndDate,@"PowerEndDate",
                                 nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    returnStr = [writer stringWithObject:dict];
    }
    return returnStr;
}
//发表评论生成JSON格式
+(NSString *)gmJSONAppearObserve:(DMAppearObserveModel *)theModel{
    NSString *returnStrO = nil;
    if([self gmNetWorkJsonCreate]){
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:theModel.ymContentid,@"contentid",
                                 theModel.ymStfId,@"StfId",
                                 theModel.ymPublished,@"Published",
                                 theModel.ymContent,@"content",
                                 nil];

    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    returnStrO = [writer stringWithObject:dict];
    }
    return returnStrO;
}
//爆料
+(NSString *)gmJSONPictureNewsWithModel:(DMPictureNewsModel *)theModel{
    NSString *returnStrP = nil;
    if([self gmNetWorkJsonCreate]){
    //图组，图片属性
    NSMutableArray *tempImageArr = [[NSMutableArray alloc] init];
    for(DMImageInfoModel *tempImageModel in theModel.ymImageList){
        NSMutableDictionary *dictImageList = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                              [NSString stringWithFormat:@"%d",tempImageModel.ymContentid],@"Comtentid",
                                              tempImageModel.ymDescription,@"description",
                                              tempImageModel.ymFrURL,@"FrURL",
                                              tempImageModel.ymPublished,@"Published"
                                              , nil];
        [tempImageArr addObject:dictImageList];
    }
    //爆料新闻
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                 theModel.ymTitle,@"title",
                                 theModel.ymModelid,@"modelid",
                                 theModel.ymCatid, @"catid",
                                 theModel.ymDescription,@"description",
                                 theModel.ymSource,@"Source",
                                 theModel.ymContent, @"Content",
                                 theModel.ymVideo, @"Video",
                                 theModel.ymPlaytime,@"Playtime",
                                 theModel.ymTopicid, @"topicid",
                                 theModel.ymPublished, @"published",
                                 theModel.ymThumb,@"thumb",
                                 theModel.ymComments,@"comments",
                                 tempImageArr,@"Imagelist",
                                 nil];

    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    returnStrP = [writer stringWithObject:dict];
    }
    return returnStrP;
}
@end
