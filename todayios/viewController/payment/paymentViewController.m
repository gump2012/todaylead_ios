//
//  paymentViewController.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "paymentViewController.h"
#import "cartDataSource.h"

@interface paymentViewController ()

@end

@implementation paymentViewController

- (id)init{
    self = [super init];
    if (self) {
        _emptyView = [[cartEmptyView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_emptyView];
    
    if ([cartDataSource shareInstance].cartArr.count == 0) {
        _emptyView.hidden = NO;
    }else{
        _emptyView.hidden = YES;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[CP shareInstance].mytabbar.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
