//
//  categoryListViewController.h
//  todayios
//
//  Created by gump on 9/21/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseViewController.h"
#import "EGORefreshTableFooterView.h"
@interface categoryListViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,
EGORefreshTableDelegate>
{
    int _icid;
    UITableView *_tableview;
    int _ilimit;
    int _ipage;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _reloading;
}

@property(nonatomic,assign) int icid;

- (id)initWithCategoryID:(int)icid;

@end
