//
//  productDetailViewController.h
//  todayios
//
//  Created by gump on 8/23/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseViewController.h"
#import "proiceLabel.h"

@interface productDetailViewController : BaseViewController<
UITableViewDataSource, UITableViewDelegate
>
{
    UITableView     *_tableview;
    
    proiceLabel     *_priceLabel;
    UILabel         *_alreadySeeLabel;
    
    UILabel         *_baoyouLabel;
    UILabel         *_baoyouTextLabel;
}

@property(nonatomic,assign) int pid;

@end
