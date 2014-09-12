//
//  AttrCellView.m
//  todayios
//
//  Created by gump on 9/12/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "AttrCellView.h"
@implementation AttrCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 2.0f, [CP shareInstance].w - 40.0f, 40.0f)];
        _textLabel.backgroundColor = [UIColor whiteColor];
        _textLabel.userInteractionEnabled = YES;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.adjustsFontSizeToFitWidth = YES;
        _textLabel.layer.cornerRadius = 5;
        _textLabel.layer.masksToBounds = YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
        [_textLabel addGestureRecognizer:singleTap];
        [self addSubview:_textLabel];
        
        self.clickblock = nil;
    }
    return self;
}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    if (dic) {
        NSString *strvalue = [_dic objectForKey:@"value"];
        if (strvalue) {
            _textLabel.text = strvalue;
        }
    }
}

-(void)onClick:(id)sender
{
    if (self.clickblock) {
        self.clickblock(_dic,(int)self.tag);
    }
}

-(void)selectCell:(BOOL)bselect{
    if (bselect) {
        _textLabel.backgroundColor = [UIColor purpleColor];
    }
    else{
        _textLabel.backgroundColor = [UIColor whiteColor];
    }
}

@end
