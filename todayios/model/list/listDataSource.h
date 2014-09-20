//
//  listDataSource.h
//  todayios
//
//  Created by gump on 9/18/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseDataSource.h"

@interface listDataSource : baseDataSource
{
    NSMutableArray *_listArr;
}

@property(nonatomic,strong) NSMutableArray *listArr;

+ (listDataSource *)shareInstance;
-(void)addArrFromArr:(NSArray *)arr;

@end
