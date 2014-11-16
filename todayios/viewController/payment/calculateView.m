//
//  calculateView.m
//  todayios
//
//  Created by gump on 11/8/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "calculateView.h"
#import "cartDataSource.h"

@implementation calculateView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.userInteractionEnabled = YES;
        
        _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, (CALCUCELL_H - 18.0f)/2, 18.0f, 18.0f)];
        _selectView.image = [UIImage imageNamed:@"cb_circle_big_p.png"];
        _selectView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickSelectAll:)];
        [_selectView addGestureRecognizer:singleTap];
        [self addSubview:_selectView];
        
        UILabel *allLabel = [[UILabel alloc] initWithFrame:CGRectMake(28.0f, 12.0f, 40.0f, 20.0f)];
        allLabel.text = @"全选";
        allLabel.textColor = [UIColor grayColor];
        allLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:allLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 12.0f, 150.0f,20.0f)];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_priceLabel];
        
        UIImageView *accountView = [[UIImageView alloc] initWithFrame:CGRectMake([CP shareInstance].w - 100.0f, 0.0f, 100.0f, CALCUCELL_H)];
        accountView.backgroundColor = [UIColor redColor];
        accountView.userInteractionEnabled = YES;
        singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAccount:)];
        [accountView addGestureRecognizer:singleTap];
        [self addSubview:accountView];
        
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake([CP shareInstance].w - 100.0f,
                                                                  (CALCUCELL_H - 20.0f)/2,
                                                                  100.0f, 20.0f)];
        _accountLabel.backgroundColor = [UIColor clearColor];
        _accountLabel.textColor = [UIColor whiteColor];
        _accountLabel.textAlignment = NSTextAlignmentCenter;
        _accountLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_accountLabel];
        
        _deleteView = [[UIImageView alloc] initWithFrame:CGRectMake([CP shareInstance].w - 95.0f,
                                                                   (CALCUCELL_H - 20.0f)/2,
                                                                    20, 20)];
        _deleteView.image = [UIImage imageNamed:@"icon_delete_p.png"];
        [self addSubview:_deleteView];
        _bAllSel = YES;
        self.selectAll = nil;
        self.cartdelete = nil;
        self.cartAccount = nil;
    }
    
    return self;
}

-(void)refreshUI:(BOOL)bDel{
    _bDelete = bDel;
    _priceLabel.text = [NSString stringWithFormat:@"合计:%0.2f",[[cartDataSource shareInstance] getTotalPrice]];
    if (bDel) {
        _accountLabel.text = [NSString stringWithFormat:@"结算(%d)",[[cartDataSource shareInstance] getSelectCount]];
        _deleteView.hidden = YES;
    }
    else{
        _accountLabel.text = [NSString stringWithFormat:@"删除(%d)",[[cartDataSource shareInstance] getSelectCount]];
        _deleteView.hidden = NO;
    }
    
    if ([[cartDataSource shareInstance] getSelectCount] == [cartDataSource shareInstance].cartArr.count) {
        _bAllSel = YES;
        _selectView.image = [UIImage imageNamed:@"cb_circle_big_p.png"];
    }
    else{
        _bAllSel = NO;
        _selectView.image = [UIImage imageNamed:@"cb_circle_big_n.png"];
    }
}

-(void)onClickSelectAll:(id)sender{
    if (self.selectAll) {
        self.selectAll(_bAllSel);
    }
    
    [self refreshUI:_bDelete];
}

-(void)clickAccount:(id)sender{
    if (!_bDelete) {
        if (self.cartdelete) {
            self.cartdelete();
        }
    }else{
        if (self.cartAccount) {
            self.cartAccount();
        }
    }
}

@end
