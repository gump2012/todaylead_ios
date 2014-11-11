//
//  calculateView.h
//  todayios
//
//  Created by gump on 11/8/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CALCUCELL_H 44.0f
@interface calculateView : UIView
{
    UIImageView *_selectView;
    UILabel *_priceLabel;
    UILabel *_accountLabel;
    BOOL    _bDelete;
    UIImageView *_deleteView;
    BOOL    _bAllSel;
}

@property (nonatomic,copy) void (^selectAll)(BOOL);
@property (nonatomic,copy) void (^cartdelete)();
-(void)refreshUI:(BOOL)bDel;

@end
