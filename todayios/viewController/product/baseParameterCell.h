//
//  baseParameterCell.h
//  todayios
//
//  Created by gump on 9/9/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseCell.h"

@interface baseParameterCell : BaseCell
{
    NSMutableArray *_labelarr;
}

@property(nonatomic,copy) void(^clickblock)(void);

@end
