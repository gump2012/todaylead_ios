//
//  payButtonView.h
//  todayios
//
//  Created by gump on 9/11/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

@interface payButtonView : UIView
{
    UIButton *_immediatelyBtn;
    UIButton *_addBtn;
    UIImageView *_cartView;
    UIImageView *_cartUnReadView;
    UILabel *_numberLabel;
}

@property(nonatomic,copy) void(^immediateBlock)(void);
@property(nonatomic,copy) void(^addBlock)(void);

-(void)setUnReadNumber:(int)inum;
@end
