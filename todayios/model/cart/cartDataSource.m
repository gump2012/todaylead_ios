//
//  cartDataSource.m
//  todayios
//
//  Created by gump on 9/30/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "cartDataSource.h"

static cartDataSource * shareins = nil;

@implementation cartDataSource

@synthesize cartArr = _cartArr;

+ (cartDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[cartDataSource alloc] init];
        shareins.cartArr = [[NSMutableArray alloc] init];
	}
	return shareins;
}

@end
