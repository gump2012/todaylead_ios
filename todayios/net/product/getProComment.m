//
//  getProComment.m
//  todayios
//
//  Created by gump on 9/6/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "getProComment.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "proCommentDataSource.h"

@implementation getProComment

-(void)request:(int)ipid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:
                                       @"%@:%@/?m=shop&a=getProductReviewList&product_id=%d",LATEST_DOMAIN,MAIN_PORT,ipid]];
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
        [[proCommentDataSource shareInstance].dataDic removeAllObjects];
        [[proCommentDataSource shareInstance].dataDic setDictionary:jsondic];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyProductComment object:nil];
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
