//
//  AttrView.m
//  todayios
//
//  Created by gump on 9/11/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "AttrView.h"
#import "productDetailDataSource.h"
#import "UIImageView+WebCache.h"
#import "AttrCellView.h"

@implementation AttrView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.disappearBlock = nil;
        self.sureBlock = nil;
        self.userInteractionEnabled = YES;
        self.backgroundColor=[UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:0.5];
        UIButton *bgbtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 20.0f, [CP shareInstance].w, 60.0f)];
        [bgbtn addTarget:self action:@selector(bgclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgbtn];
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 60.0f,
                                                                  [CP shareInstance].w, [CP shareInstance].h - 60.0f)];
        //bgview.backgroundColor = [UIColor whiteColor];
        bgview.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        [self addSubview:bgview];
        
        _productView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 60.0f, 60.0f)];
        [bgview addSubview:_productView];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 10.0f, 200.0f, 30.0f)];
        _priceLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _priceLabel.textColor = [UIColor redColor];
        [bgview addSubview:_priceLabel];
        
        _attrLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 50.0f, 200.0f, 10.0f)];
        _attrLabel.font = [UIFont systemFontOfSize:10.0f];
        _attrLabel.textColor = [UIColor darkGrayColor];
        [bgview addSubview:_attrLabel];
        _attrLabel.text = @"请选择";
        
        UIButton *closebtn = [[UIButton alloc] initWithFrame:CGRectMake([CP shareInstance].w - 50.0f, 10.0f,40.0f,40.0f)];
        [closebtn setImage:[UIImage imageNamed:@"icon_clear_n.png"] forState:UIControlStateNormal];
        [closebtn addTarget:self action:@selector(bgclick) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:closebtn];
        
        _attrScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 80.0f, [CP shareInstance].w, 290.0f)];
        [bgview addSubview:_attrScrollView];
        
        _arrView = [[NSMutableArray alloc] init];
        
        _numView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, 80.0f)];
        UIImageView *topline = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 0.0f,
                                                                             [CP shareInstance].w - 20.0f, 0.5f)];
        [_numView addSubview:topline];
        UIImageView *bottomline = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f,
                                                                               80.0f,
                                                                                [CP shareInstance].w - 20.0f, 0.5f)];
        [_numView addSubview:bottomline];
        
        UILabel *numlabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 200.0f, 40.0f)];
        numlabel.textColor = [UIColor darkGrayColor];
        numlabel.text = @"购买数量";
        [_numView addSubview:numlabel];
        
        UIButton *subbtn = [[UIButton alloc] initWithFrame:CGRectMake(170.0, 10.0, 45.0, 50.0)];
        [subbtn setTitle:@"-" forState:UIControlStateNormal];
        [subbtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [subbtn addTarget:self action:@selector(subnum) forControlEvents:UIControlEventTouchUpInside];
        [_numView addSubview:subbtn];
        
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(215.0, 10.0f, 45.0f, 50.0f)];
        _numLabel.text = @"1";
        _numLabel.backgroundColor = [UIColor whiteColor];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.adjustsFontSizeToFitWidth = YES;
        [_numView addSubview:_numLabel];
        
        _buynum = 1;
        
        UIButton *addbtn = [[UIButton alloc] initWithFrame:CGRectMake(260.0, 10.0, 45.0, 50.0)];
        [addbtn setTitle:@"+" forState:UIControlStateNormal];
        [addbtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [addbtn addTarget:self action:@selector(addnum) forControlEvents:UIControlEventTouchUpInside];
        [_numView addSubview:addbtn];
        
        UIImageView *bottombg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 370.0, [CP shareInstance].w, 50.0f)];
        bottomline.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:231/255.0 alpha:1];
        [bgview addSubview:bottombg];
        
        UIButton *surebtn = [[UIButton alloc] initWithFrame:CGRectMake(106, 5.0f, 110.0, 40.0f)];
        surebtn.backgroundColor = [UIColor redColor];
        [surebtn addTarget:self action:@selector(sureclick) forControlEvents:UIControlEventTouchUpInside];
        [surebtn setTitle:@"确定" forState:UIControlStateNormal];
        surebtn.layer.cornerRadius = 5;
        surebtn.layer.masksToBounds = YES;
        [bottombg addSubview:surebtn];
        
        [self refreshView];
    }
    return self;
}

-(void)dealloc{
    for (int i = 0; i < _arrView.count; ++i) {
        UIView *view = [_arrView objectAtIndex:i];
        [view removeFromSuperview];
    }
    
    [_arrView removeAllObjects];
}

-(void)bgclick{
    if (self.disappearBlock) {
        self.disappearBlock();
    }
}

-(void)refreshView{
    NSDictionary *prodic = [[productDetailDataSource shareInstance] getDicData];
    if (prodic) {
        NSString *strproduct = [prodic objectForKey:@"picture"];
        if (strproduct) {
            [_productView sd_setImageWithURL:[NSURL URLWithString:strproduct]];
        }
        
        _priceLabel.text = [NSString stringWithFormat:@"¥%0.2f",[[productDetailDataSource shareInstance] getPrice]];
        
        NSArray *arr = [[productDetailDataSource shareInstance] getAttrList];
        if (arr) {
            
            for (int i = 0; i < _arrView.count; ++i) {
                UIView *view = [_arrView objectAtIndex:i];
                [view removeFromSuperview];
            }
            
            [_arrView removeAllObjects];
            
            int icount = 0;
            for (int i = 0; i < arr.count; ++i) {
                NSDictionary *attdic = [arr objectAtIndex:i];
                if (attdic && [attdic isKindOfClass:[NSDictionary class]]) {
                    NSString *strtype = [attdic objectForKey:@"type"];
                    if (strtype) {
                        int itype = [strtype integerValue];
                        if (itype == 1) {
                            AttrCellView *attview = [[AttrCellView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                                   44.0f * icount,
                                                                                                   [CP shareInstance].w,
                                                                                                   44.0f)];
                            attview.tag = i;
                            [attview setDic:attdic];
                            attview.clickblock = ^(NSDictionary *dic,int iindex){
                                [self clickcellWithDic:dic wihtIndex:iindex];
                            };
                            
                            [_attrScrollView addSubview:attview];
                            [_arrView addObject:attview];
                            icount++;
                        }
                    }
                }
            }
            
            if (_arrView.count == 1) {
                AttrCellView *view = [_arrView objectAtIndex:0];
                [view selectCell:YES];
                NSString *strvalue = [view.dic objectForKey:@"value"];
                if (strvalue) {
                    _attrLabel.text = strvalue;
                }
                
                NSString *strprice = [view.dic objectForKey:@"price"];
                if (strprice) {
                    float fprice = [[productDetailDataSource shareInstance] getPrice] + [strprice floatValue];
                    _priceLabel.text = [NSString stringWithFormat:@"¥%0.2f",fprice];
                }
                
            }
            
            
            [_numView removeFromSuperview];
            _numView.frame = CGRectMake(0.0f, 44.0f * icount, [CP shareInstance].w, 80.0f);
            [_attrScrollView addSubview:_numView];
            
            [_attrScrollView setContentSize:CGSizeMake([CP shareInstance].w, 44.0f * icount + 80.0f)];
        }
    }
}

-(void)addnum{
        _buynum++;
        _numLabel.text = [NSString stringWithFormat:@"%d",_buynum];
}

-(void)subnum{
    if (_buynum > 1) {
        _buynum--;
        _numLabel.text = [NSString stringWithFormat:@"%d",_buynum];
    }
}

-(void)sureclick{
    if (self.sureBlock) {
        self.sureBlock();
    }
}

-(void)clickcellWithDic:(NSDictionary *)dic wihtIndex:(int)iindex{
    for (int i = 0; i < _arrView.count; ++i) {
        AttrCellView *view = [_arrView objectAtIndex:i];
        if (view && [view isKindOfClass:[AttrCellView class]]) {
            if (view.tag == iindex) {
                [view selectCell:YES];
                if (dic) {
                    NSString *strvalue = [dic objectForKey:@"value"];
                    if (strvalue) {
                         _attrLabel.text = strvalue;
                    }
                    
                    NSString *strprice = [dic objectForKey:@"price"];
                    if (strprice) {
                        float fprice = [[productDetailDataSource shareInstance] getPrice] + [strprice floatValue];
                        _priceLabel.text = [NSString stringWithFormat:@"¥%0.2f",fprice];
                    }
                }
            }
            else{
                [view selectCell:NO];
            }
        }
    }
}

@end
