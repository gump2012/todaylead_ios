//
//  proiceLabel.m
//  todayios
//
//  Created by gump on 9/3/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "proiceLabel.h"

@implementation proiceLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,
                                                               0.0f,
                                                               50.0f,
                                                               40.0f)];
        _priceLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        
        _oldpriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f,
                                                                   12.0f,
                                                                   50.0f,
                                                                   20.0f)];
        _oldpriceLabel.font = [UIFont systemFontOfSize:14.0f];
        _oldpriceLabel.textColor = [UIColor grayColor];
        _oldpriceLabel.adjustsFontSizeToFitWidth = YES;
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(80.0f,
                                                                          22.0f, 40.0f, 1.0f)];
        line.backgroundColor = [UIColor grayColor];
        
        [self addSubview:_priceLabel];
        [self addSubview:_oldpriceLabel];
        [self addSubview:line];
        
    }
    return self;
}

-(void)setProic:(float)fprice withOldPrice:(float)fold
{
    _priceLabel.text = [NSString stringWithFormat:@"¥%0.2f",fprice];
    _oldpriceLabel.text = [NSString stringWithFormat:@"%0.2f",fold];
}

@end
