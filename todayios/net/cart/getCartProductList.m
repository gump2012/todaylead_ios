//
//  getCartProductList.m
//  todayios
//
//  Created by gump on 10/26/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "getCartProductList.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "cartDataSource.h"

@implementation getCartProductList

-(void)request{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?m=payment&a=getCartGoodsList%@",
                                       [self getDoMain],
                                       [self getDefaultValue]]];
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
        [[cartDataSource shareInstance].dataDic removeAllObjects];
        [[cartDataSource shareInstance].dataDic setDictionary:jsondic];
        [[cartDataSource shareInstance] getCartListFromData];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyCartProductList object:nil];
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
