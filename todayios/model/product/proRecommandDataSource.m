//
//  proRecommandDataSource.m
//  todayios
//
//  Created by gump on 9/9/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "proRecommandDataSource.h"

static proRecommandDataSource * shareins = nil;

@implementation proRecommandDataSource

+ (proRecommandDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[proRecommandDataSource alloc] init];
	}
	return shareins;
}

@end
