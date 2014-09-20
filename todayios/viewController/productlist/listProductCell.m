//
//  listProductCell.m
//  todayios
//
//  Created by gump on 9/18/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "listProductCell.h"
#import "UIImageView+WebCache.h"
#import "productDetailViewController.h"

@implementation listProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _image1 = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 140.0f, 140.0f)];
        _image1.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
        [_image1 addGestureRecognizer:singleTap];
        [self.contentView addSubview:_image1];
        
        _image2 = [[UIImageView alloc] initWithFrame:CGRectMake(170.0f, 10.0f, 140.0f, 140.0f)];
        _image2.userInteractionEnabled = YES;
        singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
        [_image2 addGestureRecognizer:singleTap];
        [self.contentView addSubview:_image2];
        
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 160.0f, 150.0f, 20.0f)];
        [self.contentView addSubview:_label1];
        
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(170.0f, 160.0f, 150.0f, 20.0f)];
        [self.contentView addSubview:_label2];
        
        _priceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 180.0f, 70.0f, 30.0f)];
        _priceLabel1.textColor = [UIColor redColor];
        [self.contentView addSubview:_priceLabel1];
        
        _priceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(170.0f, 180.0f, 70.0f, 30.0f)];
        _priceLabel2.textColor = [UIColor redColor];
        [self.contentView addSubview:_priceLabel2];
        
        _volume1 = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 180.0f, 70.0f, 30.0f)];
        _volume1.textColor = [UIColor darkGrayColor];
        _volume1.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_volume1];
        
        _volume2 = [[UILabel alloc] initWithFrame:CGRectMake(250.0f, 180.0f, 70.0f, 30.0f)];
        _volume2.textColor = [UIColor darkGrayColor];
        _volume2.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_volume2];
        
        UIImageView *longline = [[UIImageView alloc] initWithFrame:CGRectMake(160.0f, 0.0f, 0.5f, 220.0f)];
        longline.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:longline];
        
        UIImageView *bottomline = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 220.0f, [CP shareInstance].w, 0.5f)];
        bottomline.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:bottomline];
        
        self.selfctl = nil;
     }
    return self;
}

-(void)refreshCellWithDic1:(NSDictionary *)dic1 withDic2:(NSDictionary *)dic2{
    NSString *str = [dic1 objectForKey:@"picture"];
    
    if (str) {
        [_image1 sd_setImageWithURL:[NSURL URLWithString:str]];
    }
    
    str = [dic1 objectForKey:@"product_id"];
    if (str) {
        _image1.tag = [str intValue];
    }
    
    str = [dic1 objectForKey:@"name"];
    if (str) {
        _label1.text = str;
    }
    
    str = [dic1 objectForKey:@"price"];
    if (str) {
        _priceLabel1.text = [NSString stringWithFormat:@"¥%0.2f",[str floatValue]];;
    }
    
    str = [dic1 objectForKey:@"recent_volume"];
    if (str) {
        _volume1.text = [NSString stringWithFormat:@"月销量 %d",[str intValue]];
    }
    
    if (dic2 == nil) {
        _image2.hidden = YES;
        _label2.hidden = YES;
        _priceLabel2.hidden = YES;
        _volume2.hidden = YES;
    }
    else{
        _image2.hidden = NO;
        _label2.hidden = NO;
        _priceLabel2.hidden = NO;
        _volume2.hidden = NO;
        
        str = [dic2 objectForKey:@"picture"];
        
        if (str) {
            [_image2 sd_setImageWithURL:[NSURL URLWithString:str]];
        }
        
        str = [dic2 objectForKey:@"product_id"];
        if (str) {
            _image2.tag = [str intValue];
        }
        
        str = [dic2 objectForKey:@"name"];
        if (str) {
            _label2.text = str;
        }
        
        str = [dic2 objectForKey:@"price"];
        if (str) {
            _priceLabel2.text = [NSString stringWithFormat:@"¥%0.2f",[str floatValue]];;
        }
        
        str = [dic2 objectForKey:@"recent_volume"];
        if (str) {
            _volume2.text = [NSString stringWithFormat:@"月销量 %d",[str intValue]];
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

@end
