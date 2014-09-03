//
//  productDetailViewController.m
//  todayios
//
//  Created by gump on 8/23/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "productDetailViewController.h"
#import "getProductDetail.h"
#import "ProGalleryCell.h"
#import "productDetailDataSource.h"
#import "productPromotionDataSource.h"
#import "getPromotionList.h"

@interface productDetailViewController ()

@end

@implementation productDetailViewController

- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(refreshProduct:)
                       name:NotifyProductDetail
                     object:nil];
        
        [center addObserver:self
                   selector:@selector(refreshProduct:)
                       name:NotifyProductPromotion
                     object:nil];
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,
                                                                2.0f,
                                                            [CP shareInstance].w * 2 /3, 40.0f)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        
        _priceLabel = [[proiceLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 160.0f)];
        _alreadySeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 0.0f, 120.0f, 40.0f)];
        _alreadySeeLabel.font = [UIFont systemFontOfSize:12.0f];
        
        _baoyouLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 10.0f, 50.0f, 20.0f)];
        _baoyouLabel.text = @"包邮";
        _baoyouLabel.textColor = [UIColor whiteColor];
        _baoyouLabel.backgroundColor = [UIColor greenColor];
        _baoyouLabel.textAlignment = NSTextAlignmentCenter;
        
        _baoyouTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 10.0f, 200.0f, 20.0f)];
        _baoyouTextLabel.textColor = [UIColor grayColor];
        _baoyouTextLabel.adjustsFontSizeToFitWidth = YES;
        
        _yuexiaoliangView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 24.0f, 24.0f)];
        _yuexiaoliangView.image = [UIImage imageNamed:@"icon_cod_volume.png"];
        _yuexiaoliangLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 150.0f, 20.0f)];
        _yuexiaoliangLabel.textColor = [UIColor grayColor];
        
        _7dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(160.0f, 10.0f, 150.0f, 20.0f)];
        _7dayLabel.textColor = [UIColor grayColor];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    self.title = @"商品详情";
    [super viewDidLoad];
    [self.view addSubview:_tableview];
    [[httpManager shareInstance].ProductDetail request:self.pid];
    
    if([[productPromotionDataSource shareInstance] getPromotionList] == nil){
        [[httpManager shareInstance].promotionlist request];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [[CP shareInstance].mytabbar.tabBar setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark self function
-(void)refreshProduct:(id)sender
{
    [_tableview reloadData];
}


#pragma mark ----------tableview dataSource-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int itopcount = 0;
    switch (section) {
        case 0:
        {
            itopcount = 3;
        }
            break;
           case 1:
        {
            itopcount = 2;
        }
            break;
        default:
            break;
    }
    return itopcount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectio
{
    float fh = 20.0f;
    
    switch (sectio) {
        case 0:
        {
            fh = 0.0f;
        }
            break;
            
        default:
            break;
    }
    
    return fh;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"commoncell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    identifier = [NSString stringWithFormat:@"gallerycell"];
                    ProGalleryCell *gallerycell = [tableView dequeueReusableCellWithIdentifier:identifier];
                    if (gallerycell == nil) {
                        gallerycell = [[ProGalleryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                    }
                    
                    [gallerycell refreshCell];
                    
                    return gallerycell;
                }
                    break;
                case 1:
                {
                    [_titleLabel removeFromSuperview];
                    NSString *str = [[productDetailDataSource shareInstance] getTitle];
                    if (str) {
                        _titleLabel.text = str;
                    }
                    
                    [cell.contentView addSubview:_titleLabel];
                }
                    break;
                    case 2:
                {
                    [_priceLabel removeFromSuperview];
                    [_priceLabel setProic:
                     [[productDetailDataSource shareInstance] getPrice]
                             withOldPrice:
                     [[productDetailDataSource shareInstance] getOldPrice]];
                    [cell.contentView addSubview:_priceLabel];
                    
                    [_alreadySeeLabel removeFromSuperview];
                    int isee = [[productDetailDataSource shareInstance] getAlreadyBuy];
                    _alreadySeeLabel.text = [NSString stringWithFormat:@"%d人已经购买",isee];
                    [cell.contentView addSubview:_alreadySeeLabel];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [_baoyouLabel removeFromSuperview];
                    [cell.contentView addSubview:_baoyouLabel];
                    
                    [_baoyouTextLabel removeFromSuperview];
                    NSArray *arr = [[productPromotionDataSource shareInstance] getPromotionList];
                    if (arr) {
                        if (1 < arr.count) {
                            NSDictionary *dic = [arr objectAtIndex:1];
                            if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                                _baoyouTextLabel.text = [dic objectForKey:@"name"];
                            }
                        }
                    }
                    
                    [cell.contentView addSubview:_baoyouTextLabel];
                }
                    break;
                    case 1:
                {
                    [_yuexiaoliangView removeFromSuperview];
                    [cell.contentView addSubview:_yuexiaoliangView];
                    
                    int iv = [[productDetailDataSource shareInstance] getrecentvolume];
                    [_yuexiaoliangLabel removeFromSuperview];
                    _yuexiaoliangLabel.text = [NSString stringWithFormat:@"月销量%d件",iv];
                    [cell.contentView addSubview:_yuexiaoliangLabel];
                    
                    [_7dayLabel removeFromSuperview];
                    NSArray *arr = [[productPromotionDataSource shareInstance] getPromotionList];
                    if (arr) {
                        if (1 < arr.count) {
                            NSDictionary *dic = [arr objectAtIndex:0];
                            if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                                _7dayLabel.text = [dic objectForKey:@"name"];
                            }
                        }
                    }
                    [cell.contentView addSubview:_7dayLabel];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark ---------tableview delegate---------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat iheight = 44.0f;
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    iheight = [CP shareInstance].w;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    return iheight;
}
@end
