//
//  shopadDataSource.h
//  todayios
//
//  Created by lishiming on 14-7-22.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shopadDataSource : NSObject
{
    NSMutableDictionary *_shopadDic;
}

@property(nonatomic,strong) NSMutableDictionary *shopadDic;

+ (shopadDataSource *)shareInstance;

@end
