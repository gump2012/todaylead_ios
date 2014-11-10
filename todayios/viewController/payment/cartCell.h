//
//  cartCell.h
//  todayios
//
//  Created by gump on 10/26/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseCell.h"
@class cartModel;

@interface cartCell : BaseCell
{
    UIImageView *_selectImage;
    UIImageView *_pictureImage;
    UILabel     *_textLabel;
    UILabel     *_attrLabel;
    UILabel     *_numberLabel;
    UILabel     *_priceLabel;
    
    UIImageView *_addview;
    UIImageView *_subview;
    UILabel *_editnumberLabel;
    UILabel *_addLabel;
    UILabel *_subLabel;
    UIImageView *_topLine;
    UIImageView *_bottomLine;
    UIImageView *_line1;
    UIImageView *_line2;
    UIImageView *_line3;
    UIImageView *_line4;
    
    cartModel *_mycart;
}

@property (nonatomic,copy) void (^cellselect)();

-(void)refreshCellWithCart:(cartModel *)cart withIsEdit:(BOOL)bedit;
@end
