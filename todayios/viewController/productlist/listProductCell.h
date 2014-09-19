//
//  listProductCell.h
//  todayios
//
//  Created by gump on 9/18/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseCell.h"

@interface listProductCell : BaseCell
{
    UIImageView *_image1;
    UIImageView *_image2;
    UILabel     *_label1;
    UILabel     *_label2;
    UILabel     *_priceLabel1;
    UILabel     *_priceLabel2;
    UILabel     *_volume1;
    UILabel     *_volume2;
}

-(void)refreshCellWithDic1:(NSDictionary *)dic1 withDic2:(NSDictionary *)dic2;
@end
