//
//  proNameCell.m
//  todayios
//
//  Created by gump on 9/9/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "proNameCell.h"
#import "productDetailDataSource.h"

@implementation proNameCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,
                                                                2.0f,
                                                                [CP shareInstance].w * 2 /3, 40.0f)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

-(void)refreshCell{
    NSString *str = [[productDetailDataSource shareInstance] getTitle];
    if (str) {
        _titleLabel.text = str;
    }
}

@end
