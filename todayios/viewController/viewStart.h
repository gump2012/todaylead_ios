//
//  viewStart.h
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface viewStart : NSObject

+ (viewStart *)shareInstance;
- (void)start:(UIWindow *)window;

@end
