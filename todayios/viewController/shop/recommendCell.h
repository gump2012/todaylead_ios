//
//  recommendCell.h
//  todayios
//
//  Created by gump on 8/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseCell.h"
@class BaseViewController;

@interface recommendCell : BaseCell
{
    UILabel     *_nameLabel;
    UIButton    *_moreBtn;
    NSMutableArray  *_imageArr;
    NSString    *_strkeyword;
}

@property(nonatomic,strong) NSString *strkeyword;
@property(assign,nonatomic) BaseViewController* selfctl;

@end
