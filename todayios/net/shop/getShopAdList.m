//
//  getShopAdList.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "getShopAdList.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "shopadDataSource.h"

@implementation getShopAdList

-(void)request{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@:%@/?m=shop&a=getAdvertList",MAIN_DOMAIN,MAIN_PORT]];
    LOG_Test(@"%@",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
}

#pragma mark ----------http delegate----------------
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *jsondic = [responseString objectFromJSONString];
    if (jsondic) {
        [[shopadDataSource shareInstance].shopadDic removeAllObjects];
        [[shopadDataSource shareInstance].shopadDic setDictionary:jsondic];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyRefreshShopAd object:nil];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    if (error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyHttpRequestError object:nil];
        LOG_Error(@"%@",error);
    }
}

@end
