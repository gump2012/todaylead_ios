//
//  proHtmlDataSource.h
//  todayios
//
//  Created by gump on 9/5/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseDataSource.h"

@interface proHtmlDataSource : baseDataSource

+ (proHtmlDataSource *)shareInstance;
-(NSString *)getHtmlString;

@end
