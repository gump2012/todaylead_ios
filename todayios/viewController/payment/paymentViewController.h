//
//  paymentViewController.h
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "BaseViewController.h"
#import "cartEmptyView.h"
@class calculateView;
@interface paymentViewController : BaseViewController<
UITableViewDataSource, UITableViewDelegate
>
{
    cartEmptyView *_emptyView;
    UITableView   *_tableview;
    BOOL          _isEdit;
    calculateView *_calcuView;
}
@end
