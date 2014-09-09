//
//  commentView.m
//  todayios
//
//  Created by gump on 9/8/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "commentView.h"

@implementation commentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _namelabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 2.0f, 200.0f, 20.0f)];
        _namelabel.adjustsFontSizeToFitWidth = YES;
        _namelabel.textColor = [UIColor grayColor];
        [self addSubview:_namelabel];
        _contentlabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 24.0f, [CP shareInstance].w,40.0f)];
        _contentlabel.numberOfLines = 0;
        _contentlabel.adjustsFontSizeToFitWidth = YES;
        _contentlabel.textColor = [UIColor grayColor];
        [self addSubview:_contentlabel];
        _timelabel = [[UILabel alloc] initWithFrame:CGRectMake([CP shareInstance].w - 60.0f, 2.0f, 100.0f, 20.0f)];
        _timelabel.adjustsFontSizeToFitWidth = YES;
        _timelabel.font = [UIFont systemFontOfSize:10.0f];
        _timelabel.textColor = [UIColor grayColor];
        [self addSubview:_timelabel];
    }
    return self;
}

-(void)setTextWithDictionary:(NSDictionary*)dic
{
    if (dic) {
        NSString *str = [dic objectForKey:@"name"];
        if (str) {
            _namelabel.text = str;
        }
        
        str = [dic objectForKey:@"content"];
        if (str) {
            _contentlabel.text = str;
        }
        
        str = [dic objectForKey:@"create_time"];
        if (str) {
            long long itime = [str longLongValue];
            itime = itime / 1000;
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:itime];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"MM-dd HH:mm"];
            NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
            _timelabel.text = confromTimespStr;
        }
    }
}

@end
