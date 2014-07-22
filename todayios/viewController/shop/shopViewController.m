//
//  shopViewController.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "shopViewController.h"
#import "getShopAdList.h"

@interface shopViewController ()

@end

@implementation shopViewController

- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(refreshAdlist:)
                       name:NotifyHttpRequestError
                     object:nil];
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[httpManager shareInstance].getshopad request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark ----------my function-----------------
-(void)refreshAdlist:(id)sender
{
    [_tableview reloadData];
}

@end
