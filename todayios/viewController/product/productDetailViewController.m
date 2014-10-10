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
#import "AllSeeCell.h"
#import "baseParameterCell.h"
#import "getProRecommand.h"
#import "priceCell.h"
#import "payButtonView.h"
#import "AttrView.h"
#import "cartDataSource.h"

@interface productDetailViewController ()

@end

@implementation productDetailViewController

- (id)initWithPid:(int)ipid
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
        
        [center addObserver:self
                   selector:@selector(refreshProduct:)
                       name:NotifyProductRecommand
                     object:nil];
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        _baoyouLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 10.0f, 50.0f, 20.0f)];
        _baoyouLabel.text = @"包邮";
        _baoyouLabel.textColor = [UIColor whiteColor];
        _baoyouLabel.backgroundColor = [UIColor greenColor];
        _baoyouLabel.textAlignment = NSTextAlignmentCenter;
        
        _baoyouTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 10.0f, 200.0f, 20.0f)];
        _baoyouTextLabel.textColor = [UIColor grayColor];
        _baoyouTextLabel.adjustsFontSizeToFitWidth = YES;
        
        _paybtnview = [[payButtonView alloc] initWithFrame:CGRectMake(0.0f, [CP shareInstance].h - 50.0f,
                                                                      [CP shareInstance].w,
                                                                      50.0f)];
        __block typeof (self) bself = self;
        _paybtnview.immediateBlock = ^{
            [bself immediateClick];
        };
        
        _paybtnview.addBlock = ^{
            [bself addClick];
        };
        self.pid = ipid;
        
        _attrview = [[AttrView alloc] initWithFrame:CGRectMake(0.0f,
                                                               [CP shareInstance].h,
                                                               [CP shareInstance].w, [CP shareInstance].h)];
        [self.view addSubview:_attrview];
        _attrview.disappearBlock = ^{
            [bself hideAttrView];
        };
        
        _attrview.sureBlock = ^{
            [bself sureAttrView];
        };
        
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
    [self.view addSubview:_paybtnview];
    [[httpManager shareInstance].ProductDetail request:self.pid];
    
    if([[productPromotionDataSource shareInstance] getPromotionList] == nil){
        [[httpManager shareInstance].promotionlist request];
    }
    
    [[httpManager shareInstance].proRecommand request:self.pid];
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
    if ([proCommentDataSource shareInstance].commentType == COMMENT_READYSHOW) {
        [proCommentDataSource shareInstance].commentType = COMMENT_SHOW;
    }
    
    [_tableview reloadData];
}

-(void)immediateClick{
    [cartDataSource shareInstance].ibuyBtnType = BUYBTNTP_IM;
    
    [_attrview refreshView];
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.5];
    [self.navigationController setNavigationBarHidden:YES];
    
    [_attrview setFrame:CGRectMake(0.0,
                                   0.0f,
                                   [CP shareInstance].w, [CP shareInstance].h)];
    
    [UIView commitAnimations];
}

-(void)addClick{
    [cartDataSource shareInstance].ibuyBtnType = BUYBTNTP_ADD;
    
    [_attrview refreshView];
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.5];
    [self.navigationController setNavigationBarHidden:YES];
    
    [_attrview setFrame:CGRectMake(0.0,
                                   0.0f,
                                   [CP shareInstance].w, [CP shareInstance].h)];
    
    [UIView commitAnimations];
}

-(void)hideAttrView{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.5];
    [self.navigationController setNavigationBarHidden:NO];
    [_attrview setFrame:CGRectMake(0.0f,
                                   [CP shareInstance].h,
                                   [CP shareInstance].w, [CP shareInstance].h)];
    
    [UIView commitAnimations];
}

-(void)sureAttrView{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.5];
    [self.navigationController setNavigationBarHidden:NO];
    [_attrview setFrame:CGRectMake(0.0f,
                                   [CP shareInstance].h,
                                   [CP shareInstance].w, [CP shareInstance].h)];
    
    [UIView commitAnimations];
    
    if ([cartDataSource shareInstance].ibuyBtnType == BUYBTNTP_ADD) {
        
    }
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
        case 3:{
            itopcount = 1;
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
                    identifier = [NSString stringWithFormat:@"pricecell"];
                    priceCell *price = [tableView dequeueReusableCellWithIdentifier:identifier];
                    
                    if (price == nil) {
                        price = [[priceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                    }
                    
                    [price refreshCell];
                    
                    return price;
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
                        identifier = [NSString stringWithFormat:@"baseParacell"];
                        baseParameterCell *paracell = [tableView dequeueReusableCellWithIdentifier:identifier];
                        if (paracell == nil) {
                            paracell = [[baseParameterCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:identifier];
                            paracell.clickblock = ^{
                                if ([productDetailDataSource shareInstance].ibaseAttr == BASEATTR_HIDE) {
                                    [productDetailDataSource shareInstance].ibaseAttr = BASEATTR_SHOW;
                                }else if([productDetailDataSource shareInstance].ibaseAttr == BASEATTR_SHOW){
                                    [productDetailDataSource shareInstance].ibaseAttr = BASEATTR_HIDE;
                                }
                                
                                [_tableview reloadData];
                            };
                        }
                        
                        [paracell refreshCell];
                        
                        return paracell;
                    }
                        break;
                    default:
                        break;
                }
        }
            break;
        case 3:{
            identifier = [NSString stringWithFormat:@"allseecell"];
            AllSeeCell *allsee = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (allsee == nil) {
                allsee = [[AllSeeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                allsee.selfctl = self;
            }
            
            [allsee refreshCell];
            
            return allsee;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
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
                case 3:{
                    switch ([productDetailDataSource shareInstance].ibaseAttr) {
                        case BASEATTR_SHOW:{
                            iheight += 60.0f;
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
            case 3:
        {
            iheight = 160.0f;
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
