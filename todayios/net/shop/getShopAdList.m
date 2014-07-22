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

@implementation getShopAdList

-(void)request{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@:%@/?m=shop&a=getAdList",MAIN_DOMAIN,MAIN_PORT]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
}

#pragma mark ----------http delegate----------------
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    
    JSONDecoder *jd=[[JSONDecoder alloc] init];
    NSDictionary *jsondic = [jd objectWithUTF8String:(const unsigned char *)[responseString UTF8String]
                                              length:(unsigned int)[responseString length]];
    if (jsondic) {
       LOG_Test(@"%@",jsondic);
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    if (error) {
        LOG_Error(@"%@",error);
    }
}

@end
