//
//  paymentViewController.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "paymentViewController.h"
#import "cartDataSource.h"
#import "getCartProductList.h"
#import "cartCell.h"

@interface paymentViewController ()

@end

@implementation paymentViewController

- (id)init{
    self = [super init];
    if (self) {
        _emptyView = [[cartEmptyView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
        
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(refreshCart:)
                       name:NotifyCartProductList
                     object:nil];
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 60.0f, [CP shareInstance].w, [CP shareInstance].h - 110)];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_emptyView];
    [self.view addSubview:_tableview];
    
    [self refreshUI];
}

-(void)refreshUI{
    if ([cartDataSource shareInstance].cartArr.count == 0) {
        _emptyView.hidden = NO;
        _tableview.hidden = YES;
    }else{
        _emptyView.hidden = YES;
        _tableview.hidden = NO;
        [_tableview reloadData];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[CP shareInstance].mytabbar.tabBar setHidden:NO];
    
    [[httpManager shareInstance].cartProList request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshCart:(id)sender{
    [[cartDataSource shareInstance] getCartListFromData];
    [self refreshUI];
}


#pragma mark ----------tableview dataSource-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int itopcount = (int)[cartDataSource shareInstance].cartArr.count;
    return itopcount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"cartcell"];
    cartCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[cartCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row < [cartDataSource shareInstance].cartArr.count) {
        [cell refreshCellWithDic:[[cartDataSource shareInstance].cartArr objectAtIndex:indexPath.row]];
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark ---------tableview delegate---------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat iheight = 95.0f;
    return iheight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
@end
