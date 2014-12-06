//
//  confirmTakeGoodCell.m
//  todayios
//
//  Created by gump on 11/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "confirmTakeGoodCell.h"
#import "confirmAddressDataSource.h"

@implementation confirmTakeGoodCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 5.0f, 60.0f, 20.0f)];
        _nameLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:_nameLabel];
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(160.0f, 5.0f, 100.0f, 20.0f)];
        _phoneLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:_phoneLabel];
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 25.0f, 200.0f, 40.0f)];
        _addressLabel.font = [UIFont systemFontOfSize:12.0f];
        _addressLabel.numberOfLines = 0;
        [self.contentView addSubview:_addressLabel];
        _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 20.0f, 200.0f, 20.0f)];
        _alertLabel.font = [UIFont systemFontOfSize:14.0f];
        _alertLabel.text = @"还没有收件人信息,请点击此处填写";
        _alertLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_alertLabel];
    }
    return self;
}

-(void)refreshCell{
    if ([confirmAddressDataSource shareInstance].name &&
        ![[confirmAddressDataSource shareInstance].name isEqualToString:@""]) {
        _nameLabel.hidden = NO;
        _phoneLabel.hidden = NO;
        _addressLabel.hidden = NO;
        _alertLabel.hidden = YES;
        
        _nameLabel.text = [confirmAddressDataSource shareInstance].name;
        _phoneLabel.text = [confirmAddressDataSource shareInstance].phone;
        _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",
                              [confirmAddressDataSource shareInstance].province,
                              [confirmAddressDataSource shareInstance].city,
                              [confirmAddressDataSource shareInstance].area,
                              [confirmAddressDataSource shareInstance].address];
        
    }else{
        _nameLabel.hidden = YES;
        _phoneLabel.hidden = YES;
        _addressLabel.hidden = YES;
        _alertLabel.hidden = NO;
    }
}

@end
