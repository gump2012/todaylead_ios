//
//  payButtonView.m
//  todayios
//
//  Created by gump on 9/11/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "payButtonView.h"

#define PAYBTN_H    40.0f   
#define PAYBTN_W    100.0f

@implementation payButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, 0.5)];
        topLine.backgroundColor = [UIColor grayColor];
        [self addSubview:topLine];
        
        self.backgroundColor = [UIColor colorWithWhite:1.0  alpha:0.8];
        
        _immediatelyBtn  = [[UIButton alloc] initWithFrame:CGRectMake(20.0f, 5.0f, PAYBTN_W, PAYBTN_H)];
        _immediatelyBtn.backgroundColor = [UIColor orangeColor];
        [_immediatelyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        _immediatelyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        [self addSubview:_immediatelyBtn];
        
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(130.0f, 5.0f, PAYBTN_W, PAYBTN_H)];
        _addBtn.backgroundColor = [UIColor redColor];
        [_addBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        [self addSubview:_addBtn];
        
        _cartView = [[UIImageView alloc] initWithFrame:CGRectMake(252.0f, 4.0f, 50.0f, 42.0f)];
        _cartView.image = [UIImage imageNamed:@"cart.png"];
        [self addSubview:_cartView];
    }
    return self;
}

@end
