//
//  AttrView.h
//  todayios
//
//  Created by gump on 9/11/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface AttrView : UIView
{
    UIImageView *_productView;
    UILabel     *_priceLabel;
    UILabel     *_attrLabel;
    UIScrollView    *_attrScrollView;
    NSMutableArray  *_arrView;
    UIView      *_numView;
    UILabel     *_numLabel;
    int         _buynum;
    CALayer     *_transitionLayer;
}

@property(nonatomic,copy) void(^disappearBlock)(void);
@property(nonatomic,copy) void(^sureBlock)(void);

-(void)refreshView;

@end
