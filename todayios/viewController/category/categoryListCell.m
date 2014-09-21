//
//  categoryListCell.m
//  todayios
//
//  Created by gump on 9/21/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "categoryListCell.h"
#import "UIImageView+WebCache.h"

@implementation categoryListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 40.0f, 40.0f)];
        [self.contentView addSubview:_imageview];
        _namelabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 10.0f, 200.0f, 20.0f)];
        [self.contentView addSubview:_namelabel];
        _describelabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 30.0f, [CP shareInstance].w - 60.0f, 20.0f)];
        _describelabel.textColor = [UIColor grayColor];
        _describelabel.font = [UIFont systemFontOfSize:10.0f];
        [self.contentView addSubview:_describelabel];
    }
    return self;
}

-(void)refreshCellWithDic:(NSDictionary *)dic{
    NSString *str = [dic objectForKey:@"picture"];
    if (str) {
        [_imageview sd_setImageWithURL:[NSURL URLWithString:str]];
    }
    str = [dic objectForKey:@"name"];
    if (str) {
        _namelabel.text = str;
    }
    str = [dic objectForKey:@"desc"];
    if (str) {
        _describelabel.text = str;
    }
    str = [dic objectForKey:@"category_id"];
    if (str) {
        self.tag = [str intValue];
    }
}

@end
