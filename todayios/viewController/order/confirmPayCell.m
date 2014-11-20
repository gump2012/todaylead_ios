//
//  confirmPayCell.m
//  todayios
//
//  Created by gump on 11/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "confirmPayCell.h"

@implementation confirmPayCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14.0f, 12.0f, 100.0f, 20.0f)];
        _nameLabel.font = [UIFont systemFontOfSize:12.0f];
        _nameLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_nameLabel];
        
        _baoyouLabel = [[UILabel alloc] initWithFrame:CGRectMake(110.0f, 12.0f, 100.0f, 20.0f)];
        _baoyouLabel.font = [UIFont systemFontOfSize:10.0f];
        _baoyouLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_baoyouLabel];
        
        _selectView = [[UIImageView alloc] initWithFrame:CGRectMake([CP shareInstance].w - 20.0f, 12.0f, 18.0f, 18.0f)];
        _selectView.image = [UIImage imageNamed:@"cb_circle_big_p.png"];
        [self.contentView addSubview:_selectView];
    }
    
    return self;
}

-(void)refreshCell{
    _nameLabel.text = @"支付宝";
    _baoyouLabel.text = @"满100包邮";
}

@end
