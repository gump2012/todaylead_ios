//
//  confirmOrderViewController.m
//  todayios
//
//  Created by gump on 11/15/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "confirmOrderViewController.h"
#import "confirmLabelCell.h"
#import "confirmTakeGoodCell.h"
#import "confirmPayCell.h"
#import "receiveViewController.h"

@interface confirmOrderViewController ()

@end

@implementation confirmOrderViewController

-(id)init{
    self = [super init];
    if (self) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    
        self.title = @"确认订单";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_tableview];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[CP shareInstance].mytabbar.tabBar setHidden:YES];
    [_tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)makeACall{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006875189"]];
}

#pragma mark ----------tableview dataSource-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 1;
    }
    else if(section == 2){
        return 2;
    }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"收货信息";
    }else if(section == 2){
        return @"支付方式";
    }
    else{
        return @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"normalcell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            identifier = [NSString stringWithFormat:@"conLabelcell"];
            confirmLabelCell *confircell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (confircell == nil) {
                confircell = [[confirmLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            return confircell;
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            identifier = [NSString stringWithFormat:@"conTakecell"];
            confirmTakeGoodCell *confircell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (confircell == nil) {
                confircell = [[confirmTakeGoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            [confircell refreshCell];
            
            return confircell;
        }
    }else if(indexPath.section == 2){
            identifier = [NSString stringWithFormat:@"conPaycell"];
            confirmPayCell *confircell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (confircell == nil) {
                confircell = [[confirmPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            [confircell refreshCell];
            
            return confircell;
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark ---------tableview delegate---------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat iheight = 44.0f;
    if (indexPath.section == 0) {
        iheight = CONFIRM_LABELCELL_HEIGHT;
    }else if(indexPath.section == 1){
        iheight = CONFIRM_LABELCELL_HEIGHT;
    }
    
    return iheight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self makeACall];
        }
    }
    else if(indexPath.section == 1){
        receiveViewController *receiveView = [[receiveViewController alloc] init];
        [self.navigationController pushViewController:receiveView animated:YES];
    }
}

@end
