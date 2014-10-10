//
//  cartUpdateDataSource.m
//  todayios
//
//  Created by gump on 10/10/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "cartUpdateDataSource.h"

static cartUpdateDataSource * shareins = nil;

@implementation cartUpdateDataSource

+ (cartUpdateDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[cartUpdateDataSource alloc] init];
	}
	return shareins;
}

@end
