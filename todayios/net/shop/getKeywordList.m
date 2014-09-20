//
//  getKeywordList.m
//  todayios
//
//  Created by gump on 9/17/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "getKeywordList.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "listDataSource.h"


@implementation getKeywordList
-(void)requestWithLimit:(int)ilimit withPage:(int)ipage withKeyword:(NSString *)strkey{
    NSString *str = [NSString stringWithFormat:
                     @"%@:%@/?m=shop&a=getSearchProductList&count=%d&page=%d&keyword=%@",
                     LATEST_DOMAIN,
                     MAIN_PORT,
                     ilimit,
                     ipage,
                     strkey];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    LOG_Test(@"%@",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    _ipage = ipage;
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
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyKeywordList object:nil];
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
