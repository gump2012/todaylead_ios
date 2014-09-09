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
#import "UIImageView+WebCache.h"
#import "productWebViewController.h"
#import "reportWebViewController.h"
#import "getProComment.h"
#import "proCommentDataSource.h"
#import "proCommentCellTableViewCell.h"
#import "yuexiaoliangCell.h"
#import "proNameCell.h"

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
        
        [center addObserver:self
                   selector:@selector(getComment:)
                       name:NotifyProductComment
                     object:nil];
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
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
    [super viewWillAppear:animated];
    [[CP shareInstance].mytabbar.tabBar setHidden:YES];
    //LOG_Test(@"view frame %@",NSStringFromCGRect(self.view.frame));
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

-(void)getComment:(id)sender
{
    [proCommentDataSource shareInstance].commentType = COMMENT_SHOW;
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
        case 2:
        {
            itopcount = 4;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
                    identifier = [NSString stringWithFormat:@"pronamecell"];
                    proNameCell *namecell = [tableView dequeueReusableCellWithIdentifier:identifier];
                    
                    if (namecell == nil) {
                        namecell = [[proNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                    }
                    
                    [namecell refreshCell];
                    
                    return namecell;
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
                    
                    cell.textLabel.text = @"";
                    cell.imageView.image = nil;
                    cell.accessoryType = UITableViewCellAccessoryNone;
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
                    cell.textLabel.text = @"";
                    cell.imageView.image = nil;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    [cell.contentView addSubview:_baoyouTextLabel];
                }
                    break;
                    case 1:
                {
                    identifier = [NSString stringWithFormat:@"yuexiaoliangcell"];
                    yuexiaoliangCell *yuecell = [tableView dequeueReusableCellWithIdentifier:identifier];
                    if (yuecell == nil) {
                        yuecell = [[yuexiaoliangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                    }
                    
                    [yuecell refreshCell];
                    
                    return yuecell;
                }
                    break;
                default:
                    break;
            }
        }
            break;
            case 2:
        {
            
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell.imageView.image = [UIImage imageNamed:@"icon_cod_webdetail.png"];
                        cell.textLabel.text = @"图文详情";
                    }
                        break;
                    case 1:
                    {
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell.imageView.image = [UIImage imageNamed:@"icon_pratice_report.png"];
                        cell.textLabel.text = @"体验报告";
                    }
                        break;
                    case 2:
                    {
                        identifier = [NSString stringWithFormat:@"commentcell"];
                        proCommentCell *commentcell = [tableView dequeueReusableCellWithIdentifier:identifier];
                        if (commentcell == nil) {
                            commentcell = [[proCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:identifier];
                            commentcell.clickblock = ^{
                                switch ([proCommentDataSource shareInstance].commentType) {
                                    case COMMENT_HIDE:
                                    {
                                        [[httpManager shareInstance].proComment request:self.pid];
                                        [proCommentDataSource shareInstance].commentType = COMMENT_READYSHOW;
                                    }
                                        break;
                                        case COMMENT_READYSHOW:
                                    {
                                        [proCommentDataSource shareInstance].commentType = COMMENT_HIDE;
                                    }
                                        break;
                                    case COMMENT_SHOW:{
                                        [proCommentDataSource shareInstance].commentType = COMMENT_HIDE;
                                    }
                                        break;
                                    default:
                                        break;
                                }
                                
                                [_tableview reloadData];
                            };
                        }
                        
                        [commentcell refreshCell];
                        
                        return commentcell;
                    }
                        break;
                    case 3:
                    {
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell.imageView.image = [UIImage imageNamed:@"icon_cod_commonparam.png"];
                        cell.textLabel.text = @"基本参数";
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
    return 3;
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
        case 2:{
            switch (indexPath.row) {
                case 2:
                {
                    switch ([proCommentDataSource shareInstance].commentType) {
                        case COMMENT_READYSHOW:
                        {
                            iheight = 88.0f;
                        }
                            break;
                        case COMMENT_SHOW:{
                            NSArray *arr = [[proCommentDataSource shareInstance] getArrData];
                            if (arr) {
                                iheight += 64.0f * arr.count;
                            }
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
        }
            break;
        default:
            break;
    }
    return iheight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    productWebViewController *webview = [[productWebViewController alloc] init];
                    webview.ipid = self.pid;
                    [self.navigationController pushViewController:webview animated:YES];
                }
                    break;
                case 1:
                {
                    reportWebViewController *reportview = [[reportWebViewController alloc] init];
                    reportview.ipid = self.pid;
                    [self.navigationController pushViewController:reportview animated:YES];
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
}
@end
