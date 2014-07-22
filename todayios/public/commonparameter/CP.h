//
//  CP.h
//  todayios
//
//  Created by lishiming on 14-7-22.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CP : NSObject
{
    float   _h;//屏幕高
    float   _w;//屏幕宽
}

@property(nonatomic,assign) float h;
@property(nonatomic,assign) float w;

+ (CP *)shareInstance;

@end
