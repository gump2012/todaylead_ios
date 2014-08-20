//
//  httpManager.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "httpManager.h"
#import "getShopAdList.h"
#import "getShopTop.h"

static httpManager * shareins = nil;

@implementation httpManager
@synthesize getshopad = _getshopad;
@synthesize getshoptop = _getshoptop;

+ (httpManager *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[httpManager alloc] init];
	}
	return shareins;
}

-(id)init{
    self = [super init];
    if(self){
        _getshopad = [[getShopAdList alloc] init];
        _getshoptop = [[getShopTop alloc] init];
    }
    return self;
}

@end
