//
//  cartDataSource.h
//  todayios
//
//  Created by gump on 9/30/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseDataSource.h"
@class cartModel;

enum{
    BUYBTNTP_IM,
    BUYBTNTP_ADD,
};

@interface cartDataSource : baseDataSource
{
    NSMutableArray *_cartArr;
}

+ (cartDataSource *)shareInstance;

@property(nonatomic,strong) NSMutableArray *cartArr;
@property(nonatomic,assign) int ibuyBtnType;

-(void)addCart:(cartModel*)cartmodel;

@end
