//
//  cartDataSource.m
//  todayios
//
//  Created by gump on 9/30/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "cartDataSource.h"
#import "cartModel.h"
#import "JSONKit.h"
#import "cartUpdate.h"

static cartDataSource * shareins = nil;

@implementation cartDataSource

@synthesize cartArr = _cartArr;
@synthesize updateArr = _updateArr;

+ (cartDataSource *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[cartDataSource alloc] init];
        shareins.cartArr = [[NSMutableArray alloc] init];
        shareins.updateArr = [[NSMutableArray alloc] init];
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

-(void)cancelEdit{
    for (int i = 0; i < _cartArr.count; ++i) {
        cartModel *cart = [_cartArr objectAtIndex:i];
        if (cart) {
            cart.editNumber = cart.number;
        }
    }
}

-(BOOL)saveCart{
    BOOL isSave = NO;
    [_updateArr removeAllObjects];
    for (int i = 0; i < _cartArr.count; ++i) {
        cartModel *cart = [_cartArr objectAtIndex:i];
        
        if (cart) {
            if (cart.editNumber != cart.number) {
                cart.number = cart.editNumber;
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:@"1" forKey:@"activity_type"];
                [dic setValue:@"0" forKey:@"is_activity"];
                
                NSMutableArray *attrlist = [[NSMutableArray alloc] init];
                for (int i = 0; i < cart.attrarr.count; ++i) {
                    NSDictionary *attrdic = [cart.attrarr objectAtIndex:i];
                    if (attrdic) {
                        NSMutableDictionary *mdic = [[NSMutableDictionary alloc] init];
                        NSString *str = [attrdic objectForKey:@"goods_attr_id"];
                        if (str) {
                            [mdic setValue:str forKey:@"goods_attr_id"];
                        }
                        str = [attrdic objectForKey:@"attr_id"];
                        if (str) {
                            [mdic setValue:str forKey:@"attr_id"];
                        }
                        
                        [attrlist addObject:mdic];
                    }
                }
                
                [dic setValue:attrlist forKey:@"attr_list"];
                [dic setValue:[NSString stringWithFormat:@"%d",cart.pid] forKey:@"product_id"];
                [dic setValue:[NSString stringWithFormat:@"%d",cart.number] forKey:@"quantity"];
                
                [_updateArr addObject:dic];
            }
        }
    }
    
    if (_updateArr.count > 0) {
        isSave = YES;
        [[httpManager shareInstance].cartUp requestWithList:[_updateArr JSONString] withType:@"merge"];
    }
    
    return isSave;
}

-(BOOL)deleteCart{
    BOOL isSave = NO;
    [_updateArr removeAllObjects];
    NSMutableArray *delearr = [[NSMutableArray alloc] init];
    for (int i = 0; i < _cartArr.count; ++i) {
        cartModel *cart = [_cartArr objectAtIndex:i];
        
        if (cart) {
            if (cart.isSelect) {
                [delearr addObject:cart];
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:@"1" forKey:@"activity_type"];
                [dic setValue:@"0" forKey:@"is_activity"];
                
                NSMutableArray *attrlist = [[NSMutableArray alloc] init];
                for (int i = 0; i < cart.attrarr.count; ++i) {
                    NSDictionary *attrdic = [cart.attrarr objectAtIndex:i];
                    if (attrdic) {
                        NSMutableDictionary *mdic = [[NSMutableDictionary alloc] init];
                        NSString *str = [attrdic objectForKey:@"goods_attr_id"];
                        if (str) {
                            [mdic setValue:str forKey:@"goods_attr_id"];
                        }
                        str = [attrdic objectForKey:@"attr_id"];
                        if (str) {
                            [mdic setValue:str forKey:@"attr_id"];
                        }
                        
                        [attrlist addObject:mdic];
                    }
                }
                
                [dic setValue:attrlist forKey:@"attr_list"];
                [dic setValue:[NSString stringWithFormat:@"%d",cart.pid] forKey:@"product_id"];
                [dic setValue:[NSString stringWithFormat:@"%d",cart.number] forKey:@"quantity"];
                
                [_updateArr addObject:dic];
            }
        }
    }
    
    if (_updateArr.count > 0) {
        isSave = YES;
        
        for (int i = 0; i < delearr.count; ++i) {
            [_cartArr removeObject:[delearr objectAtIndex:i]];
        }
        
        [[httpManager shareInstance].cartUp requestWithList:[_updateArr JSONString] withType:@"del"];
    }
    
    [delearr removeAllObjects];
    
    return isSave;
}

@end
