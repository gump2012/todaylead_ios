//
//  httpManager.h
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class getShopAdList;

@interface httpManager : NSObject
{
    getShopAdList *_getshopad;
}

@property(nonatomic,strong) getShopAdList *getshopad;

+ (httpManager *)shareInstance;

@end
