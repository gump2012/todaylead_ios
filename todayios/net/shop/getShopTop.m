//
//  getShopTop.m
//  todayios
//
//  Created by gump on 8/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "getShopTop.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "shopTopDataSource.h"

@implementation getShopTop

-(void)request{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@:%@/?m=shop&a=getTopicList",LATEST_DOMAIN,MAIN_PORT]];
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
        [[shopTopDataSource shareInstance].shopTopDic removeAllObjects];
        [[shopTopDataSource shareInstance].shopTopDic setDictionary:jsondic];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyRefreshShopTop object:nil];
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
