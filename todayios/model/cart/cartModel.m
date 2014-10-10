//
//  cartModel.m
//  todayios
//
//  Created by gump on 9/30/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "cartModel.h"

@implementation cartModel

@synthesize strname = _strname;
@synthesize strattrname = _strattrname;
@synthesize strurl = _strurl;
@synthesize pid = _pid;
@synthesize price = _price;
@synthesize number = _number;
@synthesize attrarr = _attrarr;

-(id)init{
    self = [super init];
    if (self) {
        _attrarr = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
