//
//  ProGalleryCell.h
//  todayios
//
//  Created by gump on 9/2/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

@interface ProGalleryCell : BaseCell<UIScrollViewDelegate>
{
    UIScrollView        *_scrollview;
    NSMutableArray      *_slideImages;
    UIPageControl       *_pageControl;
    NSMutableArray      *_imageViewArr;
}
@end
