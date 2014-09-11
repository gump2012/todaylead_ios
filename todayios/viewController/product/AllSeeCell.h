//
//  AllSeeCell.h
//  todayios
//
//  Created by gump on 9/9/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseCell.h"
@class BaseViewController;
@interface AllSeeCell : BaseCell<UIScrollViewDelegate>
{
    NSMutableArray *_imagearr;
    UIScrollView *_scrollview;
}

@property(assign,nonatomic) BaseViewController* selfctl;

@end
