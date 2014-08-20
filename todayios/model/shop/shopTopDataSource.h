//
//  shopTopDataSource.h
//  todayios
//
//  Created by gump on 8/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

@interface shopTopDataSource : NSObject

@property(nonatomic,strong) NSMutableDictionary *shopTopDic;

+ (shopTopDataSource *)shareInstance;
-(NSArray *)getToplist;

@end
