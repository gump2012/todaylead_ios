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
#import "calculateView.h"

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
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 60.0f,
                                                                   [CP shareInstance].w,
                                                                   [CP shareInstance].h - 110 - CALCUCELL_H)];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(rightButtonClick:)];
        self.navigationItem.rightBarButtonItem = anotherButton;
        
        anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(leftButtonClick:)];
        self.navigationItem.leftBarButtonItem = anotherButton;
        _isEdit = YES;
        
        _calcuView = [[calculateView alloc] initWithFrame:CGRectMake(0.0f,
                                                                     [CP shareInstance].h - 50.0f - CALCUCELL_H,
                                                                     [CP shareInstance].w,
                                                                     CALCUCELL_H)];
        
        __block typeof (self) bself = self;
        _calcuView.selectAll = ^(BOOL ballSel){
            [bself clickAllSelect:ballSel];
        };
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
    [self.view addSubview:_calcuView];
    
    [self refreshUI];
}

-(void)rightButtonClick:(id)sender{
    if (_isEdit) {
        _isEdit = NO;
        self.navigationItem.rightBarButtonItem.title = @"保存";
        
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(leftButtonClick:)];
        self.navigationItem.leftBarButtonItem = anotherButton;
        
        [_calcuView refreshUI:_isEdit];
    }
    else{
        _isEdit = YES;
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        self.navigationItem.leftBarButtonItem = nil;
        
        [_calcuView refreshUI:_isEdit];
    }
    
    [_tableview reloadData];
}

-(void)leftButtonClick:(id)sender{
    self.navigationItem.leftBarButtonItem = nil;
    
    _isEdit = YES;
    self.navigationItem.rightBarButtonItem.title = @"编辑";
    
    [_tableview reloadData];
}

-(void)refreshUI{
    if ([cartDataSource shareInstance].cartArr.count == 0) {
        _emptyView.hidden = NO;
        _tableview.hidden = YES;
        _calcuView.hidden = YES;
        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
    }else{
        _isEdit = YES;
        _emptyView.hidden = YES;
        _tableview.hidden = NO;
        _calcuView.hidden = NO;
        [_tableview reloadData];
        [_calcuView refreshUI:_isEdit];
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        self.navigationItem.leftBarButtonItem = nil;
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

-(void)clickAllSelect:(BOOL)bAllSel{
    [[cartDataSource shareInstance] AllSelect:bAllSel];
    [_tableview reloadData];
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
        cell.cellselect = ^{
            [_calcuView refreshUI:_isEdit];
        };
    }
    
    if (indexPath.row < [cartDataSource shareInstance].cartArr.count) {
        [cell refreshCellWithCart:[[cartDataSource shareInstance].cartArr objectAtIndex:indexPath.row] withIsEdit:_isEdit];
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
