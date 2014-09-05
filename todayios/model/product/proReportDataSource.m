//
//  proReportDataSource.m
//  todayios
//
//  Created by gump on 9/5/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "proReportDataSource.h"

static proReportDataSource * shareins = nil;

@implementation proReportDataSource

-(NSString *)getHtmlString{
    NSString *str = @"";
    NSDictionary *dic = [self getDicData];
    if (dic) {
        str = [dic objectForKey:@"content"];
    }
    
    return str;
}

+ (proReportDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[proReportDataSource alloc] init];
	}
	return shareins;
}

@end
