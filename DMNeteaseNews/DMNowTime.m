//
//  DMNowTime.m
//  DMNeteaseNews
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMNowTime.h"

@implementation DMNowTime
///获得时间
+(NSString *)gmAcquireNowTime{
    //得到当前时间
    NSDate *timeNow = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"YYYY-MM-dd"];//得到年月日
    NSString *strDate = [dateFormater stringFromDate:timeNow];
//    NSLog(@"%@",strDate);
    
    //得到年月日，时分秒
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:timeNow];
//    NSString *timeCur = [NSString stringWithFormat:@"%d-%d-%d %02d:%02d:%02d",[components year],[components month],[components day],[components hour],[components minute],[components second]];
    NSString *timeCur = [NSString stringWithFormat:@"%@ %02d:%02d:%02d",strDate,[components hour],[components minute],[components second]];
//    NSLog(@"%@",timeCur);

    return timeCur;
}
@end
