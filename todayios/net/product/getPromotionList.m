//
//  getPromotionList.m
//  todayios
//
//  Created by gump on 9/3/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "getPromotionList.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "productPromotionDataSource.h"

@implementation getPromotionList

-(void)request{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@:%@/?m=shop&a=getPromotionList",LATEST_DOMAIN,MAIN_PORT]];
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
        [[productPromotionDataSource shareInstance].dataDic removeAllObjects];
        [[productPromotionDataSource shareInstance].dataDic setDictionary:jsondic];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyProductPromotion object:nil];
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
