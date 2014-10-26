//
//  cartCell.h
//  todayios
//
//  Created by gump on 10/26/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseCell.h"

@interface cartCell : BaseCell
{
    UIImageView *_selectImage;
    UIImageView *_pictureImage;
    UILabel     *_textLabel;
    UILabel     *_attrLabel;
    UILabel     *_numberLabel;
    UILabel     *_priceLabel;
}

-(void)refreshCellWithDic:(NSDictionary *)dic;
@end
