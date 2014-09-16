//
//  adListCell.h
//  todayios
//
//  Created by lishiming on 14-7-29.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//
@class BaseViewController;

@interface adListCell : BaseCell<UIScrollViewDelegate>
{
    UIScrollView        *_scrollview;
    NSMutableArray      *_slideImages;
    UIPageControl       *_pageControl;
    NSMutableArray      *_imageViewArr;
}

@property(assign,nonatomic) BaseViewController* selfctl;

@end
