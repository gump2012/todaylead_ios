//
//  cartDataSource.h
//  todayios
//
//  Created by gump on 9/30/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseDataSource.h"

@interface cartDataSource : baseDataSource
{
    NSMutableArray *_cartArr;
}
+ (cartDataSource *)shareInstance;

@property(nonatomic,strong) NSMutableArray *cartArr;

@end
