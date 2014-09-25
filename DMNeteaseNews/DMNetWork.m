//
//  DMNetWork.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-16.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMNetWork.h"

@implementation DMNetWork

//网络监测
-(BOOL)gmNetWork{
    

        //设置通知，网络改变时触发
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNetworkMainFrame:) name:kReachabilityChangedNotification object:nil];
        //创建Reachability对象
        self.ymNetwork = [Reachability reachabilityForInternetConnection];
        
        //开始监听网络
        [self.ymNetwork startNotifier];
    
  return [self checkNetwork];
    

}


#pragma mark - 网络检测

//判断当前是什么网络
-(BOOL)checkNetwork{
    //获得当前网络
    NetworkStatus status = [self.ymNetwork currentReachabilityStatus];
    
    self.result = YES;
    
    //没有网的时候进行提示
    if (status==kNotReachable) {
        
//        [self messageBox:@"没有网络"];
        self.result = NO;
        
    }else if (status==kReachableViaWWAN){
        self.result = NO;
        [self messageBox:@"正在使用2G/3G网络\n是否花费GPRS流量继续访问？"];
        
    }else if (status==kReachableViaWiFi){
        
        //  [self messageBox:@"正在使用wifi网络"];
        
    }
    return self.result;
}
//网络响应提示
-(void)messageBox:(NSString *)string{
    if([string isEqualToString:@"没有网络"]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"继续" otherButtonTitles:@"放弃", nil];
        [alert show];
        
    }
    
    
}

//网络改变时调用
-(void)changeNetworkMainFrame:(NSNotification *)notification{
    
    //获得当前网络
//    NetworkStatus status=[self.ymNetwork currentReachabilityStatus];
    
    [self checkNetwork];
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        
        self.result = YES;
    }
    
    
}
@end
