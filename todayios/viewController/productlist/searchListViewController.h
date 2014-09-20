//
//  searchListViewController.h
//  todayios
//
//  Created by gump on 9/16/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseViewController.h"
#import "EGORefreshTableFooterView.h"
@interface searchListViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,
EGORefreshTableDelegate>
{
    UITableView *_tableview;
    int _ipage;
    NSString *_strkeyword;
    BOOL _isLoadAll;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _reloading;
}

@property(nonatomic,strong) NSString *strkeyword;

@end
