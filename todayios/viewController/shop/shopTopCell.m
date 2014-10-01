//
//  shopTopCell.m
//  todayios
//
//  Created by gump on 8/21/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "shopTopCell.h"
#import "shopTopDataSource.h"
#import "UIImageView+WebCache.h"
#import "productDetailViewController.h"
#import "BaseViewController.h"
#import "topicListViewController.h"

@implementation shopTopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 10.0f, 200.0f, 40.0f)];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _imageArr = [[NSMutableArray alloc] init];
        _labelArr = [[NSMutableArray alloc] init];
        _iindex = -1;
        self.selfctl = nil;
        self.itopicid = 0;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

-(void)dealloc
{
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
    
    if (self.selfctl) {
        self.selfctl = nil;
    }
}

-(void)refreshCell
{
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
    
    NSArray *toparr = [[shopTopDataSource shareInstance] getToplist];
    if (toparr) {
        if (_iindex >= 0 && _iindex < toparr.count) {
            NSDictionary *topitem = [toparr objectAtIndex:_iindex];
            if (topitem) {
                NSString *strtitle = [topitem objectForKey:@"name"];
                if (strtitle) {
                    _titleLabel.text = strtitle;
                    _title = strtitle;
                }
                
                NSString *strtopimage = [topitem objectForKey:@"picture"];
                if (strtopimage) {
                    UIImageView *topimage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                          60.0f,
                                                                                          [CP shareInstance].w / 3 * 2,
                                                                                        [CP shareInstance].w / 3 * 2)];
                    [topimage sd_setImageWithURL:[NSURL URLWithString:strtopimage]];
                    topimage.userInteractionEnabled = YES;
                    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickTopic:)];
                    [topimage addGestureRecognizer:singleTap];
                    
                    [self.contentView addSubview:topimage];
                    [_imageArr addObject:topimage];
                }
                
                NSString *strtopicid = [topitem objectForKey:@"topic_id"];
                if (strtopicid) {
                    int itopic = [strtopicid intValue];
                    self.itopicid = itopic;
                }
                
                NSArray *toplist = [topitem objectForKey:@"product_list"];
                
                if (toplist && [toplist isKindOfClass:[NSArray class]]) {
                    if (toplist.count == 5) {
                        NSDictionary *item = [toplist objectAtIndex:0];
                        if (item) {
                            UIImageView *firstview = [[UIImageView alloc] initWithFrame:CGRectMake([CP shareInstance].w / 3 * 2,
                                                                                                   60.0f,
                                                                                                   [CP shareInstance].w / 3,
                                                                                                   [CP shareInstance].w / 3)];
                            NSString *strimage = [item objectForKey:@"picture"];
                            if (strimage) {
                                [firstview sd_setImageWithURL:[NSURL URLWithString:strimage]];
                                [self.contentView addSubview:firstview];
                                [_imageArr addObject:firstview];
                            }
                            NSString *strpid = [item objectForKey:@"product_id"];
                            firstview.tag = [strpid integerValue];
                            
                            firstview.userInteractionEnabled=YES;
                            UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
                            [firstview addGestureRecognizer:singleTap];
                            
                            strimage = [item objectForKey:@"name"];
                            if (strimage) {
                                baseLabel *namelabel = [[baseLabel alloc] initWithFrame:CGRectMake([CP shareInstance].w / 3 * 2,
                                                                                              130.0f,
                                                                                              [CP shareInstance].w / 3,
                                                                                               40.0f)];
                                namelabel.textColor = [UIColor darkGrayColor];
                                namelabel.textAlignment = NSTextAlignmentCenter;
                                namelabel.text = strimage;
                                [self.contentView addSubview:namelabel];
                                [_labelArr addObject:namelabel];
                            }
                        }
                        
                        item = [toplist objectAtIndex:1];
                        if (item) {
                            UIImageView *firstview = [[UIImageView alloc] initWithFrame:CGRectMake([CP shareInstance].w / 3 * 2,
                                                                                                   60.0f + [CP shareInstance].w / 3,
                                                                                                   [CP shareInstance].w / 3,
                                                                                                   [CP shareInstance].w / 3)];
                            NSString *strimage = [item objectForKey:@"picture"];
                            if (strimage) {
                                [firstview sd_setImageWithURL:[NSURL URLWithString:strimage]];
                                [self.contentView addSubview:firstview];
                                [_imageArr addObject:firstview];
                            }
                            NSString *strpid = [item objectForKey:@"product_id"];
                            firstview.tag = [strpid integerValue];
                            
                            firstview.userInteractionEnabled=YES;
                            UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
                            [firstview addGestureRecognizer:singleTap];
                            
                            strimage = [item objectForKey:@"name"];
                            if (strimage) {
                                baseLabel *namelabel = [[baseLabel alloc] initWithFrame:CGRectMake([CP shareInstance].w / 3 * 2,
                                                                                               130.0f + [CP shareInstance].w / 3,
                                                                                               [CP shareInstance].w / 3,
                                                                                               40.0f)];
                                namelabel.textColor = [UIColor darkGrayColor];
                                namelabel.textAlignment = NSTextAlignmentCenter;
                                namelabel.text = strimage;
                                [self.contentView addSubview:namelabel];
                                [_labelArr addObject:namelabel];
                            }
                        }
                        
                        for (int i = 2; i < toplist.count; ++i) {
                            item = [toplist objectAtIndex:i];
                            if (item) {
                                UIImageView *firstview = [[UIImageView alloc] initWithFrame:CGRectMake((i-2)*[CP shareInstance].w / 3,
                                                                                                       60.0f + [CP shareInstance].w / 3 *2,
                                                                                                       [CP shareInstance].w / 3,
                                                                                                       [CP shareInstance].w / 3)];
                                NSString *strimage = [item objectForKey:@"picture"];
                                if (strimage) {
                                    [firstview sd_setImageWithURL:[NSURL URLWithString:strimage]];
                                    [self.contentView addSubview:firstview];
                                    [_imageArr addObject:firstview];
                                }
                                NSString *strpid = [item objectForKey:@"product_id"];
                                firstview.tag = [strpid integerValue];
                                
                                firstview.userInteractionEnabled=YES;
                                UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
                                [firstview addGestureRecognizer:singleTap];
                                
                                strimage = [item objectForKey:@"name"];
                                if (strimage) {
                                    baseLabel *namelabel = [[baseLabel alloc] initWithFrame:CGRectMake((i-2)*[CP shareInstance].w / 3,
                                                                                                   130.0f + [CP shareInstance].w / 3*2,
                                                                                                   [CP shareInstance].w / 3,
                                                                                                   40.0f)];
                                    namelabel.textColor = [UIColor darkGrayColor];
                                    namelabel.textAlignment = NSTextAlignmentCenter;
                                    namelabel.text = strimage;
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

-(void)onClickTopic:(id)sender
{
    if(self.selfctl && self.itopicid != 0){
        topicListViewController *detailview = [[topicListViewController alloc] initWithTopicID:_itopicid];
        detailview.title = _title;
        [self.selfctl.navigationController pushViewController:detailview animated:YES];
    }
}

@end
