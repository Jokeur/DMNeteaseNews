//
//  DMUserModel.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMUserModel.h"

@implementation DMUserModel
@synthesize ymStfId = _ymStfId;//用户ID
@synthesize ymPassword = _ymPassword;//密码
@synthesize ymNickName = _ymNickName;//昵称
@synthesize ymStfCode = _ymStfCode;//内部编号
@synthesize ymUserName = _ymUserName; //姓名
@synthesize ymGender = _ymGender;//性别：0-女，1-男
@synthesize ymDeptId = _ymDeptId; //部门 Id
@synthesize ymNativePlace = _ymNativePlace;//籍贯
@synthesize ymPosId = _ymPosId;//岗位 Id
@synthesize ymSuperId = _ymSuperId;//上级（用户）Id
@synthesize ymEducation = _ymEducation;//教育程度
@synthesize ymWorkExp = _ymWorkExp;//工作经历
@synthesize ymBornDate = _ymBornDate; //出生日期
@synthesize ymJoinDate = _ymJoinDate; //入职日期
@synthesize ymCountryId = _ymCountryId;//所属国家
@synthesize ymQQ = _ymQQ;//QQ
@synthesize ymBranchId = _ymBranchId;//机构id
@synthesize ymMail = _ymMail;//电子邮箱
@synthesize ymTelePhone = _ymTelePhone; //座机
@synthesize ymTelePhoneExt = _ymTelePhoneExt; //分机
@synthesize ymMobilePhone = _ymMobilePhone; //手机
@synthesize ymSafeQuestion = _ymSafeQuestion;//密保问题
@synthesize ymSafeAnswer = _ymSafeAnswer;//密保答案
@synthesize ymZip = _ymZip;//邮编
@synthesize ymAddress = _ymAddress; //地址
@synthesize ymRemark = _ymRemark; //备注
@synthesize ymStatusId = _ymStatusId;//状态10-在职，11-离职，12-求职，13-待业
@synthesize ymPhoto = _ymPhoto; //头像
@synthesize ymIdentityCard = _ymIdentityCard;//身份证
@synthesize ymOnlineStatusId = _ymOnlineStatusId; //在线状态
@synthesize ymIP = _ymIP;// IPV4或IPV6地址
@synthesize ymCityId = _ymCityId;//所属省市Id
@synthesize ymTownId = _ymTownId;//所属县区Id
@synthesize ymPowerId = _ymPowerId;//所属授权Id
@synthesize ymPowerStartDate = _ymPowerStartDate;//授权生效时间
@synthesize ymPowerEndDate = _ymPowerEndDate;//授权终结时间

//初始化
-(id)initMail:(NSString*)mail andPassword:(NSString *)password{
    self = [super init];
    if(self){
        _ymStfId = @"0";
    _ymPassword = password;
    _ymNickName = @"神游";
    _ymStfCode = @"sb110";
    _ymUserName = @"张三";
    _ymGender = @"1";
    _ymDeptId = @"9";
    _ymNativePlace = @"重庆渝中";
    _ymPosId = @"12";
    _ymSuperId = @"100120";
    _ymEducation = @"大学本科";
    _ymWorkExp = @"2013 雷电科技";
    _ymBornDate = @"1991-3-4 15:50:50";
    _ymJoinDate = @"2012-9-20 15:50:50";
    _ymCountryId = @"86";
    _ymQQ = @"456654789";
    _ymBranchId = @"1005";
    _ymMail = mail;
    _ymTelePhone = @"023322321316";
    _ymTelePhoneExt = @"9596";
    _ymMobilePhone = @"18503211230";
    _ymSafeQuestion = @"你好么？";
    _ymSafeAnswer = @"不好";
    _ymZip = @"405469";
    _ymAddress = @"重庆渝中";
    _ymRemark = @"很二的青年";
    _ymStatusId = @"0";
    _ymPhoto = @"20110326113942136911.jpg";
    _ymIdentityCard = @"500234111211111101";
    _ymOnlineStatusId = @"0";
    _ymIP = @"60.26.2.23";
    _ymCityId = @"5";
    _ymTownId = @"42";
    _ymPowerId = @"42";
    _ymPowerStartDate = @"2013-06-21 16:04:53.803";
    _ymPowerEndDate = @"2014-06-21 16:04:53.803";
    }
    return self;
}

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_ymStfId forKey:@"_ymStfId"];
    [aCoder encodeObject:_ymPassword forKey:@"_ymPassword"];
    [aCoder encodeObject:_ymNickName forKey:@"_ymNickName"];
    [aCoder encodeObject:_ymStfCode forKey:@"_ymStfCode"];
    [aCoder encodeObject:_ymUserName forKey:@"_ymUserName"];
    [aCoder encodeObject:_ymGender forKey:@"_ymGender"];
    [aCoder encodeObject: _ymDeptId forKey:@"_ymDeptId"];
    [aCoder encodeObject:_ymNativePlace forKey:@"_ymNativePlace"];
    [aCoder encodeObject:_ymPosId forKey:@"_ymPosId"];
    [aCoder encodeObject:_ymSuperId forKey:@"_ymSuperId"];
    [aCoder encodeObject:_ymEducation forKey:@"_ymEducation"];
    [aCoder encodeObject:_ymWorkExp forKey:@"_ymWorkExp"];
    [aCoder encodeObject:_ymBornDate forKey:@"_ymBornDate"];
    [aCoder encodeObject:_ymJoinDate forKey:@"_ymJoinDate"];
    [aCoder encodeObject:_ymCountryId forKey:@"_ymCountryId"];
    [aCoder encodeObject:_ymQQ forKey:@"_ymQQ"];
    [aCoder encodeObject:_ymBranchId forKey:@"_ymBranchId"];
    [aCoder encodeObject:_ymMail forKey:@"_ymMail"];
    [aCoder encodeObject:_ymTelePhone forKey:@"_ymTelePhone"];
    [aCoder encodeObject:_ymTelePhoneExt forKey:@"_ymTelePhoneExt"];
    [aCoder encodeObject:_ymMobilePhone forKey:@"_ymMobilePhone"];
    [aCoder encodeObject:_ymSafeQuestion forKey:@"_ymSafeQuestion"];
    [aCoder encodeObject:_ymSafeAnswer forKey:@"_ymSafeAnswer"];
    [aCoder encodeObject:_ymZip forKey:@"_ymZip"];
    [aCoder encodeObject:_ymAddress forKey:@"_ymAddress"];
    [aCoder encodeObject:_ymRemark forKey:@"_ymRemark"];
    [aCoder encodeObject:_ymStatusId forKey:@"_ymStatusId"];
    [aCoder encodeObject:_ymPhoto forKey:@"_ymPhoto"];
    [aCoder encodeObject:_ymIdentityCard forKey:@"_ymIdentityCard"];
    [aCoder encodeObject:_ymOnlineStatusId forKey:@"_ymOnlineStatusId"];
    [aCoder encodeObject:_ymIP forKey:@"_ymIP"];
    [aCoder encodeObject:_ymCityId forKey:@"_ymCityId"];
    [aCoder encodeObject:_ymTownId forKey:@"_ymTownId"];
    [aCoder encodeObject:_ymPowerId forKey:@"_ymPowerId"];
    [aCoder encodeObject:_ymPowerStartDate forKey:@"_ymPowerStartDate"];
    [aCoder encodeObject:_ymPowerEndDate forKey:@"_ymPowerEndDate"];
    
    
}

//逆归档
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        _ymStfId = [aDecoder decodeObjectForKey:@"_ymStfId"];
        _ymPassword = [aDecoder decodeObjectForKey:@"_ymPassword"];
        _ymNickName = [aDecoder decodeObjectForKey:@"_ymNickName"];
        _ymStfCode = [aDecoder decodeObjectForKey:@"_ymStfCode"];
        _ymUserName = [aDecoder decodeObjectForKey:@"_ymUserName"];
        _ymGender = [aDecoder decodeObjectForKey:@"_ymGender"];
        _ymDeptId = [aDecoder decodeObjectForKey:@"_ymDeptId"];
        _ymNativePlace = [aDecoder decodeObjectForKey:@"_ymNativePlace"];
        _ymPosId = [aDecoder decodeObjectForKey:@"_ymPosId"];
        _ymSuperId = [aDecoder decodeObjectForKey:@"_ymSuperId"];
        _ymEducation = [aDecoder decodeObjectForKey:@"_ymEducation"];
        _ymWorkExp = [aDecoder decodeObjectForKey:@"_ymWorkExp"];
        _ymBornDate = [aDecoder decodeObjectForKey:@"_ymBornDate"];
        _ymJoinDate = [aDecoder decodeObjectForKey:@"_ymJoinDate"];
        _ymCountryId = [aDecoder decodeObjectForKey:@"_ymCountryId"];
        _ymQQ = [aDecoder decodeObjectForKey:@"_ymQQ"];
        _ymBranchId = [aDecoder decodeObjectForKey:@"_ymBranchId"];
        _ymMail = [aDecoder decodeObjectForKey:@"_ymMail"];
        _ymTelePhone = [aDecoder decodeObjectForKey:@"_ymTelePhone"];
        _ymTelePhoneExt = [aDecoder decodeObjectForKey:@"_ymTelePhoneExt"];
        _ymMobilePhone = [aDecoder decodeObjectForKey:@"_ymMobilePhone"];
        _ymSafeQuestion = [aDecoder decodeObjectForKey:@"_ymSafeQuestion"];
        _ymSafeAnswer = [aDecoder decodeObjectForKey:@"_ymSafeAnswer"];
        _ymZip = [aDecoder decodeObjectForKey:@"_ymZip"];
        _ymAddress = [aDecoder decodeObjectForKey:@"_ymAddress"];
        _ymRemark = [aDecoder decodeObjectForKey:@"_ymStatusId"];
        _ymStatusId = [aDecoder decodeObjectForKey:@"_ymStatusId"];
        _ymPhoto = [aDecoder decodeObjectForKey:@"_ymPhoto"];
        _ymIdentityCard = [aDecoder decodeObjectForKey:@"_ymIdentityCard"];
        _ymOnlineStatusId = [aDecoder decodeObjectForKey:@"_ymOnlineStatusId"];
        _ymIP = [aDecoder decodeObjectForKey:@"_ymIP"];
        _ymCityId = [aDecoder decodeObjectForKey:@"_ymCityId"];
        _ymTownId = [aDecoder decodeObjectForKey:@"_ymTownId"];
        _ymPowerId = [aDecoder decodeObjectForKey:@"_ymPowerId"];
        _ymPowerStartDate = [aDecoder decodeObjectForKey:@"_ymPowerStartDate"];
        _ymPowerEndDate = [aDecoder decodeObjectForKey:@"_ymPowerEndDate"];
        
        
        
    }
    return self;
}

@end
