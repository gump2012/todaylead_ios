//
//  viewStart.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "viewStart.h"
#import "shopViewController.h"
#import "categoryViewController.h"
#import "paymentViewController.h"
#import "meViewController.h"

static viewStart * shareins = nil;

@implementation viewStart

+ (viewStart *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[viewStart alloc] init];
	}
	return shareins;
}

- (void)start:(UIWindow *)window
{
    shopViewController *shopview = [[shopViewController alloc] init];
    shopview.title = @"商城";
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"商城" image:nil tag:1];
    shopview.tabBarItem = item;
    shopview.navigationController.navigationBar.hidden = NO;
    UINavigationController *navshop = [[UINavigationController alloc] initWithRootViewController:shopview];
    
    categoryViewController *categoryview = [[categoryViewController alloc] init];
    categoryview.title = @"分类";
    item = [[UITabBarItem alloc] initWithTitle:@"分类" image:nil tag:2];
    categoryview.tabBarItem = item;
    UINavigationController *navcategory = [[UINavigationController alloc] initWithRootViewController:categoryview];
    
    paymentViewController *paymentview = [[paymentViewController alloc] init];
    paymentview.title = @"购物车";
    item = [[UITabBarItem alloc] initWithTitle:@"购物车" image:nil tag:3];
    paymentview.tabBarItem = item;
    UINavigationController *navpayment = [[UINavigationController alloc] initWithRootViewController:paymentview];
    
    meViewController *meview = [[meViewController alloc] init];
    meview.title = @"我";
    item = [[UITabBarItem alloc] initWithTitle:@"我" image:nil tag:4];
    meview.tabBarItem = item;
    UINavigationController *navme = [[UINavigationController alloc] initWithRootViewController:meview];
    
    UITabBarController *tabview = [[UITabBarController alloc] init];
    tabview.viewControllers = [NSArray arrayWithObjects:navshop, navcategory,navpayment,navme,nil];
    window.rootViewController = tabview;
    [window makeKeyAndVisible];
}

@end
