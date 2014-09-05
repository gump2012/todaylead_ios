//
//  BaseViewController.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "BaseViewController.h"
#import "SVProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(HttpError:)
                       name:NotifyHttpRequestError
                     object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        self.view.frame = CGRectMake(0.0, 0.0, 320.0f, 480.0f);
    }

    [self.navigationController setToolbarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark ---------my function---------
-(void)HttpError:(id)seleter
{
    [SVProgressHUD showErrorWithStatus:STR_HTTP_ERROR];
}
@end
