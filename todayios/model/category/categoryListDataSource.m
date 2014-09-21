//
//  categoryListDataSource.m
//  todayios
//
//  Created by gump on 9/21/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "categoryListDataSource.h"

static categoryListDataSource * shareins = nil;

@implementation categoryListDataSource

+ (categoryListDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[categoryListDataSource alloc] init];
	}
	return shareins;
}

@end
