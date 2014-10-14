//
//  httpManager.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "httpManager.h"
#import "getShopAdList.h"
#import "getShopTop.h"
#import "getProductDetail.h"
#import "getPromotionList.h"
#import "getProductHtml.h"
#import "getProductReport.h"
#import "getProComment.h"
#import "getProRecommand.h"
#import "getKeywordList.h"
#import "getTopicList.h"
#import "getCategoryList.h"
#import "getCategoryProducts.h"
#import "cartUpdate.h"
static httpManager * shareins = nil;

@implementation httpManager
@synthesize getshopad = _getshopad;
@synthesize getshoptop = _getshoptop;
@synthesize ProductDetail = _ProductDetail;
@synthesize promotionlist = _promotionlist;
@synthesize productHtml = _productHtml;
@synthesize proReport = _proReport;
@synthesize proComment = _proComment;
@synthesize proRecommand = _proRecommand;
@synthesize keywordList = _keywordList;
@synthesize topicList = _topicList;
@synthesize categoryList = _categoryList;
@synthesize categoryPros = _categoryPros;
@synthesize cartUp = _cartUp;

+ (httpManager *)shareInstance
{
	if (nil == shareins)
    {
		shareins = [[httpManager alloc] init];
	}
	return shareins;
}

-(id)init{
    self = [super init];
    if(self){
        _getshopad = [[getShopAdList alloc] init];
        _getshoptop = [[getShopTop alloc] init];
        _ProductDetail = [[getProductDetail alloc] init];
        _promotionlist = [[getPromotionList alloc] init];
        _productHtml = [[getProductHtml alloc] init];
        _proReport = [[getProductReport alloc] init];
        _proComment = [[getProComment alloc] init];
        _proRecommand = [[getProRecommand alloc] init];
        _keywordList = [[getKeywordList alloc] init];
        _topicList = [[getTopicList alloc] init];
        _categoryList = [[getCategoryList alloc] init];
        _categoryPros = [[getCategoryProducts alloc] init];
        _cartUp = [[cartUpdate alloc] init];
    }
    return self;
}

@end
