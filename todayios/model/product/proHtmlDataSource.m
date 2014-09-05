//
//  proHtmlDataSource.m
//  todayios
//
//  Created by gump on 9/5/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "proHtmlDataSource.h"

static proHtmlDataSource * shareins = nil;

@implementation proHtmlDataSource

-(NSString *)getHtmlString{
    NSString *str = @"";
    NSDictionary *dic = [self getDicData];
    if (dic) {
        str = [dic objectForKey:@"content"];
    }
    
    return str;
}

+ (proHtmlDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[proHtmlDataSource alloc] init];
	}
	return shareins;
}

@end
