//
//  cartCell.m
//  todayios
//
//  Created by gump on 10/26/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "cartCell.h"
#import "UIImageView+WebCache.h"

@implementation cartCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 30.0f, 18.0f, 18.0f)];
        _selectImage.image = [UIImage imageNamed:@"cb_circle_big_p.png"];
        [self.contentView addSubview:_selectImage];
        
        _pictureImage = [[UIImageView alloc] initWithFrame:CGRectMake(28.0f, 10.0f, 60.0f, 60.0f)];
        [self.contentView addSubview:_pictureImage];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(92.0f,
                                                              10.0f,
                                                              [CP shareInstance].w - 92.0f - 10.0f,
                                                               30.0f)];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:12.0f];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_textLabel];
        
        _attrLabel = [[UILabel alloc] initWithFrame:CGRectMake(92.0f,
                                                              40.0f,
                                                               [CP shareInstance].w - 92.0f - 10.0f, 15.0f)];
        _attrLabel.textAlignment = NSTextAlignmentLeft;
        _attrLabel.textColor = [UIColor darkGrayColor];
        _attrLabel.font = [UIFont systemFontOfSize:11.0f];
        [self.contentView addSubview:_attrLabel];
        
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(92.0f,
                                                                55.0f,
                                                                [CP shareInstance].w - 92.0f - 10.0f, 15.0f)];
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.textColor = [UIColor darkGrayColor];
        _numberLabel.font = [UIFont systemFontOfSize:11.0f];
        [self.contentView addSubview:_numberLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake([CP shareInstance].w - 100.0f,
                                                                75.0f, 100.0f, 15.0f)];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont systemFontOfSize:11.0f];
        _priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_priceLabel];
    }
    return self;
}

-(void)refreshCellWithDic:(NSDictionary *)dic{
    if (dic) {
        NSString *str = [dic objectForKey:@"pic_url"];
        if (str) {
            [_pictureImage sd_setImageWithURL:[NSURL URLWithString:str]];
        }
        
        str = [dic objectForKey:@"title"];
        if (str) {
            _textLabel.text = str;
        }
        
        NSArray *attrarr = [dic objectForKey:@"attr_list"];
        if (attrarr && [attrarr isKindOfClass:[NSArray class]]) {
            if (attrarr.count > 0) {
                NSDictionary *attrdic = [attrarr objectAtIndex:0];
                if (attrdic) {
                    NSString *strname = [attrdic objectForKey:@"attr_name"];
                    NSString *strvalue = [attrdic objectForKey:@"attr_value"];
                    _attrLabel.text = [NSString stringWithFormat:@"%@:%@",strname,strvalue];
                }
            }
        }
        
        str = [dic objectForKey:@"quantity"];
        if (str) {
            _numberLabel.text = [NSString stringWithFormat:@"数量:%@",str];
        }
        
        str = [dic objectForKey:@"price"];
        if (str) {
            float price = [str floatValue];
            _priceLabel.text = [NSString stringWithFormat:@"小计:  ¥%0.2f",price];
        }
    }
}

@end
