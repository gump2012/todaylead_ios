//
//  listDataSource.m
//  todayios
//
//  Created by gump on 9/18/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "listDataSource.h"

static listDataSource * shareins = nil;

@implementation listDataSource

+ (listDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[listDataSource alloc] init];
	}
	return shareins;
}

@end
