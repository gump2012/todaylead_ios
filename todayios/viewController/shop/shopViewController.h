//
//  shopViewController.h
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "BaseViewController.h"

@interface shopViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableview;
}
@end
