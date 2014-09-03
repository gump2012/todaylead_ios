//
//  proiceLabel.h
//  todayios
//
//  Created by gump on 9/3/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface proiceLabel : UILabel
{
    UILabel *_priceLabel;
    UILabel *_oldpriceLabel;
}

-(void)setProic:(float)fprice withOldPrice:(float)fold;
@end
