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
    NSMutableArray *_updateArr;
}

+ (cartDataSource *)shareInstance;

@property(nonatomic,strong) NSMutableArray *cartArr;
@property(nonatomic,strong) NSMutableArray *updateArr;
@property(nonatomic,assign) int ibuyBtnType;

-(void)addCart:(cartModel*)cartmodel;
-(void)getCartListFromData;
-(float)getTotalPrice;
-(int)getSelectCount;
-(void)AllSelect:(BOOL)bAllSel;
-(void)cancelEdit;
-(BOOL)saveCart;
-(BOOL)deleteCart;

@end
