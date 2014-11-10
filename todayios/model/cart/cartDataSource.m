//
//  cartDataSource.m
//  todayios
//
//  Created by gump on 9/30/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "cartDataSource.h"
#import "cartModel.h"

static cartDataSource * shareins = nil;

@implementation cartDataSource

@synthesize cartArr = _cartArr;

+ (cartDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[cartDataSource alloc] init];
        shareins.cartArr = [[NSMutableArray alloc] init];
        shareins.ibuyBtnType = BUYBTNTP_IM;
        
	}
	return shareins;
}

-(void)addCart:(cartModel *)cartmodel{
    if (_cartArr) {
        [_cartArr addObject:cartmodel];
    }
}

-(void)getCartListFromData{
    if (_dataDic) {
        [_cartArr removeAllObjects];
        NSArray *arr = [self getArrData];
        for (int i = 0; i < arr.count; ++i) {
            NSDictionary *dic = [arr objectAtIndex:i];
            cartModel *cart = [cartModel creatCartByDic:dic];
            [_cartArr addObject:cart];
        }
    }
}

-(float)getTotalPrice{
    float total = 0.0f;
    for(int i = 0; i < _cartArr.count;++i){
        cartModel *dic = [_cartArr objectAtIndex:i];
        if (dic && [dic isKindOfClass:[cartModel class]]) {
            if (dic.isSelect) {
                total += dic.price;
            }
        }
    }
    
    return total;
}

-(int)getSelectCount{
    int total = 0;
    for(int i = 0; i < _cartArr.count;++i){
        cartModel *dic = [_cartArr objectAtIndex:i];
        if (dic && [dic isKindOfClass:[cartModel class]]) {
            if (dic.isSelect) {
                total++;
            }
        }
    }
    
    return total;
}

-(void)AllSelect:(BOOL)bAllSel{
    for (int i = 0; i < _cartArr.count; ++i) {
        cartModel *cart = [_cartArr objectAtIndex:i];
        if (cart) {
            cart.isSelect = !bAllSel;
        }
    }
}

@end
