//
//  adListCell.m
//  todayios
//
//  Created by lishiming on 14-7-29.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "adListCell.h"

@implementation adListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
        // 初始化 scrollview
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 460)];
        _scrollview.bounces = YES;
        _scrollview.pagingEnabled = YES;
        _scrollview.delegate = self;
        _scrollview.userInteractionEnabled = YES;
        _scrollview.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_scrollview];
        // 初始化 数组 并添加四张图片
        _slideImages = [[NSMutableArray alloc] init];
        // 初始化 pagecontrol
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(120,440,100,18)]; // 初始化mypagecontrol
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
        [_pageControl setPageIndicatorTintColor:[UIColor blackColor]];
        _pageControl.numberOfPages = [_slideImages count];
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
        [self.contentView addSubview:_pageControl];
        // 创建四个图片 imageview
        for (int i = 0;i<[_slideImages count];i++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_slideImages objectAtIndex:i]]];
            imageView.frame = CGRectMake((320 * i) + 320, 0, 300, 460);
            [_scrollview addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
        }
        // 取数组最后一张图片 放在第0页
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_slideImages objectAtIndex:([_slideImages count]-1)]]];
        imageView.frame = CGRectMake(0, 0, 300, 460); // 添加最后1页在首页 循环
        [_scrollview addSubview:imageView];
        // 取数组第一张图片 放在最后1页
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_slideImages objectAtIndex:0]]];
        imageView.frame = CGRectMake((320 * ([_slideImages count] + 1)) , 0, 300, 460); // 添加第1页在最后 循环
        [_scrollview addSubview:imageView];
        
        [_scrollview setContentSize:CGSizeMake(320 * ([_slideImages count] + 2), 460)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
        [_scrollview setContentOffset:CGPointMake(0, 0)];
        [_scrollview scrollRectToVisible:CGRectMake(320,0,300,460) animated:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
        [_scrollview scrollRectToVisible:CGRectMake(320 * [_slideImages count],0,300,460) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([_slideImages count]+1))
    {
        [_scrollview scrollRectToVisible:CGRectMake(320,0,300,460) animated:NO]; // 最后+1,循环第1页
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = _pageControl.currentPage; // 获取当前的page
    [_scrollview scrollRectToVisible:CGRectMake(320*(page+1),0,300,460) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    int page = _pageControl.currentPage; // 获取当前的page
    page++;
    page = page > 3 ? 0 : page ;
    _pageControl.currentPage = page;
    [self turnPage];
}

@end
