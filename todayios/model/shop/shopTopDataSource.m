//
//  shopTopDataSource.m
//  todayios
//
//  Created by gump on 8/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "shopTopDataSource.h"
static shopTopDataSource * shareins = nil;

@implementation shopTopDataSource

@synthesize shopTopDic = _shopTopDic;

+ (shopTopDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[shopTopDataSource alloc] init];
	}
	return shareins;
}

-(id)init{
    self = [super init];
    if(self){
        _shopTopDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(NSArray *)getToplist
{
    NSArray *arr = nil;
    NSDictionary *infoDic = [_shopTopDic objectForKey:@"info"];
    if (infoDic) {
        NSDictionary *dataDic = [infoDic objectForKey:@"data"];
        if (dataDic) {
            arr = [dataDic objectForKey:@"topic_list"];
        }
    }
    return arr;
}
@end
