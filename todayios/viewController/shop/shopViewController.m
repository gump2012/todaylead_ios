//
//  shopViewController.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "shopViewController.h"
#import "getShopAdList.h"
#import "adListCell.h"
#import "shopTopDataSource.h"
#import "getShopTop.h"
#import "recommendCell.h"

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
                       name:NotifyRefreshShopAd
                     object:nil];
        
        [center addObserver:self
                   selector:@selector(refreshToplist:)
                       name:NotifyRefreshShopTop
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_tableview];
    self.title = @"今日头牌";
    
    [[httpManager shareInstance].getshopad request];
    [[httpManager shareInstance].getshoptop request];
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

-(void)refreshToplist:(id)sender
{
    [_tableview reloadData];
}

#pragma mark ----------tableview dataSource-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int itopcount = 0;
    NSArray *listarr = [[shopTopDataSource shareInstance] getToplist];
    if (listarr) {
        itopcount += listarr.count;
    }
    return 2 + itopcount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"commoncell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    switch (indexPath.row) {
        case 0:
        {
            identifier = [NSString stringWithFormat:@"adlistcell"];
            adListCell *adcell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (adcell == nil) {
                adcell = [[adListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            [adcell refreshCell];
            
            return adcell;
        }
            break;
        case 1:
        {
            identifier = [NSString stringWithFormat:@"recommendcell"];
            recommendCell *recomcell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (recomcell == nil) {
                recomcell = [[recommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            [recomcell refreshCell];
            return recomcell;
        }
            break;
            
        default:
            break;
    }
    
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
    CGFloat iheight = 44.0f;
    switch (indexPath.row) {
        case 0:
        {
            iheight = 140.0f;
        }
            break;
        case 1:
        {
            iheight = 60.0f + [CP shareInstance].w / 3;
        }
            break;
        case 2:
        {
            iheight = 0.0f;
        }
            break;
        default:
        {
            iheight = 0.0f;
        }
            break;
    }
    return iheight;
}
@end
