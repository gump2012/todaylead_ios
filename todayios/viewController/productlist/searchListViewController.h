//
//  searchListViewController.h
//  todayios
//
//  Created by gump on 9/16/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseViewController.h"

@interface searchListViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableview;
    int _ipage;
    NSString *_strkeyword;
}

@property(nonatomic,strong) NSString *strkeyword;

@end
