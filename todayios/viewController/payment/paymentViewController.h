//
//  paymentViewController.h
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "BaseViewController.h"
#import "cartEmptyView.h"

@interface paymentViewController : BaseViewController<
UITableViewDataSource, UITableViewDelegate
>
{
    cartEmptyView *_emptyView;
    UITableView   *_tableview;
}
@end
