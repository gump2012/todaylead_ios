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
}

@property(nonatomic,copy) void(^immediateBlock)(void);
@property(nonatomic,copy) void(^addBlock)(void);
@end
