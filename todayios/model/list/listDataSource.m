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
@synthesize listArr = _listArr;

+ (listDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[listDataSource alloc] init];
        shareins.listArr = [[NSMutableArray alloc] init];
	}
	return shareins;
}

-(void)addArrFromArr:(NSArray *)arr{
    for (int i = 0; i < arr.count;++i) {
        id obj = [arr objectAtIndex:i];
        [_listArr addObject:obj];
    }
}

@end
