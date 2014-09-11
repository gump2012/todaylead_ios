//
//  ProGalleryCell.m
//  todayios
//
//  Created by gump on 9/2/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "ProGalleryCell.h"
#import "UIImageView+WebCache.h"
#import "productDetailDataSource.h"

@implementation ProGalleryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [CP shareInstance].w, [CP shareInstance].w)];
        _scrollview.bounces = YES;
        _scrollview.pagingEnabled = YES;
        _scrollview.delegate = self;
        _scrollview.userInteractionEnabled = YES;
        _scrollview.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_scrollview];
        // 初始化 数组 并添加四张图片
        _slideImages = [[NSMutableArray alloc] init];
        _imageViewArr = [[NSMutableArray alloc] init];
        // 初始化 pagecontrol
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(120,280,100,18)]; // 初始化mypagecontrol
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
        [_pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
        _pageControl.numberOfPages = [_slideImages count];
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
        [self.contentView addSubview:_pageControl];
        // 创建四个图片 imageview
        for (int i = 0;i<[_slideImages count];i++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((320 * i) + 320, 0, [CP shareInstance].w, [CP shareInstance].w)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[_slideImages objectAtIndex:i]]];
            [_scrollview addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
            [_imageViewArr addObject:imageView];
        }
        // 取数组最后一张图片 放在第0页
        if (_slideImages.count > 0) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [CP shareInstance].w, [CP shareInstance].w)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[_slideImages objectAtIndex:([_slideImages count]-1)]]];
            [_scrollview addSubview:imageView];
            [_imageViewArr addObject:imageView];
            // 取数组第一张图片 放在最后1页
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake((320 * ([_slideImages count] + 1)) , 0, [CP shareInstance].w, [CP shareInstance].w)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[_slideImages objectAtIndex:0]]];
            [_scrollview addSubview:imageView];
            [_imageViewArr addObject:imageView];
            
            [_scrollview setContentSize:CGSizeMake(320 * ([_slideImages count] + 2), [CP shareInstance].w)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
        }
        
        [_scrollview setContentOffset:CGPointMake(0, 0)];
        [_scrollview scrollRectToVisible:CGRectMake(320,0,[CP shareInstance].w, [CP shareInstance].w) animated:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)dealloc
{
    for (int i = 0; i < _imageViewArr.count; ++i) {
        UIImageView *imgview = [_imageViewArr objectAtIndex:i];
        [imgview removeFromSuperview];
    }
    
    [_imageViewArr removeAllObjects];
}

-(void)refreshCell
{
            NSDictionary *datadic = [[productDetailDataSource shareInstance] getDicData];
            if (datadic && [datadic isKindOfClass:[NSDictionary class]]) {
                
                NSArray *galleryarr = [datadic objectForKey:@"gallery"];
                if (galleryarr && [galleryarr isKindOfClass:[NSArray class]]) {
                    [_slideImages removeAllObjects];
                    for (int i = 0; i < galleryarr.count; ++i) {
                        [_slideImages addObject:[galleryarr objectAtIndex:i]];
                    }
                    
                    _pageControl.numberOfPages = [_slideImages count];
                    for (int i = 0; i < _imageViewArr.count; ++i) {
                        UIImageView *imgview = [_imageViewArr objectAtIndex:i];
                        [imgview removeFromSuperview];
                    }
                    
                    [_imageViewArr removeAllObjects];
                    
                    for (int i = 0;i<[_slideImages count];i++)
                    {
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((320 * i) + 320, 0, [CP shareInstance].w, [CP shareInstance].w)];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:[_slideImages objectAtIndex:i]]];
                        [_scrollview addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
                        [_imageViewArr addObject:imageView];
                    }
                    // 取数组最后一张图片 放在第0页
                    if (_slideImages.count > 0) {
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [CP shareInstance].w, [CP shareInstance].w)];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:[_slideImages objectAtIndex:([_slideImages count]-1)]]];
                        [_scrollview addSubview:imageView];
                        [_imageViewArr addObject:imageView];
                        // 取数组第一张图片 放在最后1页
                        imageView = [[UIImageView alloc] initWithFrame:CGRectMake((320 * ([_slideImages count] + 1)) ,
                                                                                  0,
                                                                                  [CP shareInstance].w,
                                                                                  [CP shareInstance].w)];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:[_slideImages objectAtIndex:0]]];
                        [_scrollview addSubview:imageView];
                        [_imageViewArr addObject:imageView];
                        
                        [_scrollview setContentSize:CGSizeMake(320 * ([_slideImages count] + 2), [CP shareInstance].w)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
                    }
                }
            }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = _scrollview.frame.size.width;
    int page = floor((_scrollview.contentOffset.x - pagewidth/([_slideImages count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    _pageControl.currentPage = page;
}

// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = _scrollview.frame.size.width;
    int currentPage = floor((_scrollview.contentOffset.x - pagewidth/ ([_slideImages count]+2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
    //    NSLog(@"currentPage_==%d",currentPage_);
    if (currentPage==0)
    {
        [_scrollview scrollRectToVisible:CGRectMake(320 * [_slideImages count],0,[CP shareInstance].w, [CP shareInstance].w) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([_slideImages count]+1))
    {
        [_scrollview scrollRectToVisible:CGRectMake(320,0,[CP shareInstance].w, [CP shareInstance].w) animated:NO]; // 最后+1,循环第1页
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    long  page = _pageControl.currentPage; // 获取当前的page
    [_scrollview scrollRectToVisible:CGRectMake(320*(page+1),0,[CP shareInstance].w, [CP shareInstance].w) animated:NO];
    // 触摸pagecontroller那个点点 往后翻一页 +1
}
@end
