//
//  baseParameterCell.m
//  todayios
//
//  Created by gump on 9/9/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseParameterCell.h"
#import "productDetailDataSource.h"

@implementation baseParameterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *arror = [[UIImageView alloc] initWithFrame:CGRectMake(294.0f, 12.0f, 15.0f, 18.0f)];
        arror.image = [UIImage imageNamed:@"btn_arrow.png"];
        [self.contentView addSubview:arror];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(16.0f, 7.0f, 30.0f, 30.0f)];
        imageview.image = [UIImage imageNamed:@"icon_cod_commonparam.png"];
        [self.contentView addSubview:imageview];
        
        UILabel *textlabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 10.0f, 200.0f, 20.0f)];
        textlabel.text = @"基本参数";
        textlabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:textlabel];
        
        UIButton *clickbtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, 44.0f)];
        [clickbtn addTarget:self action:@selector(clickcell) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:clickbtn];
        
        _labelarr = [[NSMutableArray alloc] init];
        
        self.clickblock = nil;
    }
    return self;
}

-(void)dealloc{
    for (int i = 0; i < _labelarr.count; ++i) {
        UIView *view = [_labelarr objectAtIndex:i];
        [view removeFromSuperview];
    }
    
    [_labelarr removeAllObjects];
}

-(void)refreshCell{
    if ([productDetailDataSource shareInstance].ibaseAttr == BASEATTR_HIDE) {
        for (int i = 0; i < _labelarr.count; ++i) {
            UIView *view = [_labelarr objectAtIndex:i];
            [view removeFromSuperview];
        }
        
        [_labelarr removeAllObjects];
    }
    else if([productDetailDataSource shareInstance].ibaseAttr == BASEATTR_SHOW){
        for (int i = 0; i < _labelarr.count; ++i) {
            UIView *view = [_labelarr objectAtIndex:i];
            [view removeFromSuperview];
        }
        
        [_labelarr removeAllObjects];
        
        NSArray *attrarr = [[productDetailDataSource shareInstance] getAttrList];
        if (attrarr) {
            int iindex = 0;
            
            for (int i = 0; i < attrarr.count; ++i) {
                NSDictionary *attrdic = [attrarr objectAtIndex:i];
                
                if (attrdic && [attrdic isKindOfClass:[NSDictionary class]]) {
                    NSString *strtype = [attrdic objectForKey:@"type"];
                    int itype = [strtype integerValue];
                    if (itype == 0) {
                        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                44.0f + 20.0f * iindex,
                                                                                [CP shareInstance].w, 20.0f)];
                        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [CP shareInstance].w - 20.0f, 20.0f)];
                        name.textColor = [UIColor grayColor];
                        name.adjustsFontSizeToFitWidth = YES;
                        NSString *strname = [attrdic objectForKey:@"name"];
                        NSString *strvalue = [attrdic objectForKey:@"value"];
                        if (strname && strvalue) {
                            name.text = [NSString stringWithFormat:@"%@ : %@",strname,strvalue];
                        }
                        [view addSubview:name];
                        [self.contentView addSubview:view];
                        [_labelarr addObject:view];
                        iindex++;
                    }
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
