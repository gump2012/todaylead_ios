//
//  categoryViewController.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "categoryViewController.h"
#import "getCategoryList.h"
#import "categoryListDataSource.h"
#import "categoryListCell.h"
#import "categoryListViewController.h"

@interface categoryViewController ()

@end

@implementation categoryViewController

- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(refreshlist:)
                       name:NotifyCategoryList
                     object:nil];
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
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
    [self.view addSubview:_tableview];
    [[httpManager shareInstance].categoryList request];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[CP shareInstance].mytabbar.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark --------------my function-------------------
-(void)refreshlist:(id)sender
{
    [_tableview reloadData];
}

#pragma mark ----------tableview dataSource-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int itopcount = 0;
    NSArray *arr = [[categoryListDataSource shareInstance] getArrData];
    if (arr) {
        itopcount = arr.count;
    }
    return itopcount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"categorylistcell"];
    categoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil) {
        cell = [[categoryListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSArray *arr = [[categoryListDataSource shareInstance] getArrData];
    if (arr) {
        if (indexPath.row < arr.count) {
            NSDictionary *dic = [arr objectAtIndex:indexPath.row];
            if (dic) {
                [cell refreshCellWithDic:dic];
            }
        }
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
    CGFloat iheight = 60.0f;
    return iheight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    categoryListViewController *listview = [[categoryListViewController alloc] initWithCategoryID:cell.tag];
    NSArray *arr = [[categoryListDataSource shareInstance] getArrData];
    if (arr) {
        if (indexPath.row < arr.count) {
            NSDictionary *dic = [arr objectAtIndex:indexPath.row];
            if (dic) {
                NSString *strname = [dic objectForKey:@"name"];
                listview.title = strname;
            }
        }
    }
    [self.navigationController pushViewController:listview animated:YES];
}
@end
