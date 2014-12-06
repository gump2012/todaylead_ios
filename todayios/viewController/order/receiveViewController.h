//
//  receiveViewController.h
//  todayios
//
//  Created by gump on 11/20/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseViewController.h"

@interface receiveViewController : BaseViewController<
UITableViewDataSource, UITableViewDelegate,UIPickerViewDelegate>
{
    UITableView *_tableView;
    UIPickerView *_addPickView;
}
@end
