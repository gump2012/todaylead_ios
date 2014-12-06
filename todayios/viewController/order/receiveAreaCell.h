//
//  receiveAreaCell.h
//  todayios
//
//  Created by gump on 12/2/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseCell.h"

@interface receiveAreaCell : BaseCell
{
    UILabel *_textLabel;
    UILabel *_areaLabel;
}

@property(nonatomic,copy) void(^clickblock)(void);
@property(nonatomic,copy) void(^clicklabel)(void);

@end
