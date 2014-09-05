//
//  productWebViewController.m
//  todayios
//
//  Created by gump on 9/5/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "productWebViewController.h"
#import "getProductHtml.h"
#import "proHtmlDataSource.h"

@interface productWebViewController ()

@end

@implementation productWebViewController

- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(getProductHtml:)
                       name:NotifyProductHtml
                     object:nil];
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_webview];
    [[httpManager shareInstance].productHtml request:self.ipid];
    LOG_Test(@"webview frame %@",NSStringFromCGRect(_webview.frame));
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CP shareInstance].mytabbar.tabBar setHidden:YES];
    //LOG_Test(@"view frame %@",NSStringFromCGRect(self.view.frame));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)getProductHtml:(id)sender
{
    [_webview loadHTMLString:@" " baseURL:nil];
    NSString *str = [[proHtmlDataSource shareInstance] getHtmlString];
    if (![str isEqualToString:@""]) {
        [_webview loadHTMLString:str baseURL:nil];
    }
}

@end
