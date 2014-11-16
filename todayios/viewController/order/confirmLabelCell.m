//
//  confirmLabelCell.m
//  todayios
//
//  Created by gump on 11/15/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "confirmLabelCell.h"

@implementation confirmLabelCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(4.0f, 4.0f,
                                                               [CP shareInstance].w - 8.0f
                                                               , CONFIRM_LABELCELL_HEIGHT - 8.0f)];
        [self.contentView addSubview:_textLabel];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"•保密配送，快递员不知商品内容\n\
•专业服务，发货前客服(4006-875-189)与你联系,送货前快递员会电话联系.请保持手机畅通"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1,4)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(17,4)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(28,12)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(61,4)];

        _textLabel.attributedText = str;
        _textLabel.numberOfLines = 0;
        _textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    return self;
}

@end
