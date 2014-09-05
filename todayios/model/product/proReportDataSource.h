//
//  proReportDataSource.h
//  todayios
//
//  Created by gump on 9/5/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseDataSource.h"

@interface proReportDataSource : baseDataSource

+ (proReportDataSource *)shareInstance;
-(NSString *)getHtmlString;

@end
