//
//  priceCell.m
//  todayios
//
//  Created by gump on 9/10/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "priceCell.h"
#import "productDetailDataSource.h"

@implementation priceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _priceLabel = [[proiceLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 160.0f)];
        _alreadySeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 0.0f, 120.0f, 40.0f)];
        _alreadySeeLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:_priceLabel];
        [self.contentView addSubview:_alreadySeeLabel];
    }
    return self;
}

-(void)refreshCell{
    [_priceLabel setProic:
     [[productDetailDataSource shareInstance] getPrice]
             withOldPrice:
     [[productDetailDataSource shareInstance] getOldPrice]];
    
    int isee = [[productDetailDataSource shareInstance] getAlreadyBuy];
    _alreadySeeLabel.text = [NSString stringWithFormat:@"%d人已经购买",isee];
}

@end
