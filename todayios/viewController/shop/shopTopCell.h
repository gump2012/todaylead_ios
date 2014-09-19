//
//  shopTopCell.h
//  todayios
//
//  Created by gump on 8/21/14.
//  Copyright (c) 2014 gump. All rights reserved.
//
@class BaseViewController;
#import "BaseCell.h"

@interface shopTopCell : BaseCell
{
    UILabel *_titleLabel;
    NSMutableArray *_imageArr;
    NSString *_title;
}

@property(assign,nonatomic) int iindex;
@property(assign,nonatomic) int itopicid;
@property(assign,nonatomic) BaseViewController* selfctl;

@end
