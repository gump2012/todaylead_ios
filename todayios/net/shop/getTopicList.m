//
//  getTopicList.m
//  todayios
//
//  Created by gump on 9/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "getTopicList.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "listDataSource.h"

@implementation getTopicList
-(void)requestWithLimit:(int)ilimit withPage:(int)ipage withTopic:(int)itopic{
    NSString *str = [NSString stringWithFormat:
                     @"%@/?m=shop&a=getTopicProductList&count=%d&page=%d&topic_id=%d",
                     [self getDoMain],
                     ilimit,
                     ipage,
                     itopic];
    NSURL *url = [NSURL URLWithString:str];
    LOG_Test(@"%@",url);
    _ipage = ipage;
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
        if (_ipage == 1) {
            [[listDataSource shareInstance].listArr removeAllObjects];
            [[listDataSource shareInstance].dataDic removeAllObjects];
            [[listDataSource shareInstance].dataDic setDictionary:jsondic];
            [[listDataSource shareInstance] addArrFromArr:[[listDataSource shareInstance] getArrData]];
        }
        else if(_ipage > 1){
            [[listDataSource shareInstance].dataDic removeAllObjects];
            [[listDataSource shareInstance].dataDic setDictionary:jsondic];
            [[listDataSource shareInstance] addArrFromArr:[[listDataSource shareInstance] getArrData]];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyTopicList object:nil];
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
