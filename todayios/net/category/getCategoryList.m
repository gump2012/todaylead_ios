//
//  getCategoryList.m
//  todayios
//
//  Created by gump on 9/21/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "getCategoryList.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "categoryListDataSource.h"

@implementation getCategoryList

-(void)request{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@:%@/?m=category&a=getCategoryList",LATEST_DOMAIN,MAIN_PORT]];
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
        [[categoryListDataSource shareInstance].dataDic removeAllObjects];
        [[categoryListDataSource shareInstance].dataDic setDictionary:jsondic];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyCategoryList object:nil];
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
