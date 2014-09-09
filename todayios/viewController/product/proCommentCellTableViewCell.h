//
//  proCommentCellTableViewCell.h
//  todayios
//
//  Created by gump on 9/7/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface proCommentCell : BaseCell
{
    int _commentType;
    NSMutableArray *_arrCommentLabel;
    UIActivityIndicatorView *_ActivityView;
    UIView *_activeBg;
}

@property(nonatomic,copy) void(^clickblock)(void);

@end
