//
//  cartEmptyView.m
//  todayios
//
//  Created by gump on 10/1/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "cartEmptyView.h"

@implementation cartEmptyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(([CP shareInstance].w - 65.0f)/2, 150.0f, 65.0f, 80.0f)];
        _imageview.image = [UIImage imageNamed:@"icon_shopcar_none.png"];
        [self addSubview:_imageview];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 250.0f,[CP shareInstance].w, 20.0f)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"购物车还是空的,赶紧去逛逛吧";
        _label.textColor = [UIColor darkGrayColor];
        _label.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:_label];
        _seeBtn = [[UIButton alloc] initWithFrame:CGRectMake(([CP shareInstance].w - 150.0f)/2, 290.0f, 150.0f, 30.0f)];
        _seeBtn.backgroundColor = [UIColor orangeColor];
        [_seeBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
        [_seeBtn addTarget:self action:@selector(clicksee) forControlEvents:UIControlEventTouchUpInside];
        _seeBtn.layer.cornerRadius = 5;
        _seeBtn.layer.masksToBounds = YES;
        [self addSubview:_seeBtn];
    }
    return self;
}

-(void)clicksee{
    UITabBarController *tabbar = (UITabBarController *)[CP shareInstance].mywindow.rootViewController;
    tabbar.selectedIndex = TABBAR_SHOP;
}

@end
