//
//  CP.m
//  todayios
//
//  Created by lishiming on 14-7-22.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "CP.h"

static CP * shareins = nil;

@implementation CP
@synthesize h = _h;
@synthesize w = _w;

+ (CP *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[CP alloc] init];
	}
	return shareins;
}

-(id)init{
    self = [super init];
    if(self){
        CGRect tScreenRect = [[UIScreen mainScreen] bounds];
		_h = tScreenRect.size.height;
		_w = tScreenRect.size.width;
        self.mywindow = nil;
        self.mytabbar = nil;
        self.idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        self.deviceVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    }
    return self;
}

@end
