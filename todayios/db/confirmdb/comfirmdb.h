//
//  comfirmdb.h
//  todayios
//
//  Created by gump on 12/3/14.
//  Copyright (c) 2014 gump. All rights reserved.
//
#import "confirmAddressDataSource.h"

@interface confirmAddressDataSource(comfirmdb)

-(void)initFromDB;
-(NSMutableArray *)getArrByID:(int)iid;

@end
