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
    UILabel         *_titleLabel;
    
    proiceLabel     *_priceLabel;
    UILabel         *_alreadySeeLabel;
    
    UILabel         *_baoyouLabel;
    UILabel         *_baoyouTextLabel;
    
    UIImageView     *_yuexiaoliangView;
    UILabel         *_yuexiaoliangLabel;
    UILabel         *_7dayLabel;
    UIImageView     *_7dayView;
}

@property(nonatomic,assign) int pid;

@end
