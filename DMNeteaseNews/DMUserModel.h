//  用户类
//  DMUserModel.h
//  DMNeteaseNews
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMUserModel : NSObject<NSCoding>
@property (strong, nonatomic)NSString *ymStfId;//用户ID
@property (strong, nonatomic)NSString *ymPassword;//密码
@property (strong, nonatomic)NSString *ymNickName;//昵称
@property (strong, nonatomic)NSString *ymStfCode;//内部编号
@property (strong, nonatomic)NSString *ymUserName; //姓名
@property (strong, nonatomic)NSString *ymGender;//性别：0-女，1-男
@property (strong, nonatomic)NSString *ymDeptId; //部门 Id
@property (strong, nonatomic)NSString *ymNativePlace;//籍贯
@property (strong, nonatomic)NSString *ymPosId;//岗位 Id
@property (strong, nonatomic)NSString *ymSuperId;//上级（用户）Id
@property (strong, nonatomic)NSString *ymEducation;//教育程度
@property (strong, nonatomic)NSString *ymWorkExp;//工作经历
@property (strong, nonatomic)NSString *ymBornDate; //出生日期
@property (strong, nonatomic)NSString *ymJoinDate; //入职日期
@property (strong, nonatomic)NSString *ymCountryId;//所属国家
@property (strong, nonatomic)NSString *ymQQ;//QQ
@property (strong, nonatomic)NSString *ymBranchId;//机构id
@property (strong, nonatomic)NSString *ymMail;//电子邮箱
@property (strong, nonatomic)NSString *ymTelePhone; //座机
@property (strong, nonatomic)NSString *ymTelePhoneExt; //分机
@property (strong, nonatomic)NSString *ymMobilePhone; //手机
@property (strong, nonatomic)NSString *ymSafeQuestion;//密保问题
@property (strong, nonatomic)NSString *ymSafeAnswer;//密保答案
@property (strong, nonatomic)NSString *ymZip;//邮编
@property (strong, nonatomic)NSString *ymAddress; //地址
@property (strong, nonatomic)NSString *ymRemark; //备注
@property (strong, nonatomic)NSString *ymStatusId;//状态10-在职，11-离职，12-求职，13-待业
@property (strong, nonatomic)NSString *ymPhoto; //头像
@property (strong, nonatomic)NSString *ymIdentityCard;//身份证
@property (strong, nonatomic)NSString *ymOnlineStatusId; //在线状态
@property (strong, nonatomic)NSString *ymIP;// IPV4或IPV6地址
@property (strong, nonatomic)NSString *ymCityId;//所属省市Id
@property (strong, nonatomic)NSString *ymTownId;//所属县区Id
@property (strong, nonatomic)NSString *ymPowerId;//所属授权Id
@property (strong, nonatomic)NSString *ymPowerStartDate;//授权生效时间
@property (strong, nonatomic)NSString *ymPowerEndDate;//授权终结时间


//初始化
-(id)initMail:(NSString*)mail andPassword:(NSString *)password;

@end
