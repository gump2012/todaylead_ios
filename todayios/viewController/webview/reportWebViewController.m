//
//  reportWebViewController.m
//  todayios
//
//  Created by gump on 9/5/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "reportWebViewController.h"
#import "getProductReport.h"
#import "proReportDataSource.h"

@interface reportWebViewController ()

@end

@implementation reportWebViewController

- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(getProductHtml:)
                       name:NotifyProductReport
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
    [[httpManager shareInstance].proReport request:self.ipid];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)getProductHtml:(id)sender
{
    [_webview loadHTMLString:@" " baseURL:nil];
    NSString *str = [[proReportDataSource shareInstance] getHtmlString];
    if (![str isEqualToString:@""]) {
        [_webview loadHTMLString:str baseURL:nil];
    }
}

@end
