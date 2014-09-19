//
//  topicListViewController.m
//  todayios
//
//  Created by gump on 9/19/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "topicListViewController.h"
#import "getTopicList.h"
#import "listDataSource.h"
#import "listProductCell.h"

@interface topicListViewController ()

@end

@implementation topicListViewController

@synthesize itopic = _itopic;

- (id)initWithTopicID:(int)itopic
{
    self = [super init];
    if (self) {
        _itopic = itopic;
        _ilimit = 10;
        _ipage = 1;
        
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(refreshlist:)
                       name:NotifyTopicList
                     object:nil];
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[CP shareInstance].mytabbar.tabBar setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[listDataSource shareInstance].dataDic removeAllObjects];
    [[httpManager shareInstance].topicList requestWithLimit:_ilimit withPage:_ipage withTopic:_itopic];
    [self.view addSubview:_tableview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshlist:(id)sender{
    [_tableview reloadData];
}

#pragma mark ----------tableview dataSource-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int itopcount = 0;
    NSArray *arr = [[listDataSource shareInstance] getArrData];
    if (arr && arr.count > 0) {
        itopcount = (int)(arr.count - 1) / 2 + 1;
    }
    return itopcount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"commoncell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    identifier = [NSString stringWithFormat:@"listcell"];
    listProductCell *listcell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (listcell == nil) {
        listcell = [[listProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSArray *arr = [[listDataSource shareInstance] getArrData];
    if (arr) {
        if (indexPath.row * 2 < arr.count) {
            NSDictionary *dic1 = [arr objectAtIndex:indexPath.row * 2];
            if (indexPath.row * 2 + 1 < arr.count) {
                NSDictionary *dic2 = [arr objectAtIndex:indexPath.row * 2 + 1];
                [listcell refreshCellWithDic1:dic1 withDic2:dic2];
            }else{
                [listcell refreshCellWithDic1:dic1 withDic2:nil];
            }
        }
    }
    
    return listcell;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
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
    CGFloat iheight = 220.0f;
    
    return iheight;
}

@end
