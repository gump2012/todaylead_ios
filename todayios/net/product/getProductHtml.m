//
//  getProductHtml.m
//  todayios
//
//  Created by gump on 9/5/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "getProductHtml.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "proHtmlDataSource.h"

@implementation getProductHtml

-(void)request:(int)ipid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:
                                       @"%@:%@/?m=product&a=getProductIntroHtml&product_id=%d",MAIN_DOMAIN,MAIN_PORT,ipid]];
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
        [[proHtmlDataSource shareInstance].dataDic removeAllObjects];
        [[proHtmlDataSource shareInstance].dataDic setDictionary:jsondic];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyProductHtml object:nil];
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
