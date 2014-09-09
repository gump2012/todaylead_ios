//
//  proCommentDataSource.m
//  todayios
//
//  Created by gump on 9/7/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "proCommentDataSource.h"

static proCommentDataSource * shareins = nil;

@implementation proCommentDataSource

+ (proCommentDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[proCommentDataSource alloc] init];
        shareins.commentType = COMMENT_HIDE;
	}
	return shareins;
}

@end
