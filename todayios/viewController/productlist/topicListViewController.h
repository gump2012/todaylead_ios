//
//  topicListViewController.h
//  todayios
//
//  Created by gump on 9/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseViewController.h"
#import "EGORefreshTableFooterView.h"
@interface topicListViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,
EGORefreshTableDelegate>
{
    int _itopic;
    UITableView *_tableview;
    int _ilimit;
    int _ipage;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _reloading;
}

@property(nonatomic,assign) int itopic;

- (id)initWithTopicID:(int)itopic;

@end
