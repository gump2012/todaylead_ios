//
//  getProRecommand.m
//  todayios
//
//  Created by gump on 9/9/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "getProRecommand.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "proRecommandDataSource.h"

@implementation getProRecommand

-(void)request:(int)ipid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:
                                       @"%@/?m=shop&a=getRecommandProductList&product_id=%d",[self getDoMain],ipid]];
    LOG_Test(@"%@ pid:%d",url,ipid);
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
        [[proRecommandDataSource shareInstance].dataDic removeAllObjects];
        [[proRecommandDataSource shareInstance].dataDic setDictionary:jsondic];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyProductRecommand object:nil];
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
