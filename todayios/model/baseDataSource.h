//
//  baseDataSource.h
//  todayios
//
//  Created by gump on 9/5/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface baseDataSource : NSObject
{
    NSMutableDictionary *_dataDic;
}

@property(nonatomic,strong) NSMutableDictionary *dataDic;

-(NSDictionary *)getDicData;
-(NSArray *)getArrData;
-(NSString *)getMessage;
-(NSString *)getResponseStatus;

@end
