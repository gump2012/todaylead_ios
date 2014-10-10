//
//  cartUpdate.m
//  todayios
//
//  Created by gump on 10/10/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "cartUpdate.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "cartUpdateDataSource.h"
@implementation cartUpdate

-(void)requestWithList:(NSString *)strlist withType:(NSString *)strtype{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@:%@/?m=payment&a=cartUpdate%@",
                                       LATEST_DOMAIN,
                                       MAIN_PORT,
                                       [self getDefaultValue]]];
    LOG_Test(@"%@",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setValue:strlist forKey:@"list"];
    [request setValue:strtype forKey:@"type"];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
}

#pragma mark ----------http delegate----------------
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *jsondic = [responseString objectFromJSONString];
    if (jsondic) {
        [[cartUpdateDataSource shareInstance].dataDic removeAllObjects];
        [[cartUpdateDataSource shareInstance].dataDic setDictionary:jsondic];
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
