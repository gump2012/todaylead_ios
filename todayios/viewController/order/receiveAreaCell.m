//
//  receiveAreaCell.m
//  todayios
//
//  Created by gump on 12/2/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "receiveAreaCell.h"
#import "confirmAddressDataSource.h"

@implementation receiveAreaCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 4.0f, 100.0f, 40.0f)];
        _textLabel.text = @"所在地区:";
        _textLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClicklabel:)];
        [_textLabel addGestureRecognizer:singleTap];
        [self.contentView addSubview:_textLabel];
        _textLabel.font = [UIFont systemFontOfSize:12.0f];
        _textLabel.textColor = [UIColor grayColor];
        
        _areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 4.0f, 200.0f, 40.0f)];
        _areaLabel.userInteractionEnabled = YES;
        singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
        [_areaLabel addGestureRecognizer:singleTap];
        [self.contentView addSubview:_areaLabel];
        self.clickblock = nil;
        self.clicklabel = nil;
    }
    return self;
}

-(void)refreshCell{
    if ([confirmAddressDataSource shareInstance].province) {
        _areaLabel.text = [NSString stringWithFormat:@"%@%@%@",
                           [confirmAddressDataSource shareInstance].province,
                           [confirmAddressDataSource shareInstance].city,
                           [confirmAddressDataSource shareInstance].area];
    }
}

-(void)onClick:(id)sender{
    if (self.clickblock) {
        self.clickblock();
    }
}

-(void)onClicklabel:(id)sender{
    if (self.clicklabel) {
        self.clicklabel();
    }
}

@end
