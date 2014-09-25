//
//  ggHttpFounction.m
//  iVideoMonitor
//
//  Created by gogo on 12-11-18.
//  Copyright (c) 2012年 Senlan Corporation. All rights reserved.
//

#import "ggHttpFounction.h"

@implementation ggHttpFounction

+(NSString *)HttpGet:(NSString *)urlAsString{
    NSError *error=nil;
    NSString *resault=[NSString stringWithContentsOfURL:[NSURL URLWithString:urlAsString] encoding:NSUTF8StringEncoding error:&error];
    if ([resault length] == 0 &&
        error == nil){
        resault=nil;
    }
    else if (error != nil){
        resault=nil;
    }
    return resault;
}

+(NSString *)asynHttpGet:(NSString *)urlAsString{
    NSURL *url = [NSURL URLWithString:urlAsString];
    __block NSString *resault=@"";
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         
         if ([data length] >0  &&
             error == nil){
             NSString *html = [[NSString alloc] initWithData:data
                                                    encoding:NSUTF8StringEncoding];
             resault=[html copy];
             
            // NSLog(@"HTML = %@", html);
         }
         else if ([data length] == 0 &&
                  error == nil){
             resault=@"Nothing was downloaded.";
             //NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil){
             resault=[NSString stringWithFormat:@"Error happened = %@", error];
            //NSLog(@"Error happened = %@", error);
         }
         
     }];
    return resault;
}

+(NSString *)synHttpGet:(NSString *)urlAsString{
    NSString *resault=@"";
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    
    if ([data length] > 0 &&
        error == nil){
        resault = [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];

        
    }
    else if ([data length] == 0 &&
             error == nil){
        resault=@"Nothing was downloaded.";
    }
    else if (error != nil){
        resault=[NSString stringWithFormat:@"Error happened = %@", error];
    }
     return resault;
}

+(NSString *)asynQueueHttpGet:(NSString *)urlAsString{
    __block NSString *resault=@"";
    dispatch_queue_t dispatchQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^(void) {
        
        NSURL *url = [NSURL URLWithString:urlAsString];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setTimeoutInterval:30];
        [urlRequest setHTTPMethod:@"GET"];
        
        NSURLResponse *response = nil;
        NSError *error = nil;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                             returningResponse:&response
                                                         error:&error];
        
        if ([data length] >0  &&
            error == nil){
            NSString *html = [[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding];
            resault=[html copy];
            
            //NSLog(@"HTML = %@", html);
        }
        else if ([data length] == 0 &&
                 error == nil){
            resault=@"Nothing was downloaded.";
            //NSLog(@"Nothing was downloaded.");
        }
        else if (error != nil){
            resault=[NSString stringWithFormat:@"Error happened = %@", error];
            //NSLog(@"Error happened = %@", error);
        }
    });
    return resault;
}

//http异步Post请求
+(NSString *)asynHttpPost:(NSString *)urlAsString ParamName:(NSString *)bodyParam1 ParamValue:(NSString *)bodyValue1{
    NSURL *url = [NSURL URLWithString:urlAsString];
    __block NSString *resault=@"";
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *body =bodyParam1;
    body = [body stringByAppendingString:@"="];
    body= [body stringByAppendingString:[NSString stringWithFormat:@"%@",bodyValue1]];
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         
         if ([data length] >0  &&
             error == nil){
             NSString *html = [[NSString alloc] initWithData:data
                                                    encoding:NSUTF8StringEncoding];
             resault=[html copy];
             
             // NSLog(@"HTML = %@", html);
         }
         else if ([data length] == 0 &&
                  error == nil){
             resault=@"Nothing was downloaded.";
             //NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil){
             resault=[NSString stringWithFormat:@"Error happened = %@", error];
             //NSLog(@"Error happened = %@", error);
         }
         
     }];
    return resault;

}
//http同步Post请求
+(NSString *)synHttpPost:(NSString *)urlAsString ParamName:(NSString *)bodyParam1 ParamValue:(NSString *)bodyValue1{
    NSURL *url = [NSURL URLWithString:urlAsString];
    __block NSString *resault=@"";
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *body =bodyParam1;
    body = [body stringByAppendingString:@"="];
    body= [body stringByAppendingString:[NSString stringWithFormat:@"%@",bodyValue1]];
    
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    
    if ([data length] > 0 &&
        error == nil){
        resault = [[NSString alloc] initWithData:data
                                        encoding:NSUTF8StringEncoding];
        
        
    }
    else if ([data length] == 0 &&
             error == nil){
        resault=nil;
    }
    else if (error != nil){
        resault=nil;
    }
    return resault;

}

@end
