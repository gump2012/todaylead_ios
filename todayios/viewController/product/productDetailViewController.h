//
//  productDetailViewController.h
//  todayios
//
//  Created by gump on 8/23/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseViewController.h"

@class payButtonView;
@class AttrView;

@interface productDetailViewController : BaseViewController<
UITableViewDataSource, UITableViewDelegate
>
{
    UITableView     *_tableview;
    UILabel         *_baoyouLabel;
    UILabel         *_baoyouTextLabel;
    payButtonView   *_paybtnview;
    AttrView        *_attrview;
}

-(id)initWithPid:(int)ipid;

@property(nonatomic,assign) int pid;

@end
