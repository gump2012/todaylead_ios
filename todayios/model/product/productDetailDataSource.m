//
//  productDetailDataSource.m
//  todayios
//
//  Created by gump on 8/23/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "productDetailDataSource.h"

static productDetailDataSource * shareins = nil;

@implementation productDetailDataSource
@synthesize detailDic = _detailDic;

+ (productDetailDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[productDetailDataSource alloc] init];
	}
	return shareins;
}

-(id)init{
    self = [super init];
    if(self){
        _detailDic = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(NSString *)getTitle{
    NSString *str = @"";
    if (_detailDic) {
        NSDictionary *data = [self getData];
        if (data) {
            str = [data objectForKey:@"name"];
        }
    }
    return str;
}

-(float)getPrice{
    float p = 0.0f;
    if (_detailDic) {
        NSDictionary *data = [self getData];
        if (data) {
            NSString *strp = [data objectForKey:@"price"];
            if (strp) {
                p = [strp floatValue];
            }
        }
    }
    
    return p;
}

-(float)getOldPrice{
    float p = 0.0f;
    if (_detailDic) {
        NSDictionary *data = [self getData];
        if (data) {
            NSString *strp = [data objectForKey:@"origin_price"];
            if (strp) {
                p = [strp floatValue];
            }
        }
    }
    
    return p;
}

-(NSDictionary *)getData{
    NSDictionary *dic = nil;
    if (_detailDic) {
        NSDictionary *info = [_detailDic objectForKey:@"info"];
        if (info) {
            dic = [info objectForKey:@"data"];
        }
    }
    
    return dic;
}

-(int)getAlreadyBuy{
    int ibuy = 0;
    if (_detailDic) {
        NSDictionary *data = [self getData];
        if (data) {
            NSString *str = [data objectForKey:@"volume"];
            if (str) {
                ibuy = [str integerValue];
            }
        }
    }
    
    return ibuy;
}

-(int)getrecentvolume{
    int iv = 0;
    if (_detailDic) {
        NSDictionary *data = [self getData];
        if (data) {
            NSString *str = [data objectForKey:@"recent_volume"];
            if(str){
                iv = [str integerValue];
            }
        }
    }
    
    return iv;
}

@end
