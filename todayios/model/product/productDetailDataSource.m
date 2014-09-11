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

+ (productDetailDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[productDetailDataSource alloc] init];
        shareins.ibaseAttr = BASEATTR_HIDE;
	}
	return shareins;
}

-(NSString *)getTitle{
    NSString *str = @"";
        NSDictionary *data = [self getDicData];
        if (data) {
            str = [data objectForKey:@"name"];
        }
    return str;
}

-(float)getPrice{
    float p = 0.0f;
        NSDictionary *data = [self getDicData];
        if (data) {
            NSString *strp = [data objectForKey:@"price"];
            if (strp) {
                p = [strp floatValue];
            }
        }
    
    return p;
}

-(float)getOldPrice{
    float p = 0.0f;
        NSDictionary *data = [self getDicData];
        if (data) {
            NSString *strp = [data objectForKey:@"origin_price"];
            if (strp) {
                p = [strp floatValue];
            }
        }
    
    return p;
}

-(int)getAlreadyBuy{
    int ibuy = 0;
        NSDictionary *data = [self getDicData];
        if (data) {
            NSString *str = [data objectForKey:@"volume"];
            if (str) {
                ibuy = (int)[str integerValue];
            }
        }
    
    return ibuy;
}

-(int)getrecentvolume{
    int iv = 0;
        NSDictionary *data = [self getDicData];
        if (data) {
            NSString *str = [data objectForKey:@"recent_volume"];
            if(str){
                iv = (int)[str integerValue];
            }
        }
    
    return iv;
}

-(NSArray *)getAttrList{
    NSArray *arr = nil;
        NSDictionary *data = [self getDicData];
        if (data) {
            arr = [data objectForKey:@"attr_list"];
        }
    
    return arr;
}

@end
