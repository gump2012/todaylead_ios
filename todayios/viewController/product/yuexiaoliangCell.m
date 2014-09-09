//
//  yuexiaoliangCell.m
//  todayios
//
//  Created by gump on 9/8/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "yuexiaoliangCell.h"
#import "productDetailDataSource.h"
#import "productPromotionDataSource.h"
#import "UIImageView+WebCache.h"

@implementation yuexiaoliangCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _yuexiaoliangView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 24.0f, 24.0f)];
        _yuexiaoliangView.image = [UIImage imageNamed:@"icon_cod_volume.png"];
        _yuexiaoliangLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 150.0f, 20.0f)];
        _yuexiaoliangLabel.textColor = [UIColor grayColor];
        
        _7dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(176.0f, 10.0f, 150.0f, 20.0f)];
        _7dayLabel.textColor = [UIColor grayColor];
        _7dayView = [[UIImageView alloc] initWithFrame:CGRectMake(150.0f, 8.0f, 24.0f, 24.0f)];
        
        [self.contentView addSubview:_yuexiaoliangView];
        [self.contentView addSubview:_yuexiaoliangLabel];
        [self.contentView addSubview:_7dayLabel];
        [self.contentView addSubview:_7dayView];
    }
    return self;
}

-(void)refreshCell{
    int iv = [[productDetailDataSource shareInstance] getrecentvolume];
    _yuexiaoliangLabel.text = [NSString stringWithFormat:@"月销量%d件",iv];
    
    NSArray *arr = [[productPromotionDataSource shareInstance] getPromotionList];
    if (arr) {
        if (1 < arr.count) {
            NSDictionary *dic = [arr objectAtIndex:0];
            if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                _7dayLabel.text = [dic objectForKey:@"name"];
                NSString *strurl = [dic objectForKey:@"picture"];
                if (strurl) {
                    [_7dayView sd_setImageWithURL:[NSURL URLWithString:strurl]];
                }
            }
        }
    }

}

@end
