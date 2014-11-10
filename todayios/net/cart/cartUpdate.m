//
//  cartUpdate.m
//  todayios
//
//  Created by gump on 10/10/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "cartUpdate.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "cartUpdateDataSource.h"
@implementation cartUpdate

-(void)requestWithList:(NSString *)strlist withType:(NSString *)strtype{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?m=payment&a=cartUpdate%@",
                                       [self getDoMain],
                                       [self getDefaultValue]]];
    LOG_Test(@"%@",url);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:strlist forKey:@"list"];
    [request setPostValue:strtype forKey:@"type"];
    _strtype = strtype;
    
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
        if ([_strtype isEqualToString:@"add"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotifyCartUpdate object:nil];
        }else if([_strtype isEqualToString:@"merge"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:NotifyCartSave object:nil];
        }else if([_strtype isEqualToString:@"del"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:NotifyCartDelete object:nil];
        }
        
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
