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

+(cartModel *)creatCartByDic:(NSDictionary *)dic{
    cartModel *cart = nil;
    if (dic) {
        cart = [[cartModel alloc] init];
        NSString *str = [dic objectForKey:@"goods_id"];
        if (str) {
            cart.pid = [str intValue];
        }
        
        str = [dic objectForKey:@"title"];
        if (str) {
            cart.strname = str;
        }
        
        str = [dic objectForKey:@"quantity"];
        if (str) {
            cart.number = [str intValue];
        }
        
        str = [dic objectForKey:@"price"];
        if (str) {
            cart.price = [str floatValue];
        }
        
        str = [dic objectForKey:@"pic_url"];
        if (str) {
            cart.strurl = str;
        }
        
        NSArray *attr = [dic objectForKey:@"attr_list"];
        if (attr && [attr isKindOfClass:[NSArray class]]) {
            [cart.attrarr removeAllObjects];
            [cart.attrarr setArray:attr];
        }
        
        cart.isSelect = YES;
        cart.editNumber = cart.number;
    }
    
    return cart;
}

@end
