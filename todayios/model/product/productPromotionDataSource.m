//
//  productPromotionDataSource.m
//  todayios
//
//  Created by gump on 9/3/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "productPromotionDataSource.h"

static productPromotionDataSource * shareins = nil;

@implementation productPromotionDataSource

@synthesize dataDic = _dataDic;

+ (productPromotionDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[productPromotionDataSource alloc] init];
	}
	return shareins;
}

-(id)init{
    self = [super init];
    if(self){
        _dataDic = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(NSArray *)getPromotionList{
    NSArray *arr = nil;
    if (_dataDic) {
        NSDictionary *info = [_dataDic objectForKey:@"info"];
        if (info) {
            arr = [info objectForKey:@"data"];
        }
    }
    
    return arr;
}

@end
