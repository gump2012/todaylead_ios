//
//  receiveViewController.m
//  todayios
//
//  Created by gump on 11/20/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "receiveViewController.h"
#import "receiveEditCell.h"
#import "receiveAreaCell.h"
#import "confirmAddressDataSource.h"
#import "comfirmdb.h"

@interface receiveViewController ()

@end

@implementation receiveViewController

-(id)init{
    self = [super init];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(rightButtonClick:)];
        self.navigationItem.rightBarButtonItem = anotherButton;
        
        _addPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0,
                                                                      [CP shareInstance].h,
                                                                      [CP shareInstance].w,
                                                                      260)];
        _addPickView.delegate = self;
        
        [_addPickView selectRow:0 inComponent:0 animated:YES];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货信息";
    [self.view addSubview:_tableView];
    [self.view addSubview:_addPickView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)rightButtonClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popView:(id)sender {
    [self ViewAnimation:_addPickView willHidden:NO];
}

- (void)inView:(id)sender {
    [self ViewAnimation:_addPickView willHidden:YES];
    
}

- (void)ViewAnimation:(UIView*)view willHidden:(BOOL)hidden {
    
    [UIView animateWithDuration:0.3 animations:^{
        if (hidden) {
            view.frame = CGRectMake(0, [CP shareInstance].h, [CP shareInstance].w, 260);
        } else {
            [view setHidden:hidden];
            view.frame = CGRectMake(0, [CP shareInstance].h - 260, [CP shareInstance].w, 260);
        }
    } completion:^(BOOL finished) {
        [view setHidden:hidden];
    }];
}

#pragma mark ----------tableview dataSource-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int irow = 0;
    if (section == 0) {
        irow = 4;
    }
    return irow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"normalcell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            identifier = [NSString stringWithFormat:@"receiveEditcell"];
            receiveEditCell *rcell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (rcell == nil) {
                rcell = [[receiveEditCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:identifier];
                rcell.itag = 0;
                rcell.labelclick = ^(){
                    [self inView:_addPickView];
                };
                
                rcell.textclick = ^(){
                    [self inView:_addPickView];
                };
            }
            
            [rcell refreshCell:@"收 货 人:"];
            
            return rcell;
        }else if(indexPath.row == 1){
            identifier = [NSString stringWithFormat:@"receiveEditcell"];
            receiveEditCell *rcell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (rcell == nil) {
                rcell = [[receiveEditCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:identifier];
                rcell.itag = 1;
                rcell.labelclick = ^(){
                    [self inView:_addPickView];
                };
                
                rcell.textclick = ^(){
                    [self inView:_addPickView];
                };
            }
            
            [rcell refreshCell:@"手机号码:"];
            
            return rcell;
        }else if(indexPath.row == 2){
            identifier = [NSString stringWithFormat:@"receiveAreacell"];
            receiveAreaCell *rcell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (rcell == nil) {
                rcell = [[receiveAreaCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:identifier];
                rcell.clickblock = ^(){
                    if ([_addPickView isHidden]) {
                        [self popView:_addPickView];
                        [[NSNotificationCenter defaultCenter] postNotificationName:NotifyConfirmHideAddressPick object:nil];
                    }else{
                        [self inView:_addPickView];
                    }
                    
                };
                
                rcell.clicklabel = ^(){
                    [self inView:_addPickView];
                };
            }
            
            [rcell refreshCell];
            
            return rcell;
        }else if(indexPath.row == 3){
            identifier = [NSString stringWithFormat:@"receiveEditcell"];
            receiveEditCell *rcell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (rcell == nil) {
                rcell = [[receiveEditCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:identifier];
                rcell.itag = 3;
                rcell.labelclick = ^(){
                    [self inView:_addPickView];
                };
                
                rcell.textclick = ^(){
                    [self inView:_addPickView];
                };
            }
            
            [rcell refreshCell:@"详细地址:"];
            
            return rcell;
        }
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
    return 1;
}

#pragma mark ---------tableview delegate---------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat iheight = 44.0f;
    
    return iheight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
        }
    }
}

#pragma mark ------------pickerview delegate----------------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return [[confirmAddressDataSource shareInstance].proviceArr count];
            break;
            case 1:
        {
            return [[confirmAddressDataSource shareInstance].cityArr count];
        }
            break;
        case 2:{
            return [[confirmAddressDataSource shareInstance].areaArr count];
        }
            break;
            
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = @"";
    switch (component) {
        case 0:
        {
            if (row < [confirmAddressDataSource shareInstance].proviceArr.count) {
                NSDictionary *dic = [[confirmAddressDataSource shareInstance].proviceArr objectAtIndex:row];
                if (dic) {
                    str = [dic objectForKey:@"region_name"];
                }
            }
            
        }
            break;
        case 1:{
            if (row < [confirmAddressDataSource shareInstance].cityArr.count) {
                NSDictionary *dic = [[confirmAddressDataSource shareInstance].cityArr objectAtIndex:row];
                if (dic) {
                    str = [dic objectForKey:@"region_name"];
                }
            }
        }
            break;
        case 2:{
            if (row < [confirmAddressDataSource shareInstance].areaArr.count) {
                NSDictionary *dic = [[confirmAddressDataSource shareInstance].areaArr objectAtIndex:row];
                if (dic) {
                    str = [dic objectForKey:@"region_name"];
                }
            }
        }
            break;
        default:
            break;
    }
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            if (row < [confirmAddressDataSource shareInstance].proviceArr.count) {
                NSDictionary *dic = [[confirmAddressDataSource shareInstance].proviceArr objectAtIndex:row];
                if (dic) {
                    
                    [confirmAddressDataSource shareInstance].province = [dic objectForKey:@"region_name"];
                    
                    int iid = [[dic objectForKey:@"id"] intValue];
                    NSMutableArray *newarea = [[confirmAddressDataSource shareInstance] getArrByID:iid];
                    [[confirmAddressDataSource shareInstance].cityArr removeAllObjects];
                    [[confirmAddressDataSource shareInstance].cityArr setArray:newarea];
                    
                    if([confirmAddressDataSource shareInstance].cityArr.count > 0){
                        NSDictionary *areadic = [[confirmAddressDataSource shareInstance].cityArr objectAtIndex:0];
                        if (areadic) {
                            
                            [confirmAddressDataSource shareInstance].city = [areadic objectForKey:@"region_name"];
                            
                            int iareaid = [[areadic objectForKey:@"id"] intValue];
                            newarea = [[confirmAddressDataSource shareInstance] getArrByID:iareaid];
                            [[confirmAddressDataSource shareInstance].areaArr removeAllObjects];
                            [[confirmAddressDataSource shareInstance].areaArr setArray:newarea];
                            
                            if ([confirmAddressDataSource shareInstance].areaArr.count > 0) {
                                dic = [[confirmAddressDataSource shareInstance].areaArr objectAtIndex:0];
                                if (dic) {
                                    [confirmAddressDataSource shareInstance].area = [dic objectForKey:@"region_name"];
                                }
                            }
                        }
                    }
                    
                    [pickerView reloadComponent:1];
                    [pickerView reloadComponent:2];
                    
                    [pickerView selectRow:0 inComponent:1 animated:YES];
                    [pickerView selectRow:0 inComponent:2 animated:YES];
                }
            }
        }
            break;
        case 1:{
            if (row < [confirmAddressDataSource shareInstance].cityArr.count) {
                NSDictionary *dic = [[confirmAddressDataSource shareInstance].cityArr objectAtIndex:row];
                if (dic) {
                    
                    [confirmAddressDataSource shareInstance].city = [dic objectForKey:@"region_name"];
                    
                    int iid = [[dic objectForKey:@"id"] intValue];
                    NSMutableArray *newarea = [[confirmAddressDataSource shareInstance] getArrByID:iid];
                    [[confirmAddressDataSource shareInstance].areaArr removeAllObjects];
                    [[confirmAddressDataSource shareInstance].areaArr setArray:newarea];
                    
                    if ([confirmAddressDataSource shareInstance].areaArr.count > 0) {
                        dic = [[confirmAddressDataSource shareInstance].areaArr objectAtIndex:0];
                        if (dic) {
                            [confirmAddressDataSource shareInstance].area = [dic objectForKey:@"region_name"];
                        }
                    }
                    
                    [pickerView reloadComponent:2];
                    [pickerView selectRow:0 inComponent:2 animated:YES];
                }
            }
        }
            break;
        case 2:{
            if (row < [confirmAddressDataSource shareInstance].areaArr.count) {
                NSDictionary *dic = [[confirmAddressDataSource shareInstance].areaArr objectAtIndex:row];
                if (dic) {
                    [confirmAddressDataSource shareInstance].area = [dic objectForKey:@"region_name"];
                }
            }
        }
            break;
        default:
            break;
    }
    
    [_tableView reloadData];
}


@end
