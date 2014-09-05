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
    shopview.title = @"今日头牌";
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"商城" image:nil tag:1];
    shopview.tabBarItem = item;
    UINavigationController *navshop = [[UINavigationController alloc] initWithRootViewController:shopview];
    navshop.tabBarItem.title = @"商城";
    [navshop.tabBarItem setImage:[UIImage imageNamed:@"icon_bottom_cod_n.png"]];
    [navshop.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon_bottom_cod_c.png"]];
    
    categoryViewController *categoryview = [[categoryViewController alloc] init];
    categoryview.title = @"分类";
    item = [[UITabBarItem alloc] initWithTitle:@"分类" image:nil tag:2];
    categoryview.tabBarItem = item;
    UINavigationController *navcategory = [[UINavigationController alloc] initWithRootViewController:categoryview];
    [navcategory.tabBarItem setImage:[UIImage imageNamed:@"icon_bottom_category_n.png"]];
    [navcategory.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon_bottom_category_c.png"]];
    
    paymentViewController *paymentview = [[paymentViewController alloc] init];
    paymentview.title = @"购物车";
    item = [[UITabBarItem alloc] initWithTitle:@"购物车" image:nil tag:3];
    paymentview.tabBarItem = item;
    UINavigationController *navpayment = [[UINavigationController alloc] initWithRootViewController:paymentview];
    [navpayment.tabBarItem setImage:[UIImage imageNamed:@"icon_bottom_shopcar_n.png"]];
    [navpayment.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon_bottom_shopcar_c.png"]];
    
    meViewController *meview = [[meViewController alloc] init];
    meview.title = @"我";
    item = [[UITabBarItem alloc] initWithTitle:@"我" image:nil tag:4];
    meview.tabBarItem = item;
    UINavigationController *navme = [[UINavigationController alloc] initWithRootViewController:meview];
    [navme.tabBarItem setImage:[UIImage imageNamed:@"icon_bottom_my_n.png"]];
    [navme.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon_bottom_my_c.png"]];
    
    UITabBarController *tabview = [[UITabBarController alloc] init];
    tabview.viewControllers = [NSArray arrayWithObjects:navshop, navcategory,navpayment,navme,nil];
    tabview.tabBar.selectedImageTintColor = [UIColor redColor];
    [CP shareInstance].mytabbar = tabview;
    window.rootViewController = tabview;
    [window makeKeyAndVisible];
}

@end
