//
//  adWebViewController.m
//  todayios
//
//  Created by gump on 9/15/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "adWebViewController.h"
#import "productDetailViewController.h"

@interface adWebViewController ()

@end

@implementation adWebViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.dataDic = [[NSMutableDictionary alloc] init];
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CP shareInstance].w, [CP shareInstance].h)];
        _webview.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_webview];
    [[CP shareInstance].mytabbar.tabBar setHidden:YES];
    NSString *strurl = [self.dataDic objectForKey:@"link"];
    if (strurl) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strurl]];
        [_webview loadRequest:request];
    }
    NSDictionary *prarm = [self.dataDic objectForKey:@"param"];
    if (prarm) {
        self.title = [prarm objectForKey:@"name"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    LOG_Test(@"paht : %@",request.mainDocumentURL.relativePath);
    if ([self analysisHyperlinks:request.mainDocumentURL.relativePath]) {
        return false;
    }
    return true;
}

-(BOOL)analysisHyperlinks:(NSString *)strurl
{
    NSRange range = [strurl rangeOfString:@"product"];
    if (range.length > 0) {
        NSString *strpid = [strurl substringFromIndex:(range.location + range.length)];
        if (strpid) {
            int ipid = [strpid intValue];
            
            productDetailViewController *detailview = [[productDetailViewController alloc] initWithPid:ipid];
            [self.navigationController pushViewController:detailview animated:YES];
            
            return TRUE;
        }
    }
    
    return FALSE;
}

@end
