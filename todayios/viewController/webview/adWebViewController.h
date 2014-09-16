//
//  adWebViewController.h
//  todayios
//
//  Created by gump on 9/15/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseViewController.h"

@interface adWebViewController : BaseViewController<UIWebViewDelegate>
{
    UIWebView *_webview;
}

@property(nonatomic,strong) NSMutableDictionary *dataDic;

@end
