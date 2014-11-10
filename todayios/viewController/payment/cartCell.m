//
//  cartCell.m
//  todayios
//
//  Created by gump on 10/26/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "cartCell.h"
#import "UIImageView+WebCache.h"
#import "cartModel.h"

@implementation cartCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 30.0f, 18.0f, 18.0f)];
        _selectImage.image = [UIImage imageNamed:@"cb_circle_big_p.png"];
        _selectImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickSelect:)];
        [_selectImage addGestureRecognizer:singleTap];
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
        
        _addview = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 10.0f, 40.0f, 60.0f)];
        _addview.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:242.0/255.0 alpha:1.0];
        _addview.userInteractionEnabled = YES;
        singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickAdd:)];
        [_addview addGestureRecognizer:singleTap];
        [self.contentView addSubview:_addview];
        
        _subview = [[UIImageView alloc] initWithFrame:CGRectMake(180.0f, 10.0f, 40.0f, 60.0f)];
        _subview.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:242.0/255.0 alpha:1.0];
        _subview.userInteractionEnabled = YES;
        singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickSub:)];
        [_subview addGestureRecognizer:singleTap];
        [self.contentView addSubview:_subview];
        
        _subLabel = [[UILabel alloc] initWithFrame:CGRectMake(180.0f, 30.0f, 40.0f, 20.0f)];
        _subLabel.text = @"-";
        _subLabel.textColor = [UIColor grayColor];
        _subLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_subLabel];
        
        _addLabel = [[UILabel alloc] initWithFrame:CGRectMake(260.0f, 30.0f, 40.0f, 20.0f)];
        _addLabel.text = @"+";
        _addLabel.textAlignment = NSTextAlignmentCenter;
        _addLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_addLabel];
        
        _editnumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, 30.0f, 40.0f, 20.0f)];
        _editnumberLabel.textAlignment = NSTextAlignmentCenter;
        _editnumberLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_editnumberLabel];
        
        _mycart = nil;
        self.cellselect = nil;
    }
    return self;
}

-(void)refreshCellWithCart:(cartModel *)cart withIsEdit:(BOOL)bedit{
    if (cart) {
        [self showEdit:bedit];
        _mycart = cart;
        if (cart.isSelect) {
            _selectImage.image = [UIImage imageNamed:@"cb_circle_big_p.png"];
        }
        else{
            _selectImage.image = [UIImage imageNamed:@"cb_circle_big_n.png"];
        }
        
        if (bedit) {
            [_pictureImage sd_setImageWithURL:[NSURL URLWithString:cart.strurl]];
            _textLabel.text = cart.strname;
            
            if (cart.attrarr.count > 0) {
                NSDictionary *attrdic = [cart.attrarr objectAtIndex:0];
                if (attrdic) {
                    NSString *strname = [attrdic objectForKey:@"attr_name"];
                    NSString *strvalue = [attrdic objectForKey:@"attr_value"];
                    _attrLabel.text = [NSString stringWithFormat:@"%@:%@",strname,strvalue];
                }
            }
            
            _numberLabel.text = [NSString stringWithFormat:@"数量:%d",cart.number];
            
            _priceLabel.text = [NSString stringWithFormat:@"小计:  ¥%0.2f",cart.price];
        }else{
            _editnumberLabel.text = [NSString stringWithFormat:@"%d",cart.editNumber];
        }
    }
}

-(void)showEdit:(BOOL)bedit{
    if (bedit) {
        _addview.hidden = YES;
        _subview.hidden = YES;
        _editnumberLabel.hidden = YES;
        _addLabel.hidden = YES;
        _subLabel.hidden = YES;
        _topLine.hidden = YES;
        _bottomLine.hidden = YES;
        _line1.hidden = YES;
        _line2.hidden = YES;
        _line3.hidden = YES;
        _line4.hidden = YES;
        
        _textLabel.hidden = NO;
        _attrLabel.hidden = NO;
        _numberLabel.hidden = NO;
    }
    else{
        _addview.hidden = NO;
        _subview.hidden = NO;
        _editnumberLabel.hidden = NO;
        _addLabel.hidden = NO;
        _subLabel.hidden = NO;
        _topLine.hidden = NO;
        _bottomLine.hidden = NO;
        _line1.hidden = NO;
        _line2.hidden = NO;
        _line3.hidden = NO;
        _line4.hidden = NO;
        
        _textLabel.hidden = YES;
        _attrLabel.hidden = YES;
        _numberLabel.hidden = YES;
    }
}

-(void)onClickSelect:(id)sender{
    if (_mycart) {
        if (_mycart.isSelect) {
            _selectImage.image = [UIImage imageNamed:@"cb_circle_big_n.png"];
            _mycart.isSelect = NO;
        }
        else{
            _selectImage.image = [UIImage imageNamed:@"cb_circle_big_p.png"];
            _mycart.isSelect = YES;
        }
    }
    
    if (self.cellselect) {
        self.cellselect();
    }
}

-(void)onClickAdd:(id)sender{
    if (_mycart) {
        _mycart.editNumber++;
        
        _editnumberLabel.text = [NSString stringWithFormat:@"%d",_mycart.editNumber];
    }
}

-(void)onClickSub:(id)sender{
    if (_mycart) {
        if (_mycart.editNumber > 1) {
            _mycart.editNumber--;
            
            _editnumberLabel.text = [NSString stringWithFormat:@"%d",_mycart.editNumber];
        }
    }
}

@end
