//
//  proCommentCellTableViewCell.m
//  todayios
//
//  Created by gump on 9/7/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "proCommentCellTableViewCell.h"
#import "proCommentDataSource.h"
#import "commentView.h"

@implementation proCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _arrCommentLabel = [[NSMutableArray alloc] init];
        _ActivityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_ActivityView setCenter:CGPointMake([CP shareInstance].w/2, 22)];//指定进度轮中心点
        [_ActivityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        _activeBg = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, [CP shareInstance].w, 44.0f)];
        _activeBg.backgroundColor = [UIColor whiteColor];
        [_activeBg addSubview:_ActivityView];
        [self.contentView addSubview:_activeBg];
        
        UIImageView *arror = [[UIImageView alloc] initWithFrame:CGRectMake(294.0f, 12.0f, 15.0f, 18.0f)];
        arror.image = [UIImage imageNamed:@"btn_arrow.png"];
        [self.contentView addSubview:arror];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 7.0f, 30.0f, 30.0f)];
        imageview.image = [UIImage imageNamed:@"icon_cod_review.png"];
        [self.contentView addSubview:imageview];
        
        UILabel *textlabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 10.0f, 200.0f, 20.0f)];
        textlabel.text = @"商品评价";
        [self.contentView addSubview:textlabel];
        
        UIButton *clickbtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, 44.0f)];
        [clickbtn addTarget:self action:@selector(clickcell) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:clickbtn];
        
        self.clickblock = nil;
    }
    return self;
}

-(void)dealloc{
    [_ActivityView stopAnimating];
    for (int i = 0; i < _arrCommentLabel.count; ++i) {
        commentView *view = [_arrCommentLabel objectAtIndex:i];
        [view removeFromSuperview];
    }
    [_arrCommentLabel removeAllObjects];
}

-(void)refreshCell
{
    int itype = [proCommentDataSource shareInstance].commentType;
    if (itype == COMMENT_HIDE) {
        for (int i = 0; i < _arrCommentLabel.count; ++i) {
            commentView *view = [_arrCommentLabel objectAtIndex:i];
            [view removeFromSuperview];
        }
        [_arrCommentLabel removeAllObjects];
        [_ActivityView stopAnimating];
        _activeBg.hidden = YES;
    }
    else if(itype == COMMENT_READYSHOW){
        for (int i = 0; i < _arrCommentLabel.count; ++i) {
            commentView *view = [_arrCommentLabel objectAtIndex:i];
            [view removeFromSuperview];
        }
        [_arrCommentLabel removeAllObjects];
        _activeBg.hidden = NO;
        [_ActivityView startAnimating];
    }else if(itype == COMMENT_SHOW){
        for (int i = 0; i < _arrCommentLabel.count; ++i) {
            commentView *view = [_arrCommentLabel objectAtIndex:i];
            [view removeFromSuperview];
        }
        [_arrCommentLabel removeAllObjects];
        [_ActivityView stopAnimating];
        _activeBg.hidden = YES;
        
        NSArray *arr = [[proCommentDataSource shareInstance] getArrData];
        if (arr && [arr isKindOfClass:[NSArray class]]) {
            for (int i = 0; i < arr.count; ++i) {
                NSDictionary *dic = [arr objectAtIndex:i];
                if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                    commentView *cv = [[commentView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                   44.0f + i * 64.0f,
                                                                                    [CP shareInstance].w, 64.0f)];
                    [cv setTextWithDictionary:dic];
                    
                    [self.contentView addSubview:cv];
                    [_arrCommentLabel addObject:cv];
                }
            }
        }
    }
}

-(void)clickcell{
    if (self.clickblock) {
        self.clickblock();
    }
}

@end
