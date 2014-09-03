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
#import "getProductDetail.h"
#import "getPromotionList.h"

static httpManager * shareins = nil;

@implementation httpManager
@synthesize getshopad = _getshopad;
@synthesize getshoptop = _getshoptop;
@synthesize ProductDetail = _ProductDetail;
@synthesize promotionlist = _promotionlist;

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
        _ProductDetail = [[getProductDetail alloc] init];
        _promotionlist = [[getPromotionList alloc] init];
    }
    return self;
}

@end
