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
#import "SVProgressHUD.h"

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
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
                                                                   [CP shareInstance].w,
                                                                   [CP shareInstance].h - NAVIGATION_HEIGHT)];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFooterView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[CP shareInstance].mytabbar.tabBar setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
}
    
    [[listDataSource shareInstance].dataDic removeAllObjects];
    [[httpManager shareInstance].topicList requestWithLimit:_ilimit withPage:_ipage withTopic:_itopic];
    [self.view addSubview:_tableview];
    
    [self setFooterView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshlist:(id)sender{
    
    NSString *strresault = [[listDataSource shareInstance].dataDic objectForKey:@"response_status"];
    if ([strresault isEqualToString:@"true"]) {
        [_tableview reloadData];
        [self removeFooterView];
        [self finishReloadingData];
    }
    else{
        [self removeFooterView];
        [self finishReloadingData];
        [SVProgressHUD showSuccessWithStatus:STR_LOGDALL];
        _tableview.contentInset = UIEdgeInsetsZero;
    }
}

-(void)setFooterView{
	//    UIEdgeInsets test = self.aoView.contentInset;
    // if the footerView is nil, then create it, reset the position of the footer
    CGFloat height = MAX(_tableview.contentSize.height, _tableview.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              _tableview.frame.size.width,
                                              self.view.bounds.size.height);
    }else
	{
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         _tableview.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [_tableview addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView)
	{
        [_refreshFooterView refreshLastUpdatedDate];
    }
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
        listcell.selfctl = self;
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

#pragma mark -----------EGO deletegate-------------------
#pragma mark EGORefreshTableDelegate Methods

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
	
	[self beginToReloadData:aRefreshPos];
	
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}


// if we don't realize this method, it won't display the refresh timestamp
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view
{
	
	return [NSDate date]; // should return date data source was last changed
	
}

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    
    if(aRefreshPos == EGORefreshFooter)
	{
        _ipage++;
        [[httpManager shareInstance].topicList requestWithLimit:_ilimit withPage:_ipage withTopic:_itopic];
    }
	
	// overide, the actual loading data operation is done in the subclass
}

- (void)finishReloadingData{
	
	//  model should call this when its done loading
	_reloading = NO;
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableview];
    }
    [self setFooterView];
    
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

-(void)removeFooterView
{
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	if (_refreshFooterView)
	{
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (_refreshFooterView)
	{
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
        LOG_Test(@"end tabel%@",NSStringFromCGRect(_tableview.frame));
        LOG_Test(@"end view%@",NSStringFromCGRect(self.view.frame));
        
    }
}
@end
