//
//  getProductDetail.m
//  todayios
//
//  Created by gump on 8/23/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "getProductDetail.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "productDetailDataSource.h"

@implementation getProductDetail

-(void)request:(int)ipid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@:%@/?m=shop&a=getProductDetail&product_id=%d",MAIN_DOMAIN,MAIN_PORT,ipid]];
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
        [[productDetailDataSource shareInstance].detailDic removeAllObjects];
        [[productDetailDataSource shareInstance].detailDic setDictionary:jsondic];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyProductDetail object:nil];
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
