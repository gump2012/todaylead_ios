//
//  shopadDataSource.m
//  todayios
//
//  Created by lishiming on 14-7-22.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "shopadDataSource.h"

static shopadDataSource * shareins = nil;

@implementation shopadDataSource

+ (shopadDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[shopadDataSource alloc] init];
	}
	return shareins;
}

@end
