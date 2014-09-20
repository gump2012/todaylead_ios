//
//  recommendCell.m
//  todayios
//
//  Created by gump on 8/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "recommendCell.h"
#import "shopTopDataSource.h"
#import "UIImageView+WebCache.h"
#import "searchListViewController.h"
#import "productDetailViewController.h"
@implementation recommendCell

@synthesize strkeyword = _strkeyword;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 10.0f, 100.0f, 40.0f)];
        [self.contentView addSubview:_nameLabel];
        _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake([CP shareInstance].w - 100.0f,
                                                             10.0f,
                                                              100.0f, 40.0f)];
        [_moreBtn setTitle:@"显示更多>>" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_moreBtn];
        _imageArr = [[NSMutableArray alloc] init];
        _labelArr = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)refreshCell
{
    NSDictionary *infodic = [[shopTopDataSource shareInstance].shopTopDic objectForKey:@"info"];
    if (infodic) {
        NSDictionary *datadic = [infodic objectForKey:@"data"];
        if (datadic) {
            NSDictionary *recommendDic = [datadic objectForKey:@"recommend"];
            if (recommendDic) {
                NSString *strname = [recommendDic objectForKey:@"name"];
                if (strname) {
                    _nameLabel.text = strname;
                }
                
                NSString *strkey = [recommendDic objectForKey:@"keyword"];
                _strkeyword = strkey;
                
                for (int i = 0; i < _imageArr.count; ++i) {
                    UIImageView *imgview = [_imageArr objectAtIndex:i];
                    [imgview removeFromSuperview];
                }
                
                [_imageArr removeAllObjects];
                
                for (int i = 0; i < _labelArr.count; ++i) {
                    UILabel *imgview = [_labelArr objectAtIndex:i];
                    [imgview removeFromSuperview];
                }
                
                [_labelArr removeAllObjects];
                
                NSArray *imagearr = [recommendDic objectForKey:@"product_list"];
                if (imagearr && [imagearr isKindOfClass:[NSArray class]]) {
                    if (imagearr.count > 0) {
                        float interval = [CP shareInstance].w / imagearr.count;
                        for (int i = 0; i < imagearr.count; ++i) {
                            NSDictionary *imageitme = [imagearr objectAtIndex:i];
                            
                            if (imageitme) {
                                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(i * interval,
                                                                                                       60.0f,
                                                                                                       interval,
                                                                                                       interval)];
                                NSString *strimage = [imageitme objectForKey:@"picture"];
                                if (strimage) {
                                    [imageview sd_setImageWithURL:[NSURL URLWithString:strimage]];
                                }
                                
                                strimage = [imageitme objectForKey:@"product_id"];
                                if (strimage) {
                                    imageview.tag = [strimage intValue];
                                    imageview.userInteractionEnabled=YES;
                                    UITapGestureRecognizer *singleTap =
                                    [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                   action:@selector(onClickImage:)];
                                    [imageview addGestureRecognizer:singleTap];
                                }
                                [self.contentView addSubview:imageview];
                                [_imageArr addObject:imageview];
                                
                                UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(i * interval, 130.0f, interval, 40.0f)];
                                namelabel.textAlignment = NSTextAlignmentCenter;
                                strimage = [imageitme objectForKey:@"name"];
                                if (strimage) {
                                    namelabel.text = strimage;
                                }
                                namelabel.textColor = [UIColor darkGrayColor];
                                [self.contentView addSubview:namelabel];
                                [_labelArr addObject:namelabel];
                            }
                        }
                    }
                }
            }
        }
    }
}

-(void)moreClick{
    if(self.selfctl){
        searchListViewController *searchview = [[searchListViewController alloc] init];
        searchview.strkeyword = _strkeyword;
        
        [self.selfctl.navigationController pushViewController:searchview animated:YES];
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
