//
//  baseDataSource.m
//  todayios
//
//  Created by gump on 9/5/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseDataSource.h"

@implementation baseDataSource
@synthesize dataDic = _dataDic;

-(id)init{
    self = [super init];
    if (self) {
        _dataDic = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(NSDictionary *)getDicData{
    NSDictionary *dic = nil;
    if (_dataDic) {
        NSDictionary *info = [_dataDic objectForKey:@"info"];
        if (info) {
            dic = [info objectForKey:@"data"];
            if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                return dic;
            }
            else
            {
                return nil;
            }
        }
    }
    
    return dic;
}

-(NSArray *)getArrData{
    NSArray *dic = nil;
    if (_dataDic) {
        NSDictionary *info = [_dataDic objectForKey:@"info"];
        if (info) {
            dic = [info objectForKey:@"data"];
            if (dic && [dic isKindOfClass:[NSArray class]]) {
                return dic;
            }
            else
            {
                return nil;
            }
        }
    }
    
    return dic;
}

@end
