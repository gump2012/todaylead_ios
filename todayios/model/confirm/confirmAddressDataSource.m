//
//  confirmAddressDataSource.m
//  todayios
//
//  Created by gump on 11/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "confirmAddressDataSource.h"

static confirmAddressDataSource * shareins = nil;

@implementation confirmAddressDataSource
@synthesize name = _name;
@synthesize address = _address;
@synthesize phone = _phone;
@synthesize province = _province;
@synthesize city = _city;
@synthesize area = _area;
@synthesize proviceArr = _proviceArr;
@synthesize cityArr = _cityArr;
@synthesize areaArr = _areaArr;

+ (confirmAddressDataSource *)shareInstance
{
    if (nil == shareins)
    {
        shareins = [[confirmAddressDataSource alloc] init];
    }
    return shareins;
}

-(id)init{
    self = [super init];
    if (self) {
        _proviceArr = [[NSMutableArray alloc] init];
        _cityArr = [[NSMutableArray alloc] init];
        _areaArr = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
