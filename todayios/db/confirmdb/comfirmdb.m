//
//  comfirmdb.m
//  todayios
//
//  Created by gump on 12/3/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "comfirmdb.h"
#import "FMDatabase.h"

@implementation confirmAddressDataSource(comfirmdb)

-(void)initFromDB{
    NSString* pathpath = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"db"];
    FMDatabase *db = [FMDatabase databaseWithPath:pathpath];
    if ([db open]) {
        FMResultSet *s = [db executeQuery:@"SELECT * FROM region where level = 1"];
        [_proviceArr removeAllObjects];
        while ([s next]) {
            NSString *strname = [s stringForColumn:@"region_name"];
            int iid = [s intForColumn:@"id"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:strname forKey:@"region_name"];
            [dic setValue:[NSNumber numberWithInt:iid] forKey:@"id"];
            [_proviceArr addObject:dic];
        }
    }
    
    [db close];
    
    if(_proviceArr.count > 0){
        NSDictionary *dic = [_proviceArr objectAtIndex:0];
        if (dic) {
            _province = [dic objectForKey:@"region_name"];
            
            int iid = [[dic objectForKey:@"id"] intValue];
            NSMutableArray *cityarr = [self getArrByID:iid];
            [_cityArr removeAllObjects];
            [_cityArr setArray:cityarr];
        }
    }
    
    if(_cityArr.count > 0){
        NSDictionary *dic = [_cityArr objectAtIndex:0];
        if (dic) {
            
            _city = [dic objectForKey:@"region_name"];
            
            int iid = [[dic objectForKey:@"id"] intValue];
            NSMutableArray *cityarr = [self getArrByID:iid];
            [_areaArr removeAllObjects];
            [_areaArr setArray:cityarr];
        }
    }
    
    if (_areaArr.count > 0) {
        NSDictionary *dic = [_areaArr objectAtIndex:0];
        if (dic) {
            _area = [dic objectForKey:@"region_name"];
        }
    }
}

-(NSMutableArray *)getArrByID:(int)iid{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSString* pathpath = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"db"];
    FMDatabase *db = [FMDatabase databaseWithPath:pathpath];
    if ([db open]) {
        FMResultSet *s = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM region where parent_id = %d",iid]];
        
        while ([s next]) {
            NSString *strname = [s stringForColumn:@"region_name"];
            int iid = [s intForColumn:@"id"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:strname forKey:@"region_name"];
            [dic setValue:[NSNumber numberWithInt:iid] forKey:@"id"];
            [arr addObject:dic];
        }
    }
    
    [db close];
    
    return arr;
}

@end
