//
//  adListCell.h
//  todayios
//
//  Created by lishiming on 14-7-29.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adListCell : UITableViewCell<UIScrollViewDelegate>
{
    UIScrollView        *_scrollview;
    NSMutableArray      *_slideImages;
    UIPageControl       *_pageControl;
}
@end
