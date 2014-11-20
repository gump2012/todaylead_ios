//
//  confirmAddressDataSource.h
//  todayios
//
//  Created by gump on 11/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseDataSource.h"

@interface confirmAddressDataSource : baseDataSource
{
    NSString *_name;
    NSString *_address;
    NSString *_phone;
    NSString *_province;
    NSString *_city;
}

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *province;
@property(nonatomic,strong) NSString *city;

+ (confirmAddressDataSource *)shareInstance;
@end
