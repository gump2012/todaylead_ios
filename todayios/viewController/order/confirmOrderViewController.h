//
//  confirmOrderViewController.h
//  todayios
//
//  Created by gump on 11/15/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseViewController.h"

@interface confirmOrderViewController : BaseViewController<
UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableview;
}
@end
