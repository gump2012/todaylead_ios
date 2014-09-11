//
//  AllSeeCell.m
//  todayios
//
//  Created by gump on 9/9/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "AllSeeCell.h"
#import "proRecommandDataSource.h"
#import "UIImageView+WebCache.h"
#import "productDetailViewController.h"

@implementation AllSeeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [CP shareInstance].w - 20.0f, 20.0f)];
        titel.text = @"大家都在看:";
        [self.contentView addSubview:titel];
        _imagearr = [[NSMutableArray alloc] init];
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(20.0f, 20.0f, [CP shareInstance].w - 20.0f, 140.0f)];
        _scrollview.pagingEnabled = YES;
        _scrollview.bounces = YES;
        _scrollview.userInteractionEnabled = YES;
        _scrollview.delegate = self;
        [self.contentView addSubview:_scrollview];
        self.selfctl = nil;
    }
    return self;
}

-(void)dealloc{
    for (int i = 0; i < _imagearr.count; ++i) {
        UIView *view = [_imagearr objectAtIndex:i];
        [view removeFromSuperview];
    }
    [_imagearr removeAllObjects];
}

-(void)refreshCell{
    NSArray *arr = [[proRecommandDataSource shareInstance] getArrData];
    if (arr) {
        for (int i = 0; i < _imagearr.count; ++i) {
            UIView *view = [_imagearr objectAtIndex:i];
            [view removeFromSuperview];
        }
        [_imagearr removeAllObjects];
        
        for (int i = 0; i < arr.count; ++i) {
            NSDictionary *dic = [arr objectAtIndex:i];
            if (dic) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * 112.0f, 0.0f, 112.0f, 140.0f)];
                NSString *strurl = [dic objectForKey:@"picture"];
                if (strurl) {
                    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
                    [imageview sd_setImageWithURL:[NSURL URLWithString:strurl]];
                    NSString *strpid = [dic objectForKey:@"product_id"];
                    if (strpid) {
                        imageview.tag = [strpid integerValue];
                        
                        imageview.userInteractionEnabled=YES;
                        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                                  action:@selector(onClickImage:)];
                        [imageview addGestureRecognizer:singleTap];
                    }
                    
                    [view addSubview:imageview];
                }
                
                NSString *strcontent = [dic objectForKey:@"name"];
                if (strcontent) {
                    UILabel *textlabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 100.0f, 100.0f, 20.0f)];
                    textlabel.numberOfLines = 0;
                    textlabel.font = [UIFont systemFontOfSize:8.0f];
                    textlabel.text = strcontent;
                    [view addSubview:textlabel];
                }
                
                NSString *strprice = [dic objectForKey:@"price"];
                if (strprice) {
                    UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 120.0f, 100.0f, 20.0f)];
                    float price = [strprice floatValue];
                    pricelabel.text = [NSString stringWithFormat:@"¥%0.2f",price];
                    pricelabel.textColor = [UIColor redColor];
                    pricelabel.textAlignment = NSTextAlignmentCenter;
                    [view addSubview:pricelabel];
                }
                [_scrollview addSubview:view];
                [_imagearr addObject:view];
            }
        }
        
        [_scrollview setContentSize:CGSizeMake(112 * arr.count, 140.0f)];
    }
}

-(void)onClickImage:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    UIView *view = (UIView*) tap.view;
    if(self.selfctl){
        productDetailViewController *detailview = [[productDetailViewController alloc] initWithPid:(int)view.tag];
        [self.selfctl.navigationController pushViewController:detailview animated:YES];
    }
}

@end
