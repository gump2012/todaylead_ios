//
//  payButtonView.m
//  todayios
//
//  Created by gump on 9/11/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "payButtonView.h"

#define PAYBTN_H    30.0f
#define PAYBTN_W    100.0f

@implementation payButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, 0.5)];
        topLine.backgroundColor = [UIColor grayColor];
        [self addSubview:topLine];
        self.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:242.0/255.0 alpha:1.0];
        
        _immediatelyBtn  = [[UIButton alloc] initWithFrame:CGRectMake(20.0f, 5.0f, PAYBTN_W, PAYBTN_H)];
        _immediatelyBtn.backgroundColor = [UIColor orangeColor];
        [_immediatelyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_immediatelyBtn addTarget:self action:@selector(clickImmediate) forControlEvents:UIControlEventTouchUpInside];
        _immediatelyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _immediatelyBtn.layer.cornerRadius = 5;
        _immediatelyBtn.layer.masksToBounds = YES;
        [self addSubview:_immediatelyBtn];
        
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(130.0f, 5.0f, PAYBTN_W, PAYBTN_H)];
        _addBtn.backgroundColor = [UIColor redColor];
        [_addBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _addBtn.layer.cornerRadius = 5;
        _addBtn.layer.masksToBounds = YES;
        [self addSubview:_addBtn];
        
        _cartView = [[UIImageView alloc] initWithFrame:CGRectMake(252.0f, 4.0f, 30.0f, 30.0f)];
        _cartView.image = [UIImage imageNamed:@"cart.png"];
        _cartView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickCart:)];
        [_cartView addGestureRecognizer:singleTap];
        [self addSubview:_cartView];
        
        _cartUnReadView = [[UIImageView alloc] initWithFrame:CGRectMake(272.0f, 4.0f, 22.0f, 15.0f)];
        _cartUnReadView.image = [UIImage imageNamed:@"icon_unread.png"];
        [self addSubview:_cartUnReadView];
        
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(276.0f, 3.0f, 20.0f, 15.0f)];
        _numberLabel.font = [UIFont systemFontOfSize:10.0f];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numberLabel];
    }
        return self;
}
    
-(void)clickImmediate{
    if (self.immediateBlock) {
        self.immediateBlock();
    }
}

-(void)clickAdd{
    if (self.addBlock) {
        self.addBlock();
    }
}

-(void)setUnReadNumber:(int)inum{
    if (inum > 0) {
        _cartUnReadView.hidden = NO;
        _numberLabel.hidden = NO;
        
        _numberLabel.text = [NSString stringWithFormat:@"%d",inum];
    }else{
        _cartUnReadView.hidden = YES;
        _numberLabel.hidden = YES;
    }
}

-(void)onClickCart:(id)sender{
    [CP shareInstance].mytabbar.selectedIndex = 2;
}

@end
