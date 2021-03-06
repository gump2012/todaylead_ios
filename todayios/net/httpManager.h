//
//  httpManager.h
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import <Foundation/Foundation.h>
@class getShopAdList;
@class getShopTop;
@class getProductDetail;
@class getPromotionList;
@class getProductHtml;
@class getProductReport;
@class getProComment;
@class getProRecommand;
@class getKeywordList;
@class getTopicList;
@class getCategoryList;
@class getCategoryProducts;
@class cartUpdate;
@class getCartProductList;

@interface httpManager : NSObject
{
    getShopAdList *_getshopad;
    getShopTop  *_getshoptop;
    getProductDetail *_ProductDetail;
    getPromotionList *_promotionlist;
    getProductHtml  *_productHtml;
    getProductReport *_proReport;
    getProComment *_proComment;
    getProRecommand *_proRecommand;
    getKeywordList *_keywordList;
    getTopicList    *_topicList;
    getCategoryList *_categoryList;
    getCategoryProducts *_categoryPros;
    cartUpdate *_cartUp;
    getCartProductList *_cartProList;
}

@property(nonatomic,strong) getShopAdList *getshopad;
@property(nonatomic,strong) getShopTop *getshoptop;
@property(nonatomic,strong) getProductDetail *ProductDetail;
@property(nonatomic,strong) getPromotionList *promotionlist;
@property(nonatomic,strong) getProductHtml  *productHtml;
@property(nonatomic,strong) getProductReport *proReport;
@property(nonatomic,strong) getProComment   *proComment;
@property(nonatomic,strong) getProRecommand *proRecommand;
@property(nonatomic,strong) getKeywordList *keywordList;
@property(nonatomic,strong) getTopicList *topicList;
@property(nonatomic,strong) getCategoryList *categoryList;
@property(nonatomic,strong) getCategoryProducts *categoryPros;
@property(nonatomic,strong) cartUpdate *cartUp;
@property(nonatomic,strong) getCartProductList *cartProList;

+ (httpManager *)shareInstance;

@end
